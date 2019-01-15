/*
 * Score.h
 *
 *  Created on: 14. jan. 2019
 *      Author: Nicolai
 */

#ifndef SRC_SCORE_H_
#define SRC_SCORE_H_

u32 platformspeed = 6;
//Currenst score
u8 ones = 0;
u8 tens = 0;
u8 hundreds = 0;
u8 thousands = 0;


//Highscore
u8 highones = 0;
u8 hightens = 0;
u8 highhundreds = 0;
u8 highthousands = 0;


//Average score
u8 averageScore = 0;
u8 totalScore = 0;


//Times played
u8 gamesPlayed = 0;


void findAverageScore(){
	totalScore += (ones+(10*tens)+(100*hundreds)+(1000*thousands));
	averageScore = totalScore/gamesPlayed;
	xil_printf("Average score: %d", averageScore);
}
void Increment() {
	ones++;
	if(ones == 10) {
		tens++;
		platformspeed+=2;
		ones = 0;
	}
	if(tens == 10) {
		hundreds++;
		tens = 0;
	}
	if(hundreds == 10) {
		thousands++;
		hundreds = 0;
	}
}

void resetScore(){
	gamesPlayed++;
	findAverageScore();
	if(thousands > highthousands){
		highones = ones;
		hightens = tens;
		highhundreds = hundreds;
		highthousands = thousands;
	}
	else if(hundreds > highhundreds){
		highones = ones;
		hightens = tens;
		highhundreds = hundreds;
		highthousands = thousands;
	}
	else if(tens > hightens){
		highones = ones;
		hightens = tens;
		highhundreds = hundreds;
		highthousands = thousands;
	}
	else if(ones > highones){
		highones = ones;
		hightens = tens;
		highhundreds = hundreds;
		highthousands = thousands;
	}

	ones = 0;
	tens = 0;
	hundreds = 0;
	thousands = 0;
}

#endif /* SRC_SCORE_H_ */
