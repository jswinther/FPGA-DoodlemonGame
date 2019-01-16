################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/avr-libc-2.0.0/libc/time/asc_store.c \
../src/avr-libc-2.0.0/libc/time/asctime.c \
../src/avr-libc-2.0.0/libc/time/asctime_r.c \
../src/avr-libc-2.0.0/libc/time/ctime.c \
../src/avr-libc-2.0.0/libc/time/ctime_r.c \
../src/avr-libc-2.0.0/libc/time/daylight_seconds.c \
../src/avr-libc-2.0.0/libc/time/difftime.c \
../src/avr-libc-2.0.0/libc/time/dst_pointer.c \
../src/avr-libc-2.0.0/libc/time/equation_of_time.c \
../src/avr-libc-2.0.0/libc/time/fatfs_time.c \
../src/avr-libc-2.0.0/libc/time/geo_location.c \
../src/avr-libc-2.0.0/libc/time/gm_sidereal.c \
../src/avr-libc-2.0.0/libc/time/gmtime.c \
../src/avr-libc-2.0.0/libc/time/gmtime_r.c \
../src/avr-libc-2.0.0/libc/time/isLeap.c \
../src/avr-libc-2.0.0/libc/time/iso_week_date.c \
../src/avr-libc-2.0.0/libc/time/iso_week_date_r.c \
../src/avr-libc-2.0.0/libc/time/isotime.c \
../src/avr-libc-2.0.0/libc/time/isotime_r.c \
../src/avr-libc-2.0.0/libc/time/lm_sidereal.c \
../src/avr-libc-2.0.0/libc/time/localtime.c \
../src/avr-libc-2.0.0/libc/time/localtime_r.c \
../src/avr-libc-2.0.0/libc/time/mk_gmtime.c \
../src/avr-libc-2.0.0/libc/time/mktime.c \
../src/avr-libc-2.0.0/libc/time/month_length.c \
../src/avr-libc-2.0.0/libc/time/moon_phase.c \
../src/avr-libc-2.0.0/libc/time/print_lz.c \
../src/avr-libc-2.0.0/libc/time/set_dst.c \
../src/avr-libc-2.0.0/libc/time/set_position.c \
../src/avr-libc-2.0.0/libc/time/set_system_time.c \
../src/avr-libc-2.0.0/libc/time/set_zone.c \
../src/avr-libc-2.0.0/libc/time/solar_declination.c \
../src/avr-libc-2.0.0/libc/time/solar_noon.c \
../src/avr-libc-2.0.0/libc/time/strftime.c \
../src/avr-libc-2.0.0/libc/time/sun_rise.c \
../src/avr-libc-2.0.0/libc/time/sun_set.c \
../src/avr-libc-2.0.0/libc/time/system_time.c \
../src/avr-libc-2.0.0/libc/time/time.c \
../src/avr-libc-2.0.0/libc/time/tm_store.c \
../src/avr-libc-2.0.0/libc/time/utc_offset.c \
../src/avr-libc-2.0.0/libc/time/week_of_month.c \
../src/avr-libc-2.0.0/libc/time/week_of_year.c 

S_UPPER_SRCS += \
../src/avr-libc-2.0.0/libc/time/system_tick.S 

OBJS += \
./src/avr-libc-2.0.0/libc/time/asc_store.o \
./src/avr-libc-2.0.0/libc/time/asctime.o \
./src/avr-libc-2.0.0/libc/time/asctime_r.o \
./src/avr-libc-2.0.0/libc/time/ctime.o \
./src/avr-libc-2.0.0/libc/time/ctime_r.o \
./src/avr-libc-2.0.0/libc/time/daylight_seconds.o \
./src/avr-libc-2.0.0/libc/time/difftime.o \
./src/avr-libc-2.0.0/libc/time/dst_pointer.o \
./src/avr-libc-2.0.0/libc/time/equation_of_time.o \
./src/avr-libc-2.0.0/libc/time/fatfs_time.o \
./src/avr-libc-2.0.0/libc/time/geo_location.o \
./src/avr-libc-2.0.0/libc/time/gm_sidereal.o \
./src/avr-libc-2.0.0/libc/time/gmtime.o \
./src/avr-libc-2.0.0/libc/time/gmtime_r.o \
./src/avr-libc-2.0.0/libc/time/isLeap.o \
./src/avr-libc-2.0.0/libc/time/iso_week_date.o \
./src/avr-libc-2.0.0/libc/time/iso_week_date_r.o \
./src/avr-libc-2.0.0/libc/time/isotime.o \
./src/avr-libc-2.0.0/libc/time/isotime_r.o \
./src/avr-libc-2.0.0/libc/time/lm_sidereal.o \
./src/avr-libc-2.0.0/libc/time/localtime.o \
./src/avr-libc-2.0.0/libc/time/localtime_r.o \
./src/avr-libc-2.0.0/libc/time/mk_gmtime.o \
./src/avr-libc-2.0.0/libc/time/mktime.o \
./src/avr-libc-2.0.0/libc/time/month_length.o \
./src/avr-libc-2.0.0/libc/time/moon_phase.o \
./src/avr-libc-2.0.0/libc/time/print_lz.o \
./src/avr-libc-2.0.0/libc/time/set_dst.o \
./src/avr-libc-2.0.0/libc/time/set_position.o \
./src/avr-libc-2.0.0/libc/time/set_system_time.o \
./src/avr-libc-2.0.0/libc/time/set_zone.o \
./src/avr-libc-2.0.0/libc/time/solar_declination.o \
./src/avr-libc-2.0.0/libc/time/solar_noon.o \
./src/avr-libc-2.0.0/libc/time/strftime.o \
./src/avr-libc-2.0.0/libc/time/sun_rise.o \
./src/avr-libc-2.0.0/libc/time/sun_set.o \
./src/avr-libc-2.0.0/libc/time/system_tick.o \
./src/avr-libc-2.0.0/libc/time/system_time.o \
./src/avr-libc-2.0.0/libc/time/time.o \
./src/avr-libc-2.0.0/libc/time/tm_store.o \
./src/avr-libc-2.0.0/libc/time/utc_offset.o \
./src/avr-libc-2.0.0/libc/time/week_of_month.o \
./src/avr-libc-2.0.0/libc/time/week_of_year.o 

