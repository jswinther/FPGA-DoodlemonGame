/*
 * Score.h
 *
 *  Created on: 14. jan. 2019
 *      Author: bruger
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
