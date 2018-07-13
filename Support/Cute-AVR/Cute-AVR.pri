#
# Based on the Cute-AVR project <https://github.com/eng-mg/CuteAVR>
# Copyright (c) Mohammed Gamal <https://github.com/eng-mg>
# File released under GNU Lesser General Public License v2.1
#
# Modifications by Alex Spataru <https://github.com/alex-spataru>
#

#-------------------------------------------------------------------------------
# MCU configuration
#-------------------------------------------------------------------------------

include ($$PWD/MCU-Setup.pri)

#-------------------------------------------------------------------------------
# Hacks
#-------------------------------------------------------------------------------

VERBOS = "@"
show_progs_excution: VERBOS = ""

TARGET_EXT = .elf
OUTPUT_ELF = $$TARGET$$TARGET_EXT
OUTPUT_HEX = $${TARGET}.hex
OUTPUT_LST = $${TARGET}.lss
OUTPUT_EEP = $${TARGET}.eep
TARGET = $${OUTPUT_ELF}

#-------------------------------------------------------------------------------
# Toolchain setup
#-------------------------------------------------------------------------------

AVR_LIB_DIR = "\"$$AVR_TOOLCHAIN_DIR/lib\""
AVR_INC_DIR = "\"$$AVR_TOOLCHAIN_DIR/include\""

AVRC        = "\"$$AVR_COMPILER_DIR/avr-gcc\""
AVRCXX      = "\"$$AVR_COMPILER_DIR/avr-g++\""
AVR_LINKER  = "\"$$AVR_COMPILER_DIR/avr-gcc\""
AVRSTRIP    = "$${VERBOS}\"$$AVR_COMPILER_DIR/avr-strip\""
AVROBJCPY   = "$${VERBOS}\"$$AVR_COMPILER_DIR/avr-objcopy\""
AVROBJDUMP  = "$${VERBOS}\"$$AVR_COMPILER_DIR/avr-objdump\""

AVRSIZE     = "$${VERBOS}echo \'Size of each memory section (in bytes)\'"\
"&& echo \'--------------------------------------------------------\'"\
"&& \"$$AVR_COMPILER_DIR/avr-size\""\

#-------------------------------------------------------------------------------
# Setup the upload tool (avrdude)
#-------------------------------------------------------------------------------

UPLOADER = "\"$${UPLOADER_DIR}/avrdude\""
UPLOADER_ARGS = "-c $$UPLOADER_PROGRAMMER -P $$UPLOADER_PORT -b $$UPLOADER_BAUD -p $$UPLOADER_PARTNO -U flash:w:"$$OUTPUT_HEX":i"

#-------------------------------------------------------------------------------
# C compiler flags
#-------------------------------------------------------------------------------

CSTANDARD   = "-std=gnu99"
CDEBUG      = "-g2"
CWARN_OPTS  = "-Wall"
C_OTHER     = "-x c -MD -MP -MT \"${OBJECTS}\" -funsigned-char -funsigned-bitfields -ffunction-sections -fdata-sections -fpack-struct -fshort-enums"
COPTIMIZE   = "-O$${COMPILER_OPTIMATZTION_LEVEL}"
CMCU        = "-mmcu=$$lower($$MCU)"

AVR_CFLAGS  = "$$CSTANDARD $$CDEBUG $$CWARN_OPTS $$C_OTHER $$COPTIMIZE $$CMCU"
AVR_LFLAGS  = "-Wl,-Map=\"$${TARGET}.map\" -Wl,--start-group -Wl,-lm  -Wl,--end-group -Wl,--gc-sections $$CMCU"

QMAKE_INCDIR = $$AVR_INC_DIR
QMAKE_LIBDIR = $$AVR_LIB_DIR
QMAKE_CC = $$AVRC
QMAKE_CXX = $$AVRCXX
QMAKE_LINK = $$AVR_LINKER
QMAKE_LFLAGS_RELEASE = "$$AVR_LFLAGS"

DEF_MCU = "__AVR_$${MCU}__"
DEFINES = "$$DEF_MCU"

QMAKE_CFLAGS_RELEASE = "$$AVR_CFLAGS"
QMAKE_LFLAGS = ""
QMAKE_CFLAGS = ""

INCLUDEPATH += "$$AVR_TOOLCHAIN_DIR/include"

#-------------------------------------------------------------------------------
# Additional avr-specific targets
#-------------------------------------------------------------------------------

avr_strip.target = .strip
avr_strip.commands = "$$AVRSTRIP $$OUTPUT_ELF"
avr_strip.depends = all

avr_gen_hex.target = .genhex
avr_gen_hex.commands = "$$AVROBJCPY  -O ihex -R .eeprom -R .fuse -R .lock -R .signature -R .user_signatures $$OUTPUT_ELF $$OUTPUT_HEX"
avr_gen_hex.depends = avr_strip

avr_eeprom.target = .eeprom
avr_eeprom.commands = "$$AVROBJCPY -j .eeprom  --set-section-flags=.eeprom=alloc,load\
 --change-section-lma .eeprom=0 --no-change-warnings -O ihex $$OUTPUT_ELF $$OUTPUT_EEP"
avr_eeprom.depends = avr_gen_hex

avr_gen_lst.target = .genlst
avr_gen_lst.commands = $$AVROBJDUMP -h -S $$OUTPUT_ELF > $$OUTPUT_LST
avr_gen_lst.depends = avr_eeprom

avr_prntsize.target = .prntsize
avr_prntsize.commands = $$AVRSIZE $$OUTPUT_ELF
avr_prntsize.depends = avr_gen_lst

upload_hex {
    avr_upload.target = .avr_upload
    avr_upload.depends = avr_prntsize
    avr_upload.commands = "$$UPLOADER $$UPLOADER_ARGS"
    first.depends = avr_upload
}

else {
    first.depends = avr_prntsize
}

QMAKE_EXTRA_TARGETS += first avr_strip avr_gen_hex avr_eeprom avr_gen_lst avr_prntsize avr_upload
