/*  Project:   Unit 01 - IO
       File:   unit_01_05_Chasing_LED.c

  Objective:   CHASING LEDS-The program turns ON the LEDs in an anclockwise 
               manner with .1s delay between each output.
               The net result is that LEDs seem to be chasing each other.
               In this project 8 LEDs are connected to PORTB
               (on microgenios board set sw1 dip = 10, LEDs on PORTB);
               of a PIC18F4520 (or PIC18F45K22) microcontroller and 
               the microcontroller is operated from an 8 MHz crystal.

     Author:   Dogan Ibrahim, edited by J3

   Hardware:   Development Boards (OPTIONS):
                   PicGenios:   PIC18F4520 chip   ( https://loja.microgenios.com.br/produto/kit-picgenios-pic18f4520-com-gravador-usb-microicd-licen-a-compilador-mikroc-pro-for-pic/23507 )
                   EasyPIC™ 7:  PIC18F45K22 chip  ( https://www.microchip.com/Developmenttools/ProductDetails/TMIK013 )
   Software:   Development Programmer/Debugger:
                                PICkit™ 2         ( http://ww1.microchip.com/downloads/en/DeviceDoc/PICkit%202%20v2.61.00%20Setup%20A.zip )
                          mikroProg suite for PIC ( https://www.mikroe.com/blog/mikroprog-suite-for-pic-version-2-3-1-released )
   PDL:    is a free-format English-like text that describes the flow of control and data in a
                program. PDL is not a programming language. It is a collection of some keywords that enable
                a programmer to describe the operation of a program in a stepwise and logical manner:

              BEGIN
                  Initialize variable j to cycle 8 bits as 1 (0b00000001)
                  Pre-compilation Directives (config PORTB as digital)
                  Configure all PORTB as output
                  Initialize all PORTB with all LED off
                  DO FOREVER
                      Send j to PORTB
                      wait .1 s
                      bitwise left j assign to j
                      IF last bit THEN Reset j ENDIF
                  ENDDO
              END

       Date:   Oct 2019
*/

void main() {
    unsigned char j = 1 ;
                                     // For PIC18F45K22
#ifdef PIC18F45K22
       ANSELB = 0;                   // Config PORTB as digital
                                     // For PIC18F4520
#else
       ADCON1 |= 0X0F;               // Config all ADC's pins as digital on PIC18F4520
#endif
   
   TRISB = 0;                        // Config PORTB as output
   PORTB = 0;                        // Optional, the MCU do it automatically ;)
                                     // Config all PORTB as logic LOW
   
for(;;)                              // Endless loop
    {  
        PORTB = j;                   // Send j to PORTB
        Delay_ms(100);               // Delay 1 s
        j = j << 1;                  // Shift left j
        if(j == 0) j = 1;            // If last LED, move to first one

    }
}