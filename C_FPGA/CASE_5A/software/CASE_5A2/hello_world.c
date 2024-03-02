

#include <stdio.h>
#include<io.h>
#include <system.h>
#include <ALTERA_AVALON_TIMER_REGS.H>
// delay funktion  använder långsam tyryck kanapp sampling.
void delay_half_second()
{
	TIMER_RESET;
	TIMER_START;
	While(TIMER_READ<25000000);

}
int main()
{
    int buttonpio=0;   // den vriable  hanlar om vilken tilstånd på knapp
    int ledpio=0;      // den vriable  hanlar om vilken tilstånd på leds
	printf("Clearing Leds,ledpio=0\n");

	 IOWR_16DIRECT(PIO_OUT_LEDS_BASE,0,0);   //(PIO_OUT_LEDS_BAS) i system och finnns special adress för LEDS.När stängs,uppställning vara noll på alla register

	While(1); // loopar oändlig
	{

		buttonpio = 0x1&IORD_8DIRECT(PIO_IN_BUTTONS_BASE, 0);//läser från knapp adressen och sparar knap information på variable som är button pio.

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