S_UPPER_DEPS += \
./src/avr-libc-2.0.0/libc/time/system_tick.d 

C_DEPS += \
./src/avr-libc-2.0.0/libc/time/asc_store.d \
./src/avr-libc-2.0.0/libc/time/asctime.d \
./src/avr-libc-2.0.0/libc/time/asctime_r.d \
./src/avr-libc-2.0.0/libc/time/ctime.d \
./src/avr-libc-2.0.0/libc/time/ctime_r.d \
./src/avr-libc-2.0.0/libc/time/daylight_seconds.d \
./src/avr-libc-2.0.0/libc/time/difftime.d \
./src/avr-libc-2.0.0/libc/time/dst_pointer.d \
./src/avr-libc-2.0.0/libc/time/equation_of_time.d \
./src/avr-libc-2.0.0/libc/time/fatfs_time.d \
./src/avr-libc-2.0.0/libc/time/geo_location.d \
./src/avr-libc-2.0.0/libc/time/gm_sidereal.d \
./src/avr-libc-2.0.0/libc/time/gmtime.d \
./src/avr-libc-2.0.0/libc/time/gmtime_r.d \
./src/avr-libc-2.0.0/libc/time/isLeap.d \
./src/avr-libc-2.0.0/libc/time/iso_week_date.d \
./src/avr-libc-2.0.0/libc/time/iso_week_date_r.d \
./src/avr-libc-2.0.0/libc/time/isotime.d \
./src/avr-libc-2.0.0/libc/time/isotime_r.d \
./src/avr-libc-2.0.0/libc/time/lm_sidereal.d \
./src/avr-libc-2.0.0/libc/time/localtime.d \
./src/avr-libc-2.0.0/libc/time/localtime_r.d \
./src/avr-libc-2.0.0/libc/time/mk_gmtime.d \
./src/avr-libc-2.0.0/libc/time/mktime.d \
./src/avr-libc-2.0.0/libc/time/month_length.d \
./src/avr-libc-2.0.0/libc/time/moon_phase.d \
./src/avr-libc-2.0.0/libc/time/print_lz.d \
./src/avr-libc-2.0.0/libc/time/set_dst.d \
./src/avr-libc-2.0.0/libc/time/set_position.d \
./src/avr-libc-2.0.0/libc/time/set_system_time.d \
./src/avr-libc-2.0.0/libc/time/set_zone.d \
./src/avr-libc-2.0.0/libc/time/solar_declination.d \
./src/avr-libc-2.0.0/libc/time/solar_noon.d \
./src/avr-libc-2.0.0/libc/time/strftime.d \
./src/avr-libc-2.0.0/libc/time/sun_rise.d \
./src/avr-libc-2.0.0/libc/time/sun_set.d \
./src/avr-libc-2.0.0/libc/time/system_time.d \
./src/avr-libc-2.0.0/libc/time/time.d \
./src/avr-libc-2.0.0/libc/time/tm_store.d \
./src/avr-libc-2.0.0/libc/time/utc_offset.d \
./src/avr-libc-2.0.0/libc/time/week_of_month.d \
./src/avr-libc-2.0.0/libc/time/week_of_year.d 


# Each subdirectory must supply rules for building sources it contributes
src/avr-libc-2.0.0/libc/time/%.o: ../src/avr-libc-2.0.0/libc/time/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../vga2_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/avr-libc-2.0.0/libc/time/%.o: ../src/avr-libc-2.0.0/libc/time/%.S
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../vga2_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


