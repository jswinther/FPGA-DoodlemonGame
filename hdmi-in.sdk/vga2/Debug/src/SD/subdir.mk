################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/SD/ff.c \
../src/SD/sdmm.c 

OBJS += \
./src/SD/ff.o \
./src/SD/sdmm.o 

C_DEPS += \
./src/SD/ff.d \
./src/SD/sdmm.d 


# Each subdirectory must supply rules for building sources it contributes
src/SD/%.o: ../src/SD/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../vga2_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


