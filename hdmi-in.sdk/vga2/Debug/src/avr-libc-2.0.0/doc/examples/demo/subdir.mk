################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/avr-libc-2.0.0/doc/examples/demo/demo.c 

OBJS += \
./src/avr-libc-2.0.0/doc/examples/demo/demo.o 

C_DEPS += \
./src/avr-libc-2.0.0/doc/examples/demo/demo.d 


# Each subdirectory must supply rules for building sources it contributes
src/avr-libc-2.0.0/doc/examples/demo/%.o: ../src/avr-libc-2.0.0/doc/examples/demo/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../vga2_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


