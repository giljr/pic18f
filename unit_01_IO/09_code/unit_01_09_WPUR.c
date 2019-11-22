/*  Project:   Unit 01 - IO
       File:   unit_01_09_WPUR.c

  Objective:  For PIC18F4520:
              PORTB can be software programmed for internal weak pull-ups on all inputs
              For PIC18F45K202:
              Each of the PORTB pins has an individually controlled
              weak internal pull-up. When set, each bit of the WPUB
              register enables the corresponding pin pull-up. When
              cleared, the RBPU bit of the INTCON2 register enables
              pull-ups on all pins which also have their corresponding
              WPUB bit set. When set, the RBPU bit disables all
              weak pull-ups. The weak pull-up is automatically turned
              off when the port pin is configured as an output. The
              pull-ups are disabled on a Power-on Reset.

     Author:   microgenios, edited by J3

   Hardware:   Development Boards (OPTIONS):
                   PicGenios:   PIC18F4520 chip   ( https://loja.microgenios.com.br/produto/kit-picgenios-pic18f4520-com-gravador-usb-microicd-licen-a-compilador-mikroc-pro-for-pic/23507 )
                   EasyPIC™ 7:  PIC18F45K22 chip  ( https://www.microchip.com/Developmenttools/ProductDetails/TMIK013 )
   Software:   Development Programmer/Debugger:
                                PICkit™ 2         ( http://ww1.microchip.com/downloads/en/DeviceDoc/PICkit%202%20v2.61.00%20Setup%20A.zip )
                          mikroProg suite for PIC ( https://www.mikroe.com/blog/mikroprog-suite-for-pic-version-2-3-1-released )

        PDL:  is a free-format English-like text that describes the flow of control and data in a
              program. PDL is not a programming language. It is a collection of some keywords that enable
              a programmer to describe the operation of a program in a stepwise and logical manner:

              BEGIN
                  Define TRUE as 1
                  Pre-compilation Directives (#ifdef -chip options- #else #endif)
                  Configure PORTB pin 0 as digital input
                  Configure PORTD pin 0 as digital output
                  DO FOREVER
                      IF button is pressed THEN
                      Toggle the LED
                      Wait .3s
                  ENDDO
              END

       Date:   Nov 2019
*/

#define TRUE 1

void main() {
                                     // Pre-compilation Directives (#ifdef #else #endif)
#ifdef P18F45K22                     // For PIC18F45K22
       ANSELD = 0;                   // Config PORTD as digital, desabling ADC
       ANSELB = 0;                   // Config PORTB as digital
       INTCON2.RBPU = 0;             // RBPU is negated, so zero unable it;) serve as general key for all PORTB pull-ups resistors
       WPUB.WPUB0 = 1;               // Unable spscific for the button connected to it (only on PIC18F45K22)
#else                                // For PIC18F4520
       INTCON2.RBPU = 0;             // All PORTB pull-ups resistors are unable as zero (RBPU is negated:)
       ADCON1 |= 0X0F;               // Config all ADC's pins as digital on PIC18F4520
#endif

   TRISB.RB0 = 1;                    // BUTTON: Config PORTB.RB0 as input
   PORTB.RB0 = 1;                    // Optional, the MCU do it automatically ;)
                                     // Config all PORTB as logic HIGH
   
   TRISD = 0;                        // LEDs: Config PORTD as output
   PORTD = 0;                        // Optional, the MCU do it automatically ;)
                                     // Config all PORTB as logic LOW

    while(TRUE)                      // Endless loop
    {
        if(PORTB.RB0 == 0)
           {
              PORTD.RD0 =~LATD.RD0;  // Toggle the LED
              Delay_ms(300);         // Delay .3 s
           }
    }
  }