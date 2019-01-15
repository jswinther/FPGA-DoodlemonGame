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

int frame;

/* ------------------------------------------------------------ */
/*						     Main								*/
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
/*						     Game		    					*/
/* ------------------------------------------------------------ */
void DemoStartGame() {
	ResetGame(frameBuf[0]);
	Xil_DCacheFlushRange((unsigned int)frameBuf[0], DEMO_MAX_FRAME);
	DisplayChangeFrame(&dispCtrl, 0);
	while(1) {
		if (frame >= DISPLAY_NUM_FRAMES) {
			frame = 0;
		}
		if(dead == 1)
			ResetGame(frameBuf[frame]);
		initializeScreen(frameBuf[frame], 1920, 1080, 5760, whiteLine);
		Move(frameBuf[frame]);
		Print(frameBuf[frame]);
		Xil_DCacheFlushRange((unsigned int)frameBuf[frame], DEMO_MAX_FRAME);
		DisplayChangeFrame(&dispCtrl, frame);
		frame = dispCtrl.curFrame +1;
	}
}

void ResetGame(u8 *frame) {
	for(int i = 0; i < 3; i++) {
		initializeScreen(frameBuf[i], 1920, 1080, 5760, whiteLine);
	}
	//ImagePrintMemCpy(frame, whiteLine, 0, 0, 1080, 1920);
			int random_x;
			int random_y = 0;
			for(int i = 0; i < PLATFORM_AMOUNT; i++) {
				random_x = rand() % 919 + 0;
				random_y += 576;
				platformBlock[i].height = PLATFORM_HEIGHT;
				platformBlock[i].width = PLATFORM_WIDTH;
				platformBlock[i].x = random_x*DEMO_STRIDE;
				platformBlock[i].y = random_y;
				platformBlock[i].velocity = PLATFORM_SPEED;
				platform[i] = &platformBlock[i];
			}
			jumperBlock.x = 540*DEMO_STRIDE;
			jumperBlock.y = 2830;
			dead = 0;
			resetScore();
			platformhits = 0;
			platformspeed = 6;
}

void initializeScreen(u8 *frame, u32 width, u32 height, u32 stride, u8 *pic)
{
	u32 lineStart = 0;
	u32 lineStartPic = 0;

	for(int ycoi = 0; ycoi < 1080; ycoi++)
	{
		memcpy(frame + lineStart, pic, stride);
		lineStart += stride;
		lineStartPic+= stride;
	}
}
void initializeBlock(u8 *frame, u8 *pic, int x, int y)
{
	u32 lineStart = y+(x*DEMO_STRIDE);
	u32 lineStartPic = 0;

	for(int ycoi = 0; ycoi < 160; ycoi++)
	{
		memcpy(frame + lineStart, pic, 48*3);
		lineStart += DEMO_STRIDE;
		lineStartPic+= 48*3;
	}
}

void MemeCopyOverWrite(u8 *frame, u8 *pic, int x, int y, int imgW, int imgH) {
	u32 lineStart = x*DEMO_STRIDE+y;
	u32 lineStartPic = 0;

		for(int ycoi = 0; ycoi < imgH; ycoi++)
		{
			memcpy(frame + lineStart, pic, imgW*3);
			lineStart += DEMO_STRIDE;
			lineStartPic+= imgW*3;
		}
}

void PrintScore(u8 *frame, u8 ones, u8 tens, u8 hundreds, u8 thousands) {
	ImagePrint(frame, numArray[thousands], 1000*DEMO_STRIDE, 50, 20, 20);
	ImagePrint(frame, numArray[hundreds], 979*DEMO_STRIDE, 50, 20, 20);
	ImagePrint(frame, numArray[tens], 958*DEMO_STRIDE, 50, 20, 20);
	ImagePrint(frame, numArray[ones], 937*DEMO_STRIDE, 50, 20, 20);

}
void PrintHighScore(u8 *frame, u8 ones, u8 tens, u8 hundreds, u8 thousands) {
	ImagePrint(frame, numArray[highthousands], 1000*DEMO_STRIDE, 150, 20, 20);
	ImagePrint(frame, numArray[highhundreds], 979*DEMO_STRIDE, 150, 20, 20);
	ImagePrint(frame, numArray[hightens], 958*DEMO_STRIDE, 150, 20, 20);
	ImagePrint(frame, numArray[highones], 937*DEMO_STRIDE, 150, 20, 20);

}

