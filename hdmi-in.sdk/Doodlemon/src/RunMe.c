/************************************************************************/
/*																		*/
/*	video_demo.c	--	ZYBO Video demonstration 						*/
/*																		*/
/************************************************************************/
/*	Author: Sam Bobrowicz												*/
/*	Copyright 2015, Digilent Inc.										*/
/************************************************************************/
/*  Module Description: 												*/
/*																		*/
/*		This file contains code for running a demonstration of the		*/
/*		Video input and output capabilities on the ZYBO. It is a good	*/
/*		example of how to properly use the display_ctrl and				*/
/*		video_capture drivers.											*/
/*																		*/
/*																		*/
/************************************************************************/
/*  Revision History:													*/
/* 																		*/
/*		11/25/2015(SamB): Created										*/
/*																		*/
/************************************************************************/

/* ------------------------------------------------------------ */
/*				Include File Definitions						*/
/* ------------------------------------------------------------ */

/* Standard */
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

/* Xilinx */
#include "xparameters.h"
#include "xuartps.h"
#include "xil_types.h"
#include "xil_cache.h"
#include "xscugic.h"
#include "xgpio.h"
#include "xil_exception.h"
#include "xil_printf.h"
#include "xtime_l.h"

/* Video Demo */
#include "video_capture/video_capture.h"
#include "display_ctrl/display_ctrl.h"
#include "timer_ps/timer_ps.h"

/* Headerfiles that contain game logic */
#include "game.h"
#include "score.h"
#include "PowerUps.h"

/* SDcard */
#include "SDcard/platform.h"
#include "sleep.h"
#include "xil_io.h"
#include "xsdps.h"
#include "SDcard/ff.h"

/* platform.c */
#include "interrupt/intc.h"
#include "SDcard/platform_config.h"

/* Files containing the interrupt logic. */
#include "interrupt/interrupts.h"

/* Arrays containing the RGB values for the images used in the game */
#include "Images/Background.h"
#include "Images/Doodlemon.h"
#include "Images/alphabet.h"
#include "Images/Gameover.h"
#include "Images/jumper.h"
#include "Images/platformimg.h"
#include "Images/Kirby.h"
#include "Images/Header.h"
#include "Images/numberArray.h"
#include "Images/whiteLine.h"
#include "Images/powerupsImg.h"
#include "powerups.h"
#include "math.h"


/* ------------------------------------------------------------ */
/*						   Defines				        		*/
/* ------------------------------------------------------------ */
#define DYNCLK_BASEADDR XPAR_AXI_DYNCLK_0_BASEADDR
#define VGA_VDMA_ID XPAR_AXIVDMA_0_DEVICE_ID
#define DISP_VTC_ID XPAR_VTC_0_DEVICE_ID
#define VID_VTC_ID XPAR_VTC_1_DEVICE_ID
#define VID_GPIO_ID XPAR_AXI_GPIO_VIDEO_DEVICE_ID
#define VID_VTC_IRPT_ID XPS_FPGA3_INT_ID
#define VID_GPIO_IRPT_ID XPS_FPGA4_INT_ID
#define SCU_TIMER_ID XPAR_SCUTIMER_DEVICE_ID
#define UART_BASEADDR XPAR_PS7_UART_1_BASEADDR
#define DEMO_MAX_FRAME (1920*1080*3)
#define DEMO_STRIDE (1920*3)
#define DEMO_START_ON_DET 1

/* ------------------------------------------------------------ */
/*				Global Variables								*/
/* ------------------------------------------------------------ */
//Framebuffers for video data
char fRefresh; //flag used to trigger a refresh of the Menu on video detect
u8 frameBuf[DISPLAY_NUM_FRAMES][DEMO_MAX_FRAME];
u8 *pFrames[DISPLAY_NUM_FRAMES]; //array of pointers to the frame buffers
DisplayCtrl dispCtrl;

//Interrupt vector table
VideoCapture videoCapt;
const ivt_t ivt[] = {
	videoGpioIvt(VID_GPIO_IRPT_ID, &videoCapt),
	videoVtcIvt(VID_VTC_IRPT_ID, &(videoCapt.vtc))
};
XAxiVdma vdma;


