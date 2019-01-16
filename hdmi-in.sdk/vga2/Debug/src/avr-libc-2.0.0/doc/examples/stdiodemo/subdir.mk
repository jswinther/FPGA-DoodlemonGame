################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/avr-libc-2.0.0/doc/examples/stdiodemo/hd44780.c \
../src/avr-libc-2.0.0/doc/examples/stdiodemo/lcd.c \
../src/avr-libc-2.0.0/doc/examples/stdiodemo/stdiodemo.c \
../src/avr-libc-2.0.0/doc/examples/stdiodemo/uart.c 

OBJS += \
./src/avr-libc-2.0.0/doc/examples/stdiodemo/hd44780.o \
./src/avr-libc-2.0.0/doc/examples/stdiodemo/lcd.o \
./src/avr-libc-2.0.0/doc/examples/stdiodemo/stdiodemo.o \
./src/avr-libc-2.0.0/doc/examples/stdiodemo/uart.o 

C_DEPS += \
./src/avr-libc-2.0.0/doc/examples/stdiodemo/hd44780.d \
./src/avr-libc-2.0.0/doc/examples/stdiodemo/lcd.d \
./src/avr-libc-2.0.0/doc/examples/stdiodemo/stdiodemo.d \
./src/avr-libc-2.0.0/doc/examples/stdiodemo/uart.d 


# Each subdirectory must supply rules for building sources it contributes
src/avr-libc-2.0.0/doc/examples/stdiodemo/%.o: ../src/avr-libc-2.0.0/doc/examples/stdiodemo/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../vga2_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


