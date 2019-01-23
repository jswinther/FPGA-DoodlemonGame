/*
 * Enemy.h
 *
 *  Created on: 23. jan. 2019
 *      Author: Jonat
 */

#ifndef SRC_ENEMY_H_
#define SRC_ENEMY_H_

#define ENEMY_WIDTH 140
#define ENEMY_HEIGHT 140

struct Enemy {
	int x;
	int y;
	int width;
	int height;
};

struct Enemy Bowser = {0, 0, ENEMY_WIDTH, ENEMY_HEIGHT};

int BowserDetection();

#endif /* SRC_ENEMY_H_ */
