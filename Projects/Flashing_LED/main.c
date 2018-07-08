/*
 * Copyright (c) 2018 Alex Spataru <https://github.com/alex-spataru>
 * Released under the DBAD Public License <http://dbad-license.org/>
 * 
 * Program description: Turns a LED on and off every 1 second
 */ 

/*
 * Include libraries
 */
#include <avr/io.h>
#include <util/delay.h>

/*
 * Main entry point function
 */
int main (void)
{
    /* Used to register the state of the LED */
    short ledOutput = 0;

    /* Configure port B I/O*/
    DDRB |= 0b00100000;

    /* Main loop */
    while (1)
    {
        /* Invert LED state */
        ledOutput = !ledOutput;

        /* Change output of P25 (digital pin 13) */
        PORTB = ledOutput ? 0x20 : 0x00;

        /* Wait a little */
        _delay_ms (1000);
    }

    /* Exit (should not happen during normal operation */
    return 0;
}
