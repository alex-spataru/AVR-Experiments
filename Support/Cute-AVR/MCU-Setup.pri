#
# Based on the Cute-AVR project <https://github.com/eng-mg/CuteAVR>
# Copyright (c) Mohammed Gamal <https://github.com/eng-mg>
# File released under GNU Lesser General Public License v2.1
#
# Modifications by Alex Spataru <https://github.com/alex-spataru>
#

#
# Project configuration
#
CONFIG = ""
TEMPLATE = app

#
# Make options
#
UI_DIR = uic
MOC_DIR = moc
RCC_DIR = qrc
OBJECTS_DIR = obj

#
# Change this to match your AVR microcontroller's part number.
# Please use the exact part number of the mcu and pay attention to the capitalization.
#
MCU = ATmega328P

#
# Specify the serial port to which the programmer is connected
#
UPLOADER_PORT = usb

#
# Set the baudrate of the programmer connection for avrdude
#
UPLOADER_BAUD = 115200

#
# Specify the programmer for avrdude
#
UPLOADER_PROGRAMMER = usbasp

#
# Set the part number of the microcontroller for avrdude (sometimes avrdude uses different
# part number from the actual part number of the microcontroller)
# leave the following line unchanged if the part numbers are equal.
UPLOADER_PARTNO = $$MCU

#
# Set optimization level *avr-gcc oprimazation levels can be one of (0, 1, 2, s)*
#
COMPILER_OPTIMATZTION_LEVEL = 1

#
# Set the avr-gnu toolchain path (Linux 64-bit, using system packages)
#
linux* {
    AVR_COMPILER_DIR = "/usr/bin"
    AVR_TOOLCHAIN_DIR = "/usr/lib/avr"
}

#
# Set the uploader (avrdude) path
#
linux* {
    UPLOADER_DIR = "/usr/bin"
}

#
# Comment the following line (using #) if you don't want to upload the output '.hex' file after building
#
CONFIG += upload_hex

#
# Comment the following line (using #) if you don't care to watch avr programs work
#
#CONFIG += show_progs_excution
