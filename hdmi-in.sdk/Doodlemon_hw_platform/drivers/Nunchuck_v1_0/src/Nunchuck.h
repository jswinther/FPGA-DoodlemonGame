
#ifndef NUNCHUCK_H
#define NUNCHUCK_H


/****************** Include Files ********************/
#include "xil_types.h"
#include "xstatus.h"

#define NUNCHUCK_S00_AXI_SLV_REG0_OFFSET 0
#define NUNCHUCK_S00_AXI_SLV_REG1_OFFSET 4
#define NUNCHUCK_S00_AXI_SLV_REG2_OFFSET 8
#define NUNCHUCK_S00_AXI_SLV_REG3_OFFSET 12

int pwr( int numb, int to_pwr);
int get_speed(int multiplier, int power, int middle_interval);
int get_c_btn(void);
int get_z_btn(void);

#endif // NUNCHUCK_H
