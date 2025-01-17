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
#include "video_demo.h"
#include "video_capture/video_capture.h"
#include "display_ctrl/display_ctrl.h"
#include "intc/intc.h"
#include <stdio.h>
#include "xuartps.h"
#include "math.h"
#include <ctype.h>
#include <stdlib.h>
#include "xil_types.h"
#include "xil_cache.h"
#include "timer_ps/timer_ps.h"
#include "xparameters.h"
#include "xscugic.h"
#include "xparameters.h"
#include "xgpio.h"
#include "xscugic.h"
#include "xil_exception.h"
#include "xil_printf.h"
#include "xtime_l.h"
#include "interrupts.h"
#include "game.h"
#include "deadLogic.h"
#include "numberArray.h"
#include "score.h"
#include "Framebuffer.h"
#include "whiteLine.h"
#include "Background.h"
#include "Header.h"
#include "Doodlemon.h"
#include "Kirby.h"
#include "Gameover.h"
#include "Alphabet.h"


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

/* ------------------------------------------------------------ */
/*				Global Variables								*/
/* ------------------------------------------------------------ */


u8 scoreArray[4] = {0, 0, 0, 0};
u32 platformhits = 0;
DisplayCtrl dispCtrl;
XAxiVdma vdma;
FATFS FatFs;		/* FatFs work area needed for each volume */
FIL Fil;			/* File object needed for each open file */
VideoCapture videoCapt;
char fRefresh; //flag used to trigger a refresh of the Menu on video detect
/*
 * Framebuffers for video data
 */
u8 frameBuf[DISPLAY_NUM_FRAMES][DEMO_MAX_FRAME];
u8 *pFrames[DISPLAY_NUM_FRAMES]; //array of pointers to the frame buffers
/*
 * Interrupt vector table
 */
const ivt_t ivt[] = {
	videoGpioIvt(VID_GPIO_IRPT_ID, &videoCapt),
	videoVtcIvt(VID_VTC_IRPT_ID, &(videoCapt.vtc))
};
// Counter used for score.
int counter = 0;
int resetf = 1;
int frame;
UINT bw;
/* ------------------------------------------------------------ */
/*						     Main								*/
/* ------------------------------------------------------------ */

u8 HighscoreWord[] = {H, I, G, H, S, C, O, R, E};
u8 YourscoreWord[] = {Y, O, U, R, S, C, O, R, E};
u8 AveragescoreWord[] = {A, V, E, R, A, G, E, S, C, O ,R ,E};
u8 alpha[] = {A, B, C, D, E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z};

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
/*						     Game		    					*/
/* ------------------------------------------------------------ */
void DemoStartGame() {
	while(1) {
		if(resetf == 1) {
			ResetGame(frameBuf[0]);
			Move(frameBuf[0]);
			Print(frameBuf[0]);
			Xil_DCacheFlushRange((unsigned int)frameBuf[0], DEMO_MAX_FRAME);
			DisplayChangeFrame(&dispCtrl, 0);
		}

		if(btn_value == 2 || btn_value == 4)
			dead = 0;
		while(dead != 1) {
			if (frame >= DISPLAY_NUM_FRAMES) {
						frame = 0;
					}
					PrintBackground(frameBuf[frame], 1920, 1080, 5760, whiteLine);
					Move(frameBuf[frame]);
					Print(frameBuf[frame]);
					Xil_DCacheFlushRange((unsigned int)frameBuf[frame], DEMO_MAX_FRAME);
					DisplayChangeFrame(&dispCtrl, frame);
					frame = dispCtrl.curFrame +1;
					resetf = 1;
		}





	}
}



void ResetGame(u8 *frame) {
	for(int i = 0; i < 3; i++) {
		PrintBackground(frameBuf[i], 1920, 1080, 5760, whiteLine);
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
				platformBlock[i].velocity = PLATFORM_SPEED;
				platform[i] = &platformBlock[i];
			}
			jumperBlock.x = (540-(JUMPER_WIDTH/2))*DEMO_STRIDE;
			jumperBlock.y = 3802;
			PrintScore(frame, ones, tens, hundreds, thousands, 500, 3500);
			resetScore();
			platformhits = 0;
			platformspeed = 6;
			jumperVelocity = GROUND;
			resetf = 0;
}

void PrintBackground(u8 *frame, u32 width, u32 height, u32 stride, u8 *pic)
{
	u32 lineStart = 2;
	u32 lineStartPic = 0;

	for(int ycoi = 0; ycoi < height; ycoi++)
	{
		memcpy(frame + lineStart, pic+lineStartPic, width*3);
		lineStart += stride;
		lineStartPic+= 0;//width*3;
	}
}

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

void PrintScore(u8 *frame, u8 ones, u8 tens, u8 hundreds, u8 thousands, u32 x, u32 y) {
	ImagePrint(frame, numArray[thousands], (x+63)*DEMO_STRIDE, y, 20, 20);
	ImagePrint(frame, numArray[hundreds], (x+42)*DEMO_STRIDE, y, 20, 20);
	ImagePrint(frame, numArray[tens], (x+21)*DEMO_STRIDE, y, 20, 20);
	ImagePrint(frame, numArray[ones], x*DEMO_STRIDE, y, 20, 20);
}

