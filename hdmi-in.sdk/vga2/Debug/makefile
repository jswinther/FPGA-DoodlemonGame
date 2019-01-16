################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include src/video_capture/subdir.mk
-include src/timer_ps/subdir.mk
-include src/intc/subdir.mk
-include src/dynclk/subdir.mk
-include src/display_ctrl/subdir.mk
-include src/avr-libc-2.0.0/libm/fplib/subdir.mk
-include src/avr-libc-2.0.0/libc/time/subdir.mk
-include src/avr-libc-2.0.0/libc/string/subdir.mk
-include src/avr-libc-2.0.0/libc/stdlib/subdir.mk
-include src/avr-libc-2.0.0/libc/stdio/subdir.mk
-include src/avr-libc-2.0.0/libc/pmstring/subdir.mk
-include src/avr-libc-2.0.0/libc/misc/subdir.mk
-include src/avr-libc-2.0.0/doc/examples/twitest/subdir.mk
-include src/avr-libc-2.0.0/doc/examples/stdiodemo/subdir.mk
-include src/avr-libc-2.0.0/doc/examples/largedemo/subdir.mk
-include src/avr-libc-2.0.0/doc/examples/demo/subdir.mk
-include src/avr-libc-2.0.0/doc/examples/asmdemo/subdir.mk
-include src/avr-libc-2.0.0/crt1/iosym/subdir.mk
-include src/avr-libc-2.0.0/crt1/subdir.mk
-include src/SD/subdir.mk
-include src/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
ELFSIZE += \
vga2.elf.size \


# All Target
all: pre-build main-build

# Main-build Target
main-build: vga2.elf secondary-outputs

# Tool invocations
vga2.elf: $(OBJS) ../src/lscript.ld $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: ARM v7 gcc linker'
	arm-none-eabi-gcc -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -Wl,-build-id=none -specs=Xilinx.spec -Wl,-T -Wl,../src/lscript.ld -L../../vga2_bsp/ps7_cortexa9_0/lib -o "vga2.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

vga2.elf.size: vga2.elf
	@echo 'Invoking: ARM v7 Print Size'
	arm-none-eabi-size vga2.elf  |tee "vga2.elf.size"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(EXECUTABLES)$(OBJS)$(S_UPPER_DEPS)$(C_DEPS)$(ELFSIZE) vga2.elf
	-@echo ' '

pre-build:
	-a9-linaro-pre-build-step
	-@echo ' '

secondary-outputs: $(ELFSIZE)

.PHONY: all clean dependents
.SECONDARY: main-build pre-build

-include ../makefile.targets