void Overwrite(u8 *frame) {
	MemeCopyOverWrite(frame, whiteLine, jumperBlock.x, jumperBlock.y, JUMPER_WIDTH, JUMPER_HEIGHT);
	for(int j = 0; j < PLATFORM_AMOUNT; j++) {
		MemeCopyOverWrite(frame, whiteLine, platformBlock[j].x, platformBlock[j].y, PLATFORM_WIDTH, PLATFORM_HEIGHT);
		platformBlock[j].y+=platformspeed;
		if(platformBlock[j].y >= DEMO_STRIDE) {
			platformBlock[j].y = 0;
			platformBlock[j].x = DEMO_STRIDE*(rand() % 900 + 0);
		}
	}
	MemeCopyOverWrite(frame, whiteLine, 937*DEMO_STRIDE, 50, 80, 20);
	//ImageOverwrite(frame, 937*DEMO_STRIDE, 50, 80, 20);
}

void Move(u8 *frame) {

	switch(btn_value) {
	case 1:
		jumperBlock.x -= DEMO_STRIDE*6;
		break;
	case 2:
		jumperBlock.x -= DEMO_STRIDE*3;
		break;
	case 4:
		jumperBlock.x += DEMO_STRIDE*3;
		break;
	case 8:
		jumperBlock.x += DEMO_STRIDE*6;
		break;
	default:
		break;

	}

	for(int j = 0; j < PLATFORM_AMOUNT; j++) {
		platformBlock[j].y+=platformspeed;
		if(platformBlock[j].y >= DEMO_STRIDE) {
		Increment();
		platformBlock[j].y = 0;
		platformBlock[j].x = DEMO_STRIDE*(rand() % 900 + 0);
		}
	}

	switch(jumperVelocity) {
	case GROUND:
		counter = 0;
		jumperBlock.velocity = 48;
		jumperVelocity = AIR;
		break;
	case AIR:
		if(counter%10==0) {
			if(jumperBlock.velocity > -48)
				jumperBlock.velocity-=JUMPER_GRAVITY;
		}

		jumperBlock.y -= jumperBlock.velocity;
		if(jumperBlock.velocity < 0) {
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

	//initializeBlock(frame, platformImg, 500, 500);
	for(int j = 0; j < PLATFORM_AMOUNT; j++) {
		blockPrinter(frame, DEMO_STRIDE, platformImg, 48, 160, platformBlock[j]);
	}
	PrintScore(frame, ones, tens, hundreds, thousands);
	PrintHighScore(frame, highones, hightens, highhundreds, highthousands);
	ImagePrint(frame, jumperImg, jumperBlock.x, jumperBlock.y , JUMPER_HEIGHT, JUMPER_WIDTH);
}

void DemoPrintBackground(u8 *frame) {
	for(int i = 0; i < 1920*1080*3; i++) {
		frame[i] = 255;
	}
}

void ImagePrint(u8 *frame, u8 *array,  u32 x, u32 y, int imgH, int imgW) {
	int cor = x+y;
	int arrayCounter = 0;
	for(int i = 0; i < imgH; i++) {
		for(int j = 0; j<imgW*3; j+=3) {
			if (array[arrayCounter] != 255){
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


void ImagePrintMemCpy(u8 *frame, u8 *array,  u32 x, u32 y, int imgH, int imgW) {
	u32 line = 0;
	u32 stride = 0;
	for(int i = 0; i < imgH; i++){
		memcpy(frame + (y+x*DEMO_STRIDE) + stride, array + line, sizeof(imgW*3));
		line += imgW*3;
		stride += DEMO_STRIDE;
	}
}


void ImageOverwrite(u8 *frame, u32 x, u32 y, int imgH, int imgW) {
	int cor = x+y;
	for(int i = 0; i < imgH; i++) {
		for(int j = 0; j<imgW*3; j+=3) {
			frame[cor + j + 0] = 255;
			frame[cor + j + 1] = 255;
			frame[cor + j + 2] = 255;
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
	int platformh = platform->width;
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
	u32 picStride = picWidth*3;
		for(int ycoi = 0; ycoi < picHeight; ycoi++)
		{
			memcpy(frame+block.x+block.y + lineStart, pic+lineStartPic, picStride);
			lineStart += stride;
			lineStartPic+= picStride;
		}
}

void StreamFrameBuffer() {
	if (videoCapt.state == VIDEO_STREAMING)
					VideoStop(&videoCapt);
				else
					VideoStart(&videoCapt);
}

void VideoFrameBufferSwap() {
	nextFrame = videoCapt.curFrame + 1;
	if (nextFrame >= DISPLAY_NUM_FRAMES)
	{
		nextFrame = 0;
	}
	VideoChangeFrame(&videoCapt, nextFrame);
}

void GrabFrameAndInvert() {
	nextFrame = videoCapt.curFrame + 1;
	if (nextFrame >= DISPLAY_NUM_FRAMES){
		nextFrame = 0;
	}
	VideoStop(&videoCapt);
	DemoInvertFrame(pFrames[videoCapt.curFrame], pFrames[nextFrame], videoCapt.timing.HActiveVideo, videoCapt.timing.VActiveVideo, DEMO_STRIDE);
	VideoStart(&videoCapt);
	DisplayChangeFrame(&dispCtrl, nextFrame);
}

void GrabVideoAndScaleToFrame() {
	nextFrame = videoCapt.curFrame + 1;
	if (nextFrame >= DISPLAY_NUM_FRAMES) {
		nextFrame = 0;
	}
	VideoStop(&videoCapt);
	DemoScaleFrame(pFrames[videoCapt.curFrame], pFrames[nextFrame], videoCapt.timing.HActiveVideo, videoCapt.timing.VActiveVideo, dispCtrl.vMode.width, dispCtrl.vMode.height, DEMO_STRIDE);
	VideoStart(&videoCapt);
	DisplayChangeFrame(&dispCtrl, nextFrame);
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

void DemoInvertFrame(u8 *srcFrame, u8 *destFrame, u32 width, u32 height, u32 stride)
{
	u32 xcoi, ycoi;
	u32 lineStart = 0;
	for(ycoi = 0; ycoi < height; ycoi++)
	{
		for(xcoi = 0; xcoi < (width * 3); xcoi+=3)
		{
			destFrame[xcoi + lineStart] = ~srcFrame[xcoi + lineStart];         //Red
			destFrame[xcoi + lineStart + 1] = ~srcFrame[xcoi + lineStart + 1]; //Blue
			destFrame[xcoi + lineStart + 2] = ~srcFrame[xcoi + lineStart + 2]; //Green
		}
		lineStart += stride;
	}
	/*
	 * Flush the framebuffer memory range to ensure changes are written to the
	 * actual memory, and therefore accessible by the VDMA.
	 */
	Xil_DCacheFlushRange((unsigned int) destFrame, DEMO_MAX_FRAME);
}

void DemoScaleFrame(u8 *srcFrame, u8 *destFrame, u32 srcWidth, u32 srcHeight, u32 destWidth, u32 destHeight, u32 stride)
{
	float xInc, yInc; // Width/height of a destination frame pixel in the source frame coordinate system
	float xcoSrc, ycoSrc; // Location of the destination pixel being operated on in the source frame coordinate system
	float x1y1, x2y1, x1y2, x2y2; //Used to store the color data of the four nearest source pixels to the destination pixel
	int ix1y1, ix2y1, ix1y2, ix2y2; //indexes into the source frame for the four nearest source pixels to the destination pixel
	float xDist, yDist; //distances between destination pixel and x1y1 source pixels in source frame coordinate system

	int xcoDest, ycoDest; // Location of the destination pixel being operated on in the destination coordinate system
	int iy1; //Used to store the index of the first source pixel in the line with y1
	int iDest; //index of the pixel data in the destination frame being operated on

	int i;

	xInc = ((float) srcWidth - 1.0) / ((float) destWidth);
	yInc = ((float) srcHeight - 1.0) / ((float) destHeight);

	ycoSrc = 0.0;
	for (ycoDest = 0; ycoDest < destHeight; ycoDest++)
	{
		iy1 = ((int) ycoSrc) * stride;
		yDist = ycoSrc - ((float) ((int) ycoSrc));

		/*
		 * Save some cycles in the loop below by presetting the destination
		 * index to the first pixel in the current line
		 */
		iDest = ycoDest * stride;

		xcoSrc = 0.0;
		for (xcoDest = 0; xcoDest < destWidth; xcoDest++)
		{
			ix1y1 = iy1 + ((int) xcoSrc) * 3;
			ix2y1 = ix1y1 + 3;
			ix1y2 = ix1y1 + stride;
			ix2y2 = ix1y1 + stride + 3;

			xDist = xcoSrc - ((float) ((int) xcoSrc));

			/*
			 * For loop handles all three colors
			 */
			for (i = 0; i < 3; i++)
			{
				x1y1 = (float) srcFrame[ix1y1 + i];
				x2y1 = (float) srcFrame[ix2y1 + i];
				x1y2 = (float) srcFrame[ix1y2 + i];
				x2y2 = (float) srcFrame[ix2y2 + i];

				/*
				 * Bilinear interpolation function
				 */
				destFrame[iDest] = (u8) ((1.0-yDist)*((1.0-xDist)*x1y1+xDist*x2y1) + yDist*((1.0-xDist)*x1y2+xDist*x2y2));
				iDest++;
			}
			xcoSrc += xInc;
		}
		ycoSrc += yInc;
	}

	/*
	 * Flush the framebuffer memory range to ensure changes are written to the
	 * actual memory, and therefore accessible by the VDMA.
	 */
	Xil_DCacheFlushRange((unsigned int) destFrame, DEMO_MAX_FRAME);

	return;
}

void DemoISR(void *callBackRef, void *pVideo)
{
	char *data = (char *) callBackRef;
	*data = 1; //set fRefresh to 1
}



