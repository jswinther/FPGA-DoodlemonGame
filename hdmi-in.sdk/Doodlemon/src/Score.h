/*
 * Score.h
 *
 *  Created on: 14. jan. 2019
 *      Author: Nicolai
 */
#include "game.h"

#ifndef SRC_SCORE_H_
#define SRC_SCORE_H_

u32 platformspeed = 15;
u8 speedCounter = 0;
u16 incrementInterval = 5;
u8 intervalCount = 0;

u16 currentScoreCounter = 0;
u16 highscoreCounter = 0;
u16 averageScoreCounter = 0;


//current score
int ones = 0;
int tens = 0;
int hundreds = 0;
int thousands = 0;

//Highscore
int oldHighscore = 0;
int highones = 0;
int hightens = 0;
int highhundreds = 0;
int highthousands = 0;

//Average score
u8 avgones = 0;
u8 avgtens = 0;
u8 avghundreds = 0;
u8 avgthousands = 0;
u8 averageScore = 0;
u8 totalScore = 0;

//Times played
u8 gamesPlayed = 1;


void findAverageScore(){
	totalScore += (ones+(10*tens)+(100*hundreds)+(1000*thousands));
	averageScore = totalScore/gamesPlayed;
	xil_printf("Average score: %d", averageScore);

	while(averageScore > 1000){
		avgthousands++;
		averageScore = averageScore - 1000;
	}

	while(averageScore > 100){
			avghundreds++;
			averageScore = averageScore - 100;
	}

	while(averageScore > 10){
			avgtens++;
			averageScore = averageScore - 10;
	}

	while(averageScore >= 1){
			avgones++;
			averageScore = averageScore - 1;
	}

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
	if(currentScoreCounter > oldHighScore()) {
		highscoreCounter = currentScoreCounter;
		highones = ones;
		hightens = tens;
		highhundreds = hundreds;
		highthousands = thousands;
		findAverageScore();
		currentScoreCounter = 0;
		gamesPlayed++;
		ones = 0;
		tens = 0;
		hundreds = 0;
		thousands = 0;
		SDWrite(highthousands, highhundreds, hightens, highones);

	} else {
		findAverageScore();
		gamesPlayed++;
		currentScoreCounter = 0;

		ones = 0;
		tens = 0;
		hundreds = 0;
		thousands = 0;
	}
	intervalCount = 0;
	incrementInterval = 5;

}

int oldHighScore(){

	oldHighscore = 0;
	oldHighscore += highthousands*1000;
	oldHighscore += highhundreds*100;
	oldHighscore += hightens*10;
	oldHighscore += highones;
	return oldHighscore;
}

#endif /* SRC_SCORE_H_ */