int resetf = 1;					//Reset flag, when 1 the game initializes game components and reset positions etc. for new  game.
int frame;						//Index of the current frame that is being displayed.
int counter = 0;				//Counter that is used to control the jumping animation, see function "Move" to see more.

/*
 * In the alphabet.h file in folder images. Each letter is enumerated so it corresponds
 * to a letter of the array. Each letter is an array.
 */
u8 HighscoreWord[] = {H, I, G, H, S, C, O, R, E};	//This spells highscore on the screen.
u8 Score[] = {S, C, O ,R, E};
u8 Your[] = {Y, O, U, R};
u8 Average[] = {A, V, E, R, A, G, E};

/*
 * These structs are used to move the sprite and platforms
 * and check for collision in the "Move" function.
 */
struct Block jumperBlock = {JUMPER_WIDTH, JUMPER_HEIGHT, (490*DEMO_STRIDE), 2830, 0};
struct Block *jumper = &jumperBlock;
struct Block platformBlock[PLATFORM_AMOUNT];
struct Block *platform[PLATFORM_AMOUNT];


/************ SD card parameters ************/
static FATFS FS_instance;			// File System instance
static FIL file1;					// File instance
FRESULT result;						// FRESULT variable
char FileName[32];					// File name
static char *Log_File; 				// pointer to the log
static const char *Path = "0:/";	//  string pointer to the logical drive number
unsigned int BytesWr;				// Bytes written
int j = 0;							// file name index
uint stringlength = 0;

char c;
int x = 0;
char SDArray[4];
/************ SD card parameters ************/

/* ------------------------------------------------------------ */
/*						 Prototypes		    					*/
/* ------------------------------------------------------------ */

void DemoInitialize();
void DemoISR(void *callBackRef, void *pVideo);

/* ------------------------------------------------------------ */
/*						     Main		    					*/
/* ------------------------------------------------------------ */
int main(void) {
	DemoInitialize();
	DisplaySetMode(&dispCtrl, &VMODE_1920x1080);
	DisplayStart(&dispCtrl);

	int status;
	//----------------------------------------------------
	// INITIALIZE THE PERIPHERALS & SET DIRECTIONS OF GPIO
	//----------------------------------------------------
	// Initialise Push Buttons
	status = XGpio_Initialize(&BTNInst, BTNS_DEVICE_ID);
	if(status != XST_SUCCESS) return XST_FAILURE;
	// Set all buttons direction to inputs
	XGpio_SetDataDirection(&BTNInst, 1, 0xFF);
	// Initialize interrupt controller
	status = IntcInitFunction(INTC_DEVICE_ID, &BTNInst);
	if(status != XST_SUCCESS) return XST_FAILURE;
	DemoStartGame();
	return 0;
}






/* ------------------------------------------------------------ */
/*						 Functions		    					*/
/* ------------------------------------------------------------ */

/*
 * Reads the highscore from the SD Card using SDRead().
 * If reset flag is set to 1, it resets the game to default.
 * Default means that the sprite is in the middle of the screen,
 * Platforms have their speed set to the default speed,
 * Score is set to default.
 * Highscore is updated.
 * Halts and wait until user input.
 * Game then starts.
 */
void DemoStartGame() {

	SDRead();

	while(1) {
		if(resetf == 1) {
			ResetGame(frameBuf[0]);
			Move(frameBuf[0]);
			Print(frameBuf[0]);
			Xil_DCacheFlushRange((unsigned int)frameBuf[0], DEMO_MAX_FRAME);
			DisplayChangeFrame(&dispCtrl, 0);
		}
		if(btn_value == 4)
			jumperDeathState = ALIVE;
		while(jumperDeathState == ALIVE) {
			if (frame >= DISPLAY_NUM_FRAMES) {
				frame = 0;
			}
			PrintBackground(frameBuf[frame], 1920, 1080, 5760, Background);
			Move(frameBuf[frame]);
			Print(frameBuf[frame]);
			Xil_DCacheFlushRange((unsigned int)frameBuf[frame], DEMO_MAX_FRAME);
			DisplayChangeFrame(&dispCtrl, frame);
			frame = dispCtrl.curFrame +1;
			resetf = 1;
		}
	}
}

