################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_UPPER_SRCS += \
../src/avr-libc-2.0.0/libc/misc/eerd_block.S \
../src/avr-libc-2.0.0/libc/misc/eerd_byte.S \
../src/avr-libc-2.0.0/libc/misc/eerd_dword.S \
../src/avr-libc-2.0.0/libc/misc/eerd_word.S \
../src/avr-libc-2.0.0/libc/misc/eeupd_block.S \
../src/avr-libc-2.0.0/libc/misc/eeupd_byte.S \
../src/avr-libc-2.0.0/libc/misc/eeupd_dword.S \
../src/avr-libc-2.0.0/libc/misc/eeupd_word.S \
../src/avr-libc-2.0.0/libc/misc/eewr_block.S \
../src/avr-libc-2.0.0/libc/misc/eewr_byte.S \
../src/avr-libc-2.0.0/libc/misc/eewr_dword.S \
../src/avr-libc-2.0.0/libc/misc/eewr_word.S \
../src/avr-libc-2.0.0/libc/misc/itoa.S \
../src/avr-libc-2.0.0/libc/misc/itoa_ncheck.S \
../src/avr-libc-2.0.0/libc/misc/ltoa.S \
../src/avr-libc-2.0.0/libc/misc/ltoa_ncheck.S \
../src/avr-libc-2.0.0/libc/misc/mul10.S \
../src/avr-libc-2.0.0/libc/misc/mulsi10.S \
../src/avr-libc-2.0.0/libc/misc/ultoa.S \
../src/avr-libc-2.0.0/libc/misc/ultoa_ncheck.S \
../src/avr-libc-2.0.0/libc/misc/utoa.S \
../src/avr-libc-2.0.0/libc/misc/utoa_ncheck.S 

OBJS += \
./src/avr-libc-2.0.0/libc/misc/eerd_block.o \
./src/avr-libc-2.0.0/libc/misc/eerd_byte.o \
./src/avr-libc-2.0.0/libc/misc/eerd_dword.o \
./src/avr-libc-2.0.0/libc/misc/eerd_word.o \
./src/avr-libc-2.0.0/libc/misc/eeupd_block.o \
./src/avr-libc-2.0.0/libc/misc/eeupd_byte.o \
./src/avr-libc-2.0.0/libc/misc/eeupd_dword.o \
./src/avr-libc-2.0.0/libc/misc/eeupd_word.o \
./src/avr-libc-2.0.0/libc/misc/eewr_block.o \
./src/avr-libc-2.0.0/libc/misc/eewr_byte.o \
./src/avr-libc-2.0.0/libc/misc/eewr_dword.o \
./src/avr-libc-2.0.0/libc/misc/eewr_word.o \
./src/avr-libc-2.0.0/libc/misc/itoa.o \
./src/avr-libc-2.0.0/libc/misc/itoa_ncheck.o \
./src/avr-libc-2.0.0/libc/misc/ltoa.o \
./src/avr-libc-2.0.0/libc/misc/ltoa_ncheck.o \
./src/avr-libc-2.0.0/libc/misc/mul10.o \
./src/avr-libc-2.0.0/libc/misc/mulsi10.o \
./src/avr-libc-2.0.0/libc/misc/ultoa.o \
./src/avr-libc-2.0.0/libc/misc/ultoa_ncheck.o \
./src/avr-libc-2.0.0/libc/misc/utoa.o \
./src/avr-libc-2.0.0/libc/misc/utoa_ncheck.o 

S_UPPER_DEPS += \
./src/avr-libc-2.0.0/libc/misc/eerd_block.d \
./src/avr-libc-2.0.0/libc/misc/eerd_byte.d \
./src/avr-libc-2.0.0/libc/misc/eerd_dword.d \
./src/avr-libc-2.0.0/libc/misc/eerd_word.d \
./src/avr-libc-2.0.0/libc/misc/eeupd_block.d \
./src/avr-libc-2.0.0/libc/misc/eeupd_byte.d \
./src/avr-libc-2.0.0/libc/misc/eeupd_dword.d \
./src/avr-libc-2.0.0/libc/misc/eeupd_word.d \
./src/avr-libc-2.0.0/libc/misc/eewr_block.d \
./src/avr-libc-2.0.0/libc/misc/eewr_byte.d \
./src/avr-libc-2.0.0/libc/misc/eewr_dword.d \
./src/avr-libc-2.0.0/libc/misc/eewr_word.d \
./src/avr-libc-2.0.0/libc/misc/itoa.d \
./src/avr-libc-2.0.0/libc/misc/itoa_ncheck.d \
./src/avr-libc-2.0.0/libc/misc/ltoa.d \
./src/avr-libc-2.0.0/libc/misc/ltoa_ncheck.d \
./src/avr-libc-2.0.0/libc/misc/mul10.d \
./src/avr-libc-2.0.0/libc/misc/mulsi10.d \
./src/avr-libc-2.0.0/libc/misc/ultoa.d \
./src/avr-libc-2.0.0/libc/misc/ultoa_ncheck.d \
./src/avr-libc-2.0.0/libc/misc/utoa.d \
./src/avr-libc-2.0.0/libc/misc/utoa_ncheck.d 


# Each subdirectory must supply rules for building sources it contributes
src/avr-libc-2.0.0/libc/misc/%.o: ../src/avr-libc-2.0.0/libc/misc/%.S
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../vga2_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


