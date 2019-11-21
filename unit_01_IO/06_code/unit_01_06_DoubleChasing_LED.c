/*  Project:   Unit 01 - IO
       File:   unit_01_06_DoubleChasing_LED.c

  Objective:   DOUBLE CHASING LEDS - The LEDs chase each other in both directions.
               cIn this project 8 LEDs are connected to PORTB
               of a PIC18F4520 (or PIC18F45K22) microcontroller and
               the microcontroller is operated from an 8 MHz crystal.


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
                  Initialize j as char (0b notation)
                  Initialize l as char (0b notation)
                  Pre-compilation Directives (#ifdef -chip options- #else #endif)
                  Configure PORTB pins as digital output
                  Initialize J = 1
                  DO FOREVER
                      Set PORTB = j&l
                      Shift right j by 1 digit
                      Shift  left l by 1 digit
                      Reset j if zero
                      Reset l if zero
                      Wait .1s
                  ENDDO
              END
       
       Date:   Nov 2019
*/

void main() {
    unsigned char j = 0b10000000 ;   // Initialize j as char (0b notation)
    unsigned char l = 0b00000001 ;   // Initialize l as char (0b notation)
                                     // Pre-compilation Directives (#ifdef #else #endif)
#ifdef PIC18F45K22                   // For PIC18F45K22
       ANSELB = 0;                   // Config PORTB as digital
#else                                // For PIC18F4520
       ADCON1 |= 0X0F;               // Config all ADC's pins as digital on PIC18F4520
#endif

   TRISB = 0;                        // Config PORTB as output
   PORTB = 0;                        // Optional, the MCU do it automatically ;)
                                     // Config all PORTB as logic LOW

for(;;)                              // Endless loop
    {
        PORTB = (j|l);
        j>>=1;                       // Cycle j bits
        l<<=1;                       // Cycle l bits
        if(j==0) j = 0b10000000;     // Reset j if zero
        if(l==0) l = 0b00000001;     // Reset l if zero
        Delay_ms(100);               // Delay .1 s
    }
}