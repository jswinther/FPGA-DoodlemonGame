/*
 * Score.h
 *
 *  Created on: 14. jan. 2019
 *      Author: Nicolai
 */

#ifndef SRC_SCORE_H_
#define SRC_SCORE_H_

u32 platformspeed = 15;




u8 speedCounter = 0;



u16 incrementInterval = 5;
u8 intervalCount = 0;



u16 currentScoreCounter = 0;
u16 highscoreCounter = 0;
u16 averageScoreCounter = 0;


u8 ones = 0;
u8 tens = 0;
u8 hundreds = 0;
u8 thousands = 0;

u8 highones = 0;
u8 hightens = 0;
u8 highhundreds = 0;
u8 highthousands = 0;

u8 avgones = 0;
u8 avgtens = 0;
u8 avghundreds = 0;
u8 avgthousands = 0;

//Average score
u8 averageScore = 0;
u8 totalScore = 0;


//Times played
u8 gamesPlayed = 1;


void findAverageScore(){
	totalScore += (ones+(10*tens)+(100*hundreds)+(1000*thousands));
	averageScore = totalScore/gamesPlayed;
	xil_printf("Average score: %d", averageScore);
}
void Increment() {
	ones++;
	currentScoreCounter++;
	intervalCount++;
	if(intervalCount == incrementInterval) {
		intervalCount = 0;
		incrementInterval++;
		platformspeed+=3;
	}

	if(ones == 10) {
		tens++;
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
	if(currentScoreCounter > highscoreCounter) {
		highscoreCounter = currentScoreCounter;
		highones = ones;
		hightens = tens;
		highhundreds = hundreds;
		highthousands = thousands;
		gamesPlayed++;
		currentScoreCounter = 0;
		findAverageScore();
		ones = 0;
		tens = 0;
		hundreds = 0;
		thousands = 0;
	} else {
		gamesPlayed++;
		currentScoreCounter = 0;
		findAverageScore();
		ones = 0;
		tens = 0;
		hundreds = 0;
		thousands = 0;
	}
	intervalCount = 0;
	incrementInterval = 5;

}

#endif /* SRC_SCORE_H_ */