/*
 * This function is called in DemoStartGame and it resets the game environment
 * Draws background image.
 * Generates random x-coordinate for the platforms.
 * Distance between platforms on the y-axis is 576.
 * Draws the newly generated platforms and the sprite.
 */
void ResetGame(u8 *frame) {
	for(int i = 0; i < 3; i++) {
		PrintBackground(frameBuf[i], 1920, 1080, 5760, Background);
		PrintBackground(frameBuf[i], 150, 1080, 5760, HeaderImg);
	}
	int random_x;
	int random_y = 2;
	for(int i = 0; i < PLATFORM_AMOUNT; i++) {
		random_x = rand() % 939 + 0;
		random_y += 576;
		platformBlock[i].height = PLATFORM_HEIGHT;
		platformBlock[i].width = PLATFORM_WIDTH;
		platformBlock[i].x = random_x*DEMO_STRIDE;
		platformBlock[i].y = random_y;
		platformBlock[i].velocity = LEFT;
		platform[i] = &platformBlock[i];
	}
	PowerUp.x = platformBlock[4].x + 40*DEMO_STRIDE;
	PowerUp.y = platformBlock[4].y - 60;
	PowerUp.type = WumpaFruit;
	jumperBlock.x = (540-(JUMPER_WIDTH/2))*DEMO_STRIDE;
	jumperBlock.y = 3802;
	PrintScore(frame, ones, tens, hundreds, thousands, 500, 3299);
	resetScore();
	platformspeed = 6;
	jumperVelocity = GROUND;
	resetf = 0;
}

/*
 * Prints the entire game when playing ( Background, Platforms, Sprite and Score)
 */
void Print(u8 *frame) {

	for(int j = 0; j < PLATFORM_AMOUNT; j++) {
		PrintPlatform(frame, DEMO_STRIDE, platformImg, PLATFORM_WIDTH, PLATFORM_HEIGHT, platformBlock[j]);
	}
	ImagePrint(frame, PowerUpImg[PowerUp.type], platformBlock[4].x, platformBlock[4].y, 60, 60);
	PrintBackground(frame, 150, 1080, 5760, HeaderImg);
	if (jumperDeathState == DEAD){
		ImagePrint(frameBuf[0], Gameover, 0, 2101, 1080, 240);
		ImagePrint(frameBuf[1], Gameover, 0, 2101, 1080, 240);
		ImagePrint(frameBuf[2], Gameover, 0, 2101, 1080, 240);
	}
	ImagePrint(frame, powerupsImg[PowerUp.type], PowerUp.x, PowerUp.y, 60, 60);
	PrintScore(frame, ones, tens, hundreds, thousands, 700, 470);
	PrintScore(frame, highones, hightens, highhundreds, highthousands, 700, 560);
	PrintScore(frame, avgones, avgtens, avghundreds, avgthousands, 700, 650);
	PrintWord(frame, Your, 1050, 470, 4);
	PrintWord(frame, Score, 1150, 470, 5);
	PrintWord(frame, HighscoreWord, 1050, 560, 9);
	PrintWord(frame, Average, 1050, 650, 7);
	PrintWord(frame, Score, 1150, 650, 5);


	switch(sprite_value) {
	case KIRBY:
		switch(jumperDir) {
		case UL:
			ImagePrint(frame, kirbyUpLeft, jumperBlock.x, jumperBlock.y, 100, 100);
			break;
		case UR:
			ImagePrint(frame, kirbyUpRight, jumperBlock.x, jumperBlock.y, 100, 100);
			break;
		case DL:
			ImagePrint(frame, kirbyFallLeft, jumperBlock.x, jumperBlock.y, 100, 100);
			break;
		case DR:
			ImagePrint(frame, kirbyFallRight, jumperBlock.x, jumperBlock.y, 100, 100);
			break;
		default:
		break;
	}
		break;
		case DOODLE:
			switch(jumperDir) {
			case UL:
				ImagePrint(frame, doodlelongleft, jumperBlock.x, jumperBlock.y, 100, 100);
				break;
			case UR:
				ImagePrint(frame, doodlelongright, jumperBlock.x, jumperBlock.y, 100, 100);
				break;
			case DL:
				ImagePrint(frame, doodleshortleft, jumperBlock.x, jumperBlock.y, 100, 100);
				break;
			case DR:
				ImagePrint(frame, doodleshortright, jumperBlock.x, jumperBlock.y, 100, 100);
				break;
			default:
			break;
		}
		break;
		case THEORIGINAL:
			ImagePrint(frame, jumperImg, jumperBlock.x, jumperBlock.y, 100, 100);
	}
}

