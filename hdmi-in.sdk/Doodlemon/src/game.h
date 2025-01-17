/*
 * game.h
 *
 *  Created on: 11. jan. 2019
 *      Author: Jonathan
 */

#ifndef SRC_VIDEO_CAPTURE_GAME_H_
#define SRC_VIDEO_CAPTURE_GAME_H_

/*
 * Platform Definitions.
 */
#define PLATFORM_HEIGHT 140
#define PLATFORM_WIDTH 48
#define PLATFORM_SPEED 30
#define PLATFORM_AMOUNT 10

/*
 * Jumper Definitions.
 */
#define JUMPER_HEIGHT 100
#define JUMPER_WIDTH 100
#define JUMPER_GRAVITY 12

/*
 * Death Logic Definitions.
 */
#define GAME_FLOOR 5460
#define leftWall 1080*1920*3
#define rightWall 0
#define ceiling 0

/*
 * Block struct, for creating sprite and platforms.
 */
struct Block {
	u16 width;
	u16 height;
	int x;
	int y;
	int velocity;
};

enum {
	LEFT,
	RIGHT
} platformDirection ;


enum {
	KIRBY,
	DOODLE,
	THEORIGINAL,
} Character;


/*
 * These enumerations are used to decide which way the sprite faces
 * and jumping pattern. jumperVelocity and jumperDir is described better in game.h
 */
/*
 * Velocity enum, for the statemachine that controls the jumping of the sprite.
 * GROUND	: When the sprite hits the platforms.
 * AIR		: When the sprite is in the air, the sprite velocity is decreasing at a constant rate.
 */
enum Velocity {
	GROUND,
	AIR
} jumperVelocity = GROUND;

/*
 * Direction enum, for the statemachine that decides which way the sprite should face,
 * DL : Down Left.
 * DR : Down Right.
 * UL : Up Left.
 * UR : Up Right.
 */
enum direction {
	DL,
	DR,
	UL,
	UR
} jumperDir = UL;

enum {
	ALIVE,
	DEAD
} jumperDeathState = DEAD;

/*
 * Prototypes.
 */
void DemoStartGame();
void ResetGame(u8 *frame);
void Print(u8 *frame);
void ImagePrint(u8 *frame, u8 *array,  u32 x, u32 y, int imgH, int imgW);
void PrintBackground(u8 *frame, u32 width, u32 height, u32 stride, u8 *pic);
void PrintWord(u8 *frame, u8 *array, u32 x, u32 y, u8 wordLength);
void PrintPlatform(u8 *frame, u32 stride,u8 *pic,  u32 picWidth, u32 picHeight, struct Block block);
void PrintScore(u8 *frame, u8 ones, u8 tens, u8 hundreds, u8 thousands, u32 x, u32 y);
void Move(u8 *frame);
void MoveSprite(u8 *frame);
void MovePlatform(u8 *frame);
int ColissionDetection (struct Block *jumper, struct Block *platform);
void DeathDetection(int x, int y);
void Increment();
void SDWrite(int num1, int num2, int num3, int num4);
void SDRead();
void SDRead();
int oldHighScore();

#endif /* SRC_VIDEO_CAPTURE_GAME_H_ */
