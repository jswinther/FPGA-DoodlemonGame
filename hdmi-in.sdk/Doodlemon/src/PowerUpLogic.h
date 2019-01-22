/*
 * PowerUpLogic.h
 *
 *  Created on: 22. jan. 2019
 *      Author: Jonat
 */

#ifndef SRC_POWERUPLOGIC_H_
#define SRC_POWERUPLOGIC_H_

enum Types {
	Skull,			// Subtracts Points
	WumpaFruit,		// Adds Points
	Clock			// Slows Down Platforms
};

struct PowerStruct {
	int x;
	int y;
	u32 height;
	u32 width;
	int type;
} ;

struct PowerStruct PowerUp  = {510*1920*3, 0, 60, 60, WumpaFruit};

#endif /* SRC_POWERUPLOGIC_H_ */