/*
 * Prints an image without white background
 */
void ImagePrint(u8 *frame, u8 *array,  u32 x, u32 y, int imgH, int imgW) {
	int cor = x+y;
	int arrayCounter = 0;
	for(int i = 0; i < imgH; i++) {
		for(int j = 0; j<imgW*3; j+=3) {
			if (!(array[arrayCounter] == 255 && array[arrayCounter+1] == 255 && array[arrayCounter+2] == 255)){
			frame[cor + j + 1] = array[arrayCounter + 0];
			frame[cor + j + 2] = array[arrayCounter + 1];
			frame[cor + j + 0] = array[arrayCounter + 2];
			arrayCounter += 3;
			} else {
				arrayCounter+=3;
			}
		}
		cor = cor + DEMO_STRIDE;
		if(cor > leftWall) {
			cor = cor - DEMO_MAX_FRAME;
		}
		if(cor < rightWall){
			cor = cor + DEMO_MAX_FRAME;
		}

	}
}

/*
 * Prints the background of the game, used in master function Print.
 */
void PrintBackground(u8 *frame, u32 width, u32 height, u32 stride, u8 *pic)
{
	u32 lineStart = 2;
	u32 lineStartPic = 0;

	for(int ycoi = 0; ycoi < height; ycoi++)
	{
		memcpy(frame + lineStart, pic+lineStartPic, width*3);
		lineStart += stride;
		lineStartPic+= width*3;
	}
}

/*
 * Prints a word using a predefined array of letters
 * that can be found in Images/alphabet.h
 */
void PrintWord(u8 *frame, u8 *array, u32 x, u32 y, u8 wordLength) {
	int cor = x*DEMO_STRIDE+y;
	int arrayCounter = 0;
	for(int i = 0; i < wordLength; i++) {
		for(int j = 0; j < 20; j++) {
			for(int k = 0; k < 60; k+=3) {
				if(alphabet[array[i]][arrayCounter + 0] < 100 &&
					alphabet[array[i]][arrayCounter + 1] < 100 &&
					alphabet[array[i]][arrayCounter + 2] < 100) {
					frame[cor + k + 1] = alphabet[array[i]][arrayCounter + 0];
					frame[cor + k + 2] = alphabet[array[i]][arrayCounter + 1];
					frame[cor + k + 0] = alphabet[array[i]][arrayCounter + 2];
					arrayCounter+=3;
				} else {
					arrayCounter+=3;
				}
			}
			cor = cor + DEMO_STRIDE;
		}
		arrayCounter = 0;
		cor = cor - (40*DEMO_STRIDE);
	}
}

/*
 * Prints a platform given its struct and the image values.
 */
void PrintPlatform(u8 *frame, u32 stride,u8 *pic,  u32 picWidth, u32 picHeight, struct Block block)
{
	int lineStart = 0;
	int lineStartPic = 0;
		for(int ycoi = 0; ycoi < picHeight; ycoi++)
		{
			memcpy(frame+block.x+block.y + lineStart, pic+lineStartPic, picWidth*3);
			lineStart += stride;
			lineStartPic += picWidth*3;
		}
}

/*
 * Prints 4 numbers, first represents 1000, then 100, then 10, then 1's. Used to print:
 * Current Score.
 * Highscore.
 * Average Score.
 */
