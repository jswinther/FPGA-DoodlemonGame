/*
 * game.h
 *
 *  Created on: 11. jan. 2019
 *      Author: Jonathan
 */

#ifndef SRC_VIDEO_CAPTURE_GAME_H_
#define SRC_VIDEO_CAPTURE_GAME_H_

#include "jumper.h"
#include "platform.h"
#define DEMO_MAX_FRAME (1920*1080*3)
#define DEMO_STRIDE (1920*3)

#define jumperGRAVITY 3

//Platform
#define PLATFORM_HEIGHT 160
#define PLATFORM_WIDTH 48
#define PLATFORM_SPEED 6
#define PLATFORM_AMOUNT 10

//Jumper
#define JUMPER_HEIGHT 100
#define JUMPER_WIDTH 100
#define JUMPER_GRAVITY 6
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
enum Velocity jumperVelocity = GROUND;


int collisiondetect (struct Block *jumper, struct Block *platform);
void ImageOverwrite(u8 *frame,  u32 x, u32 y, int imgH, int imgW);
void DemoStartGame();
void ImagePrint(u8 *frame, u8 *array,  u32 x, u32 y, int imgH, int imgW);
void FrameBufferSwap ();
int GenerateGameImage();
void DemoPrintBackground(u8 *frame);
void Overwrite(u8 *frame);
void Move(u8 *frame);
void Print(u8 *frame);
void Increment();
int frameSelect();
void nextframeselect();
void ResetGame(u8 *frame);

#endif /* SRC_VIDEO_CAPTURE_GAME_H_ */
