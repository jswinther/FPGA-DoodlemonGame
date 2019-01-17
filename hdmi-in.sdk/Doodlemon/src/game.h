/*
 * game.h
 *
 *  Created on: 11. jan. 2019
 *      Author: Jonathan
 */

#ifndef SRC_VIDEO_CAPTURE_GAME_H_
#define SRC_VIDEO_CAPTURE_GAME_H_

#include "xil_types.h"

#define DEMO_MAX_FRAME (1920*1080*3)
#define DEMO_STRIDE (1920*3)

#define jumperGRAVITY 3
#define DEMO_START_ON_DET 1
//Platform
#define PLATFORM_HEIGHT 140
#define PLATFORM_WIDTH 48
#define PLATFORM_SPEED 12
#define PLATFORM_AMOUNT 10

//Jumper
#define JUMPER_HEIGHT 100
#define JUMPER_WIDTH 100
#define JUMPER_GRAVITY 9
struct Block {
	u16 width;
	u16 height;
	u32 x;
	u32 y;
	int velocity;
};

struct Block jumperBlock = {JUMPER_WIDTH, JUMPER_HEIGHT, (490*DEMO_STRIDE), 2830, 0};
struct Block *jumper = &jumperBlock;
struct Block platformBlock[PLATFORM_AMOUNT];
struct Block *platform[PLATFORM_AMOUNT];

enum Velocity {
	GROUND,
	AIR
};

enum direction {
	DL,
	DR,
	UL,
	UR
};
enum direction jumperDir = UL;
enum Velocity jumperVelocity = GROUND;


int collisiondetect (struct Block *jumper, struct Block *platform);
void ImageOverwrite(u8 *frame,  u32 x, u32 y, int imgH, int imgW);
void DemoStartGame();
void ImagePrint(u8 *frame, u8 *array,  u32 x, u32 y, int imgH, int imgW);
int GenerateGameImage();
void DemoPrintBackground(u8 *frame);
void Overwrite(u8 *frame);
void Move(u8 *frame);
void Print(u8 *frame);
void Increment();
int frameSelect();
void nextframeselect();
void ResetGame(u8 *frame);
void ImagePrintMemCpy(u8 *frame, u8 *array,  u32 x, u32 y, int imgH, int imgW);
void PrintBackground(u8 *frame, u32 width, u32 height, u32 stride, u8 *pic);
void blockPrinter(u8 *frame, u32 stride,u8 *pic,  u32 picWidth, u32 picHeight, struct Block block);
void initializeBlock(u8 *frame, u8 *pic, int x, int y);
void MemeCopyOverWrite(u8 *frame, u8 *pic, int x, int y, int imgW, int imgH);
void PrintScore(u8 *frame, u8 ones, u8 tens, u8 hundreds, u8 thousands, u32 x, u32 y);
void DemoInitialize();
void DemoInvertFrame(u8 *srcFrame, u8 *destFrame, u32 width, u32 height, u32 stride);
void DemoPrintTest(u8 *frame, u32 width, u32 height, u32 stride, int pattern);
void DemoScaleFrame(u8 *srcFrame, u8 *destFrame, u32 srcWidth, u32 srcHeight, u32 destWidth, u32 destHeight, u32 stride);
void DemoISR(void *callBackRef, void *pVideo);
void SDWrite(char *array, uint length);
#endif /* SRC_VIDEO_CAPTURE_GAME_H_ */