void PrintScore(u8 *frame, u8 ones, u8 tens, u8 hundreds, u8 thousands, u32 x, u32 y) {
	ImagePrint(frame, numArray[thousands], (x+63)*DEMO_STRIDE, y, 20, 20);
	ImagePrint(frame, numArray[hundreds], (x+42)*DEMO_STRIDE, y, 20, 20);
	ImagePrint(frame, numArray[tens], (x+21)*DEMO_STRIDE, y, 20, 20);
	ImagePrint(frame, numArray[ones], x*DEMO_STRIDE, y, 20, 20);
}


/*
 * Jakub implementer her.
 */


void Move(u8 *frame) {
	MoveSprite(frame);
	MovePlatform(frame);
	DeathDetection(jumperBlock.x, jumperBlock.y);
}



void MoveSprite(u8 *frame) {
	/*----------------------------------------------------*/
	/* Left and right movement using the btn_value from   */
	/* the Zybo buttons.								  */
	/*----------------------------------------------------*/
	u32 nunchuck_value = Xil_In32(XPAR_NUNCHUCK_0_S00_AXI_BASEADDR);
	xil_printf("%d\n\r", nunchuck_value);
	if(nunchuck_value < 25) {
		jumperBlock.x += DEMO_STRIDE*21;
		if (jumperBlock.velocity < 0)
			jumperDir = DL;
		else
			jumperDir = UL;
	}
	else if(nunchuck_value > 185) {
		jumperBlock.x -= DEMO_STRIDE*21;
		if (jumperBlock.velocity < 0)
			jumperDir = DR;
		else
			jumperDir = UR;
	}
	else if(nunchuck_value < 50) {
		jumperBlock.x += DEMO_STRIDE*18;
		if (jumperBlock.velocity < 0)
			jumperDir = DL;
		else
			jumperDir = UL;
	}
	else if(nunchuck_value > 160) {
		jumperBlock.x -= DEMO_STRIDE*18;
		if (jumperBlock.velocity < 0)
			jumperDir = DR;
		else
			jumperDir = UR;
	}
	else if(nunchuck_value < 75) {
		jumperBlock.x += DEMO_STRIDE*12;
		if (jumperBlock.velocity < 0)
			jumperDir = DL;
		else
			jumperDir = UL;
	}
	else if(nunchuck_value > 135) {
		jumperBlock.x -= DEMO_STRIDE*12;
		if (jumperBlock.velocity < 0)
			jumperDir = DR;
		else
			jumperDir = UR;
	}
	else if(nunchuck_value < 100) {
		jumperBlock.x += DEMO_STRIDE*6;
		if (jumperBlock.velocity < 0)
			jumperDir = DL;
		else
			jumperDir = UL;
	}
	else if(nunchuck_value > 110) {
		jumperBlock.x -= DEMO_STRIDE*6;
		if (jumperBlock.velocity < 0)
			jumperDir = DR;
		else
			jumperDir = UR;
	}







	switch(btn_value) {
	case 1:
		jumperBlock.x = jumperBlock.x - DEMO_STRIDE*21;
		if (jumperBlock.velocity < 0)
			jumperDir = DR;
		else
			jumperDir = UR;
		break;
	case 2:
		break;
	case 4:
		break;
	case 8:
		jumperBlock.x += DEMO_STRIDE*21;
		if (jumperBlock.velocity < 0)
			jumperDir = DL;
		else
			jumperDir = UL;
		break;
	default:
		break;
	}
	/*****************************************************/
	/********** Left right movement ends here ************/
	/*****************************************************/





	/*----------------------------------------------------*/
	/* Sprite up and down movement						  */
	/*----------------------------------------------------*/
	switch(jumperVelocity) {
	/* When Sprite hits a platform */
	case GROUND:
		counter = 0;
		/* Which way the Sprite faces */
		switch(jumperDir) {
		case DR:
			jumperDir = UR;
			break;
		case DL:
			jumperDir = UL;
			break;
		default:
			break;
		}
		jumperBlock.velocity = 84;
		jumperVelocity = AIR;
		break;
	/* When Sprite leaves platform and enters air state. */
	case AIR:
		/*
		 * When Sprite is the top part of the jump, this if statement is to reduce time the sprite
		 * stands still in the air.
		 */
		if(jumperBlock.velocity < 13 && -13 < jumperBlock.velocity) {
			if(counter%2==0)
				jumperBlock.velocity-=JUMPER_GRAVITY;
		}
		/* Global counter that counts to 6 and then reduce upward velocity until it hits another block */
		else if(counter%6==0) {
				jumperBlock.velocity-=JUMPER_GRAVITY;
		}

		jumperBlock.y -= jumperBlock.velocity;
		/* Falling portion of the jump, checks if the Sprite hits a platform using ColissionDetect */
		if(jumperBlock.velocity < 0) {
			/* Which way the Sprite faces */
			switch(jumperDir) {
			case UR:
				jumperDir = DR;
				break;
			case UL:
				jumperDir = DL;
				break;
			default:
			break;
			}
			/* Colission Detection */
			for(int k = 0; k < PLATFORM_AMOUNT; k++) {

				if((ColissionDetection(jumper, platform[k]))==1) {
					if(k == 4) {
						switch(PowerUp.type) {
						case Skull:
							currentScoreCounter -= 10;
							break;
						case WumpaFruit:
							currentScoreCounter += 10;
							break;
						case Clock:
							platformspeed -= 6;
						}
					}
					jumperVelocity = GROUND;
				}
			}
		}
		/* Counter that is used to reduce jumper velocity is incremented every loop */
		counter++;
		break;
	}
	/*****************************************************/
	/************ Up down movement ends here *************/
	/*****************************************************/
}

