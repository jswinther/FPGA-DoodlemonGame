/*
 * deadLogic.h
 *
 *  Created on: 14. jan. 2019
 *      Author: Jonat
 */

#ifndef SRC_DEADLOGIC_H_
#define SRC_DEADLOGIC_H_

#define leftWall 980
#define rightWall 100
#define floor 5660
#define ceiling 100

int dead = 0;

void isDead(u32 x, u32 y);
void isDead(u32 x, u32 y)
{
	// Hits Wall.
	if(x < rightWall || leftWall < x) {
		dead = 1;
	}
	// Hits floor or ceiling.
	if(y < ceiling || floor < y) {
		dead = 1;
	}
}



#endif /* SRC_DEADLOGIC_H_ */
