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
#define PLATFORM_WIDTH 24
#define PLATFORM_SPEED 6
#define PLATFORM_AMOUNT 10

//Jumper
#define JUMPER_HEIGHT 100
#define JUMPER_WIDTH 100
#define JUMPER_GRAVITY 3
#define JUMPER_START (1920*3)*539+(1920*3)-(JUMPER_WIDTH/2)
struct Block {
	u32 anchor;
	u16 width;
	u16 height;
	u32 floor;
	int velocity;
	u32 x;
	u32 y;
};

struct Block jumperBlock = {JUMPER_START, JUMPER_WIDTH, JUMPER_HEIGHT, (DEMO_STRIDE - JUMPER_START + JUMPER_HEIGHT), 0, 490*DEMO_STRIDE, 2830};
struct Block *jumper = &jumperBlock;
struct Block platformBlock[PLATFORM_AMOUNT];
struct Block *platform[PLATFORM_AMOUNT];

enum Velocity {
	GROUND,
	AIR
};
enum Velocity jumperVelocity = GROUND;


int collisiondetect (struct Block *jumper, struct Block *platform);
void ImageOverwrite(u8 *frame,  u32 anchor, int imgH, int imgW);
void DemoStartGame(u32 width, u32 height);
void ImagePrint(u8 *frame, int *array,  u32 anchor, int imgH, int imgW);
void FrameBufferSwap ();
int GenerateGameImage();
void DemoPrintBackground(u8 *frame, int width, int height);
void Overwrite(u8 *frame);
void Move(u8 *frame);
void Print(u8 *frame);


#endif /* SRC_VIDEO_CAPTURE_GAME_H_ */