/*
 * Controls the movement of the platforms.
 */
void MovePlatform(u8 *frame) {
	for(int j = 0; j < PLATFORM_AMOUNT; j++) {
		platformBlock[j].y+=platformspeed;
		if (currentScoreCounter > 50 ){
			if (platformBlock[j].velocity == LEFT) {
					platformBlock[j].x += DEMO_STRIDE;
				} else if (platformBlock[j].velocity == RIGHT) {
					platformBlock[j].x -= DEMO_STRIDE;
				}
				if (platformBlock[j].x+platformBlock[j].y > DEMO_MAX_FRAME-(140*DEMO_STRIDE)) {
					platformBlock[j].x -= DEMO_STRIDE;
					platformBlock[j].velocity = RIGHT;
				} else if (platformBlock[j].x+platformBlock[j].y < 0) {
					platformBlock[j].x += DEMO_STRIDE;
					platformBlock[j].velocity = LEFT;
				}
		}



		if(platformBlock[j].y >= DEMO_STRIDE) {
		Increment();
		platformBlock[j].y = 2;
		platformBlock[j].x = DEMO_STRIDE*(rand() % 900 + 0);
		}
	}
}

/*
 * Check if a given platform collides with the sprite.
 */
int ColissionDetection (struct Block *jumper, struct Block *platform){
	int jumperw = jumper->width;
	int jumperh = (jumper->height)*3;
	int jumpera = jumper->x+jumper->y;							//a = anchor
	int jumperLC = (jumpera + jumperh) + (jumperw*DEMO_STRIDE); //LC = left corner
	int jumperRC = jumpera + jumperh;							//RC = right corner
	int platformw = platform->height;
	int platformh = platform->width*3;
	int platforma = platform->x+platform->y;
	int platformLT = platforma + (platformw*DEMO_STRIDE);		//LT = left top - the platform top left corner
	int platformRT = platforma;									//RT = right top - the platform top right corner
	int singleStepHeight = 0;

	for(int i = 0; i < platformh; i++){
		for(int j = platformRT + singleStepHeight; j <= platformLT; j+=DEMO_STRIDE) {
			if(j == jumperLC || j == jumperRC) {
				return 1;

			}
		}
	singleStepHeight++;
	}
	return 0;
}

/*
 * Checks if the sprite hits the GAME_FLOOR, ceiling or walls,
 * if so the player dies.
 */
void DeathDetection(int x, int y)
{
	// Hits Wall.
	if(x < rightWall) {
		jumperBlock.x = leftWall;
	}

	if(x > leftWall) {
		jumperBlock.x = rightWall;
	}
	// Hits GAME_FLOOR or ceiling.
	if(y < ceiling || GAME_FLOOR < y) {
		jumperDeathState = DEAD;
	}
}


/*
 * Writes four numbers to the SD card.
 */
