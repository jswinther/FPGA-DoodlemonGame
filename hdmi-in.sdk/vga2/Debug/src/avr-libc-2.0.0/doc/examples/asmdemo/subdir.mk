################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/avr-libc-2.0.0/doc/examples/asmdemo/asmdemo.c 

S_UPPER_SRCS += \
../src/avr-libc-2.0.0/doc/examples/asmdemo/isrs.S 

OBJS += \
./src/avr-libc-2.0.0/doc/examples/asmdemo/asmdemo.o \
./src/avr-libc-2.0.0/doc/examples/asmdemo/isrs.o 

S_UPPER_DEPS += \
./src/avr-libc-2.0.0/doc/examples/asmdemo/isrs.d 

C_DEPS += \
./src/avr-libc-2.0.0/doc/examples/asmdemo/asmdemo.d 


# Each subdirectory must supply rules for building sources it contributes
src/avr-libc-2.0.0/doc/examples/asmdemo/%.o: ../src/avr-libc-2.0.0/doc/examples/asmdemo/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../vga2_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/avr-libc-2.0.0/doc/examples/asmdemo/%.o: ../src/avr-libc-2.0.0/doc/examples/asmdemo/%.S
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../vga2_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

