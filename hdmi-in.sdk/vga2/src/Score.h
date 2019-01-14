/*
 * Score.h
 *
 *  Created on: 14. jan. 2019
 *      Author: bruger
 */

#ifndef SRC_SCORE_H_
#define SRC_SCORE_H_



#endif /* SRC_SCORE_H_ */

int ones = 0;
int tens = 0;
int hundreds = 0;
int thousand = 0;



void incrementscore(){
	ones++;
	if(ones=10){
		tens++;
		ones = 0;
	}
	if (tens == 10){
		hundreds++;
		tens = 0;
	}
	if (hundreds == 10){
			thousands++;
			hundreds = 0;
		}
	if (thousands == 10){
			thousands = 0;
			hundreds = 0;
		}
}