void SDWrite(int num1, int num2, int num3, int num4) {
	init_platform();
	result = f_mount(&FS_instance,Path, 1);
	sprintf(FileName, "FILE.TXT");
	Log_File = (char *)FileName;
	result = f_open(&file1, Log_File, FA_CREATE_ALWAYS | FA_WRITE );
	char array[8];
	sprintf(array, "%d%d%d%d", num1, num2, num3, num4);
	result = f_write(&file1, (const void*)(char*)array, sizeof(array), &BytesWr);
	result = f_close(&file1);
	cleanup_platform();
}

/*
 * Reads the highscore from the SD card.
 */
void SDRead() {
	init_platform();
	result = f_mount(&FS_instance,Path, 1);

	sprintf(FileName, "FILE.TXT");
	Log_File = (char *)FileName;
	result = f_open(&file1, Log_File, FA_READ );

	char SDArray[4];
	result = f_read(&file1, (void*)(char*)SDArray, sizeof(SDArray), &BytesWr);

	xil_printf("readhighscore data = %s\n\r", (char*)SDArray);
	result = f_close(&file1);

	cleanup_platform();

	highthousands = (int)SDArray[0]-48; //henter ascii værdi af 0, hvilket er 48.

	highhundreds = (int)SDArray[1]-48;

	hightens = (int)SDArray[2]-48;

	highones = (int)SDArray[3]-48;

}

void DemoInitialize()
{
	int Status;
	XAxiVdma_Config *vdmaConfig;
	int i;

	/*
	 * Initialize an array of pointers to the 3 frame buffers
	 */
	for (i = 0; i < DISPLAY_NUM_FRAMES; i++)
	{
		pFrames[i] = frameBuf[i];
	}

	/*
	 * Initialize a timer used for a simple delay
	 */
	TimerInitialize(SCU_TIMER_ID);

	/*
	 * Initialize VDMA driver
	 */
	vdmaConfig = XAxiVdma_LookupConfig(VGA_VDMA_ID);
	if (!vdmaConfig)
	{
		xil_printf("No video DMA found for ID %d\r\n", VGA_VDMA_ID);
		return;
	}
	Status = XAxiVdma_CfgInitialize(&vdma, vdmaConfig, vdmaConfig->BaseAddress);
	if (Status != XST_SUCCESS)
	{
		xil_printf("VDMA Configuration Initialization failed %d\r\n", Status);
		return;
	}


	/*
	 * Initialize the Display controller and start it
	 */
	Status = DisplayInitialize(&dispCtrl, &vdma, DISP_VTC_ID, DYNCLK_BASEADDR, pFrames, DEMO_STRIDE);
	if (Status != XST_SUCCESS)
	{
		xil_printf("Display Ctrl initialization failed during demo initialization%d\r\n", Status);
		return;
	}
	Status = DisplayStart(&dispCtrl);
	if (Status != XST_SUCCESS)
	{
		xil_printf("Couldn't start display during demo initialization%d\r\n", Status);
		return;
	}

	/*
	 * Initialize the Interrupt controller and start it.
	 */
	Status = fnInitInterruptController(&intc);
	if(Status != XST_SUCCESS) {
		xil_printf("Error initializing interrupts");
		return;
	}
	fnEnableInterrupts(&intc, &ivt[0], sizeof(ivt)/sizeof(ivt[0]));

	/*
	 * Initialize the Video Capture device
	 */
	Status = VideoInitialize(&videoCapt, &intc, &vdma, VID_GPIO_ID, VID_VTC_ID, VID_VTC_IRPT_ID, pFrames, DEMO_STRIDE, DEMO_START_ON_DET);
	if (Status != XST_SUCCESS)
	{
		xil_printf("Video Ctrl initialization failed during demo initialization%d\r\n", Status);
		return;
	}

	/*
	 * Set the Video Detect callback to trigger the menu to reset, displaying the new detected resolution
	 */
	VideoSetCallback(&videoCapt, DemoISR, &fRefresh);
	return;
}

void DemoISR(void *callBackRef, void *pVideo)
{
	char *data = (char *) callBackRef;
	*data = 1; //set fRefresh to 1
}