void Move(u8 *frame) {
	switch(btn_value) {
	case 1:
		jumperBlock.x -= DEMO_STRIDE*21;
		if (jumperBlock.velocity < 0){
			jumperDir = DR;
		}else  {
			jumperDir = UR;}
		break;
	case 2:
		jumperBlock.x -= DEMO_STRIDE*3;
		break;
	case 4:
		jumperBlock.x += DEMO_STRIDE*3;
		break;
	case 8:
		jumperBlock.x += DEMO_STRIDE*21;
		if (jumperBlock.velocity < 0){
					jumperDir = DL;
				}else  {
					jumperDir = UL;}
		break;
	default:
		break;

	}

	for(int j = 0; j < PLATFORM_AMOUNT; j++) {
		platformBlock[j].y+=platformspeed;
		if(platformBlock[j].y >= DEMO_STRIDE) {
		Increment();
		platformBlock[j].y = 2;
		platformBlock[j].x = DEMO_STRIDE*(rand() % 900 + 0);
		}
	}


	switch(jumperVelocity) {
	case GROUND:
		counter = 0;
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
		jumperBlock.velocity = 72;
		jumperVelocity = AIR;
		break;
	case AIR:
		if(jumperBlock.velocity < 13 && -13 < jumperBlock.velocity) {
			if(counter%2==0)
				jumperBlock.velocity-=JUMPER_GRAVITY;
		}
		else if(counter%6==0) {
				jumperBlock.velocity-=JUMPER_GRAVITY;
		}

		jumperBlock.y -= jumperBlock.velocity;
		if(jumperBlock.velocity < 0) {
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
			for(int k = 0; k < PLATFORM_AMOUNT; k++) {
				if((collisiondetect(jumper, platform[k]))==1) {
					jumperVelocity = GROUND;
				}
			}
		}
		counter++;
		break;
	}
	isDead(jumperBlock.x, jumperBlock.y);
}


void Print(u8 *frame) {

	for(int j = 0; j < PLATFORM_AMOUNT; j++) {
		blockPrinter(frame, DEMO_STRIDE, platformImg, PLATFORM_WIDTH, PLATFORM_HEIGHT, platformBlock[j]);
	}
	PrintBackground(frame, 150, 1080, 5760, HeaderImg);
	if (dead == 1){
		ImagePrint(frameBuf[0], Gameover, 0, 2101, 1080, 240);
		ImagePrint(frameBuf[1], Gameover, 0, 2101, 1080, 240);
		ImagePrint(frameBuf[2], Gameover, 0, 2101, 1080, 240);
	}
	PrintScore(frame, ones, tens, hundreds, thousands, 700, 470);
	PrintScore(frame, highones, hightens, highhundreds, highthousands, 700, 560);
	PrintScore(frame, avgones, avgtens, avghundreds, avgthousands, 700, 650);
	PrintWord(frame, HighscoreWord, 1050, 470, 9);
	PrintWord(frame, YourscoreWord, 1050, 560, 9);
	PrintWord(frame, AveragescoreWord, 1050, 650, 12);
	PrintWord(frame, alpha, 1050, 740, 26);

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
}

void ImagePrint(u8 *frame, u8 *array,  u32 x, u32 y, int imgH, int imgW) {
	int cor = x+y;
	int arrayCounter = 0;
	for(int i = 0; i < imgH; i++) {
		for(int j = 0; j<imgW*3; j+=3) {
			if (array[arrayCounter] != 255 && array[arrayCounter+1] != 255 && array[arrayCounter+2] != 255){
			frame[cor + j + 1] = array[arrayCounter + 0];
			frame[cor + j + 2] = array[arrayCounter + 1];
			frame[cor + j + 0] = array[arrayCounter + 2];
			arrayCounter += 3;
			} else {
				arrayCounter+=3;
			}
		}
		cor = cor + DEMO_STRIDE;
	}

}

int collisiondetect (struct Block *jumper, struct Block *platform){
	int jumperw = jumper->width;
	int jumperh = (jumper->height)*3;
	int jumpera = jumper->x+jumper->y;
	int jumperLC = (jumpera + jumperh) + (jumperw*DEMO_STRIDE);
	int jumperRC = jumpera + jumperh;



	int platformw = platform->height;
	int platformh = platform->width*3;
	int platforma = platform->x+platform->y;
	int platformLT = platforma + (platformw*DEMO_STRIDE);
	int platformRT = platforma;
	int g;
	int singleStepHeight = 0;
	for(int j = 0; j < platformh; j++){

	for(g = platformRT + singleStepHeight; g <= platformLT; g+=DEMO_STRIDE) {

			if(g == jumperLC || g == jumperRC) {
				return 1;

			}
		}
	singleStepHeight++;
	}
	return 0;
}

void blockPrinter(u8 *frame, u32 stride,u8 *pic,  u32 picWidth, u32 picHeight, struct Block block)
{
	u32 lineStart = 0;
	u32 lineStartPic = 0;
		for(int ycoi = 0; ycoi < picHeight; ycoi++)
		{
			memcpy(frame+block.x+block.y + lineStart, pic+lineStartPic, picWidth*3);
			lineStart += stride;
			lineStartPic += picWidth*3;
		}
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



