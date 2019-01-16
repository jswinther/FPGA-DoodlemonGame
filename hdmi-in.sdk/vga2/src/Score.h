/*
 * Score.h
 *
 *  Created on: 14. jan. 2019
 *      Author: Nicolai
 */

#ifndef SRC_SCORE_H_
#define SRC_SCORE_H_
void averageScore(u16 counter);
u32 platformspeed = 15;
//Currenst score
u8 ones = 0;
u8 tens = 0;
u8 hundreds = 0;
u8 thousands = 0;
u16 onesCounter = 0;
u8 speedCounter = 0;


u16 highscore = 0;


//Highscore
u8 highones = 0;
u8 hightens = 0;
u8 highhundreds = 0;
u8 highthousands = 0;


//Average
u8 avgones = 0;
u8 avgtens = 0;
u8 avghundreds = 0;
u8 avgthousands = 0;

//Average score
u32 averageScoreCounter = 0;
u32 totalScore = 0;


//Times played
u32 gamesPlayed = 1;


void findAverageScore(){
	totalScore += onesCounter;
	averageScoreCounter = totalScore/gamesPlayed;
	xil_printf("Average score: %d", averageScoreCounter);
}
void Increment() {
	ones++;
	onesCounter++;
	if(onesCounter < 30 && onesCounter%5==0) {
			platformspeed+=3;
	}
	if(onesCounter >= 30 && onesCounter < 50){
		if( onesCounter%10==0) {
				platformspeed+=3;
		}}
	if(onesCounter >= 50 && onesCounter < 100){
			if( onesCounter%10==0) {
					platformspeed+=3;
			}}
	if(onesCounter >= 100){
		if( onesCounter%20==0) {
				platformspeed+=3;
		}}

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


void currentScore(u16 counter) {
	for(int i = 0; 1000 <= counter; i++) {
		counter -= 1000;
		thousands++;

	}
	for(int i = 0; 100 <= counter; i++) {
		counter -= 100;
		hundreds++;
	}

	for(int i = 0; 10 <= counter; i++) {
		counter -= 10;
		tens++;
	}

	for(int i = 0; 0 <= counter; i++) {
		counter -= 1;
		ones++;
	}
}

void averageScore(u16 counter) {
	for(int i = 0; 1000 <= counter; i++) {
		counter -= 1000;
		avgthousands++;

	}
	for(int i = 0; 100 <= counter; i++) {
		counter -= 100;
		avghundreds++;
	}

	for(int i = 0; 10 <= counter; i++) {
		counter -= 10;
		avgtens++;
	}

	for(int i = 0; 0 <= counter; i++) {
		counter -= 1;
		avgones++;
	}
}

void resetScore(){
	if(onesCounter > highscore) {
		highscore = onesCounter;
		highones = ones;
		hightens = tens;
		highhundreds = hundreds;
		highthousands = thousands;
		gamesPlayed++;
		onesCounter = 0;
		findAverageScore();
		ones = 0;
		tens = 0;
		hundreds = 0;
		thousands = 0;
	} else {
		gamesPlayed++;
		onesCounter = 0;
		findAverageScore();
		averageScore(averageScoreCounter);
		ones = 0;
		tens = 0;
		hundreds = 0;
		thousands = 0;
	}

}

#endif /* SRC_SCORE_H_ */
