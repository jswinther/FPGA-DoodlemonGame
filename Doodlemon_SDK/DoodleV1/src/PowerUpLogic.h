/*
 * PowerUpLogic.h
 *
 *  Created on: 22. jan. 2019
 *      Author: Jonat
 */

#ifndef SRC_POWERUPLOGIC_H_
#define SRC_POWERUPLOGIC_H_

enum Types {
	WumpaFruit,			// Subtracts Points
	Skull,		// Adds Points
	Clock			// Slows Down Platforms
};

struct  {
	int x;
	int y;
	u32 height;
	u32 width;
	int type;
} PowerUp;

#endif /* SRC_POWERUPLOGIC_H_ */
