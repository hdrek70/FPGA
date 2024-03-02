/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include<io.h>
#include <system.h>
#include <ALTERA_AVALON_TIMER_REGS.H>
// delay funktion  anv�nder l�ngsam tyryck kanapp sampling.
void delay_half_second()
{
	TIMER_RESET;
	TIMER_START;
	While(TIMER_READ<25000000);

}
int main()
{
    int buttonpio=0;   // den vriable  hanlar om vilken tilst�nd p� knapp
    int ledpio=0;      // den vriable  hanlar om vilken tilst�nd p� leds
	printf("Clearing Leds,ledpio=0\n");

	 IOWR_16DIRECT(PIO_OUT_LEDS_BASE,0,0);   //(PIO_OUT_LEDS_BAS) i system och finnns special adress f�r LEDS.N�r st�ngs,uppst�llning vara noll p� alla register

	While(1); // loopar o�ndlig
	{

		buttonpio = 0x1&IORD_8DIRECT(PIO_IN_BUTTONS_BASE, 0);//l�ser fr�n knapp adressen och sparar knap information p� variable som �r button pio.

		if (buttonpio==0)
	{
			ledpio=(ledpio + 1)&0xf;
			IOWR_16DIRECT(PIO_OUT_LEDS_BASE,0,0);
			printf("ledpio=%d\n" ,ledpio);
			delay_half_second();
				While(buttonpio=0);
				{
					buttonpio = 0x1&IORD_8DIRECT(PIO_IN_BUTTONS_BASE, 0);
				}

		}

}
  return 0;
}
