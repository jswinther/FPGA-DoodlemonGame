

/***************************** Include Files *******************************/
#include "Nunchuck.h"
#include "xil_io.h"


// power and multiplier should be at least one
int get_speed(int multiplier, int power, int middle_nomove_offset, int middle)
{
   int datout = (int) Xil_In32(XPAR_NUNCHUCK_0_S00_AXI_BASEADDR + NUNCHUCK_S00_AXI_SLV_REG0_OFFSET);
   int positive_limit = middle + middle_nomove_offset;
   int negative_limit = middle - middle_nomove_offset;

 if( datout > positive_limit)
    {        
      return pwr((datout-positive_limit)*multiplier,power);  
    }
 else if(dataout < negative_limit) 
{
       // bitwise and for checking if even
       if((power & (int) 1) == 1)
        { 
            return pwr((datout-negative_limit)*multiplier,power);
        }
       else
        {
            return -pwr((datout-negative_limit)*multiplier,power);
        }
}
    else { return 0;}
}

// Power must be at least 1
int pwr( int numb, int to_pwr)
{
    int numb_of_mult;
    for(numb_of_mult = 0; numb_of_mult < (to_pwr - 1); numb_of_mult++)
            {
             numb = numb * numb;
            }
    return numb;
}

int get_c(void)
{
return (Xil_In32(XPAR_NUNCHUCK_0_S00_AXI_BASEADDR + NUNCHUCK_S00_AXI_SLV_REG2_OFFSET)&(u32)1;
}

int get_z(void)
{
return (Xil_In32(XPAR_NUNCHUCK_0_S00_AXI_BASEADDR + NUNCHUCK_S00_AXI_SLV_REG2_OFFSET)&(u32)2;
}


/************************** Function Definitions ***************************/
