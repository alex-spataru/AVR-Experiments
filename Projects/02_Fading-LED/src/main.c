/*
 * Copyright (c) 2018 Alex Spataru <https://github.com/alex-spataru>
 * Released under the DBAD Public License <http://dbad-license.org/>
 * 
 * Progam description: Implements method to gradually dim a LED over the period
 *                     of one second in a nice cycle.
 */

#include <avr/io.h>
#include <util/delay.h>

/*
 * Define the period of the LED cycle
 */ 
static const double PERIOD = 1000;

/*
 * Define the minimum and maximum brightness of the LED. The maximum brightness
 * cannot exceed the value of PERIOD.
 */ 
static const double MIN_BRIGHTNESS = 0;
static const double MAX_BRIGHTNESS = 1000;

/* 
 * Custom delay implementation to get around error:
 *      __builtin_avr_delay_cycles expects a compile time integer constant
 */ 
static void delay (const int milliseconds)
{
    int i;
    for (i = 0; i < milliseconds; ++i)
        _delay_us (1);
}

/*
 * Main entry point of the application
 */
int main (void)
{
    /* Initialize variables */
    double brightness = MIN_BRIGHTNESS;
    double changeRate = (MAX_BRIGHTNESS - MIN_BRIGHTNESS) / PERIOD;
    
    /* Configure port B I/O*/
    DDRB |= 0b00100000;

    /* Main loop */
    while (1)
    {
        /* Modify brightness */
        brightness += changeRate;
        if (brightness > PERIOD || brightness < MIN_BRIGHTNESS)
            changeRate *= -1;
        
        /* Calulate delay time using brightness */
        int off_time = (int) (PERIOD - brightness);
        
        /* Turn LED off */
        PORTB = 0x00;
        delay (off_time);
        
        /* Turn LED on */
        PORTB = 0x20;
        delay ((int) (PERIOD - off_time));
    }
}
