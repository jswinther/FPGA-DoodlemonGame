/*
 * deadLogic.h
 *
 *  Created on: 14. jan. 2019
 *      Author: Jonat
 */

#ifndef SRC_DEADLOGIC_H_
#define SRC_DEADLOGIC_H_

#define leftWall 980*(1920*3)
#define rightWall 0*(1920*3)
#define floor 5460
#define ceiling 0

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
