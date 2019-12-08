/*   Project: Unit 10 - 7SEGS
        Code: unit_10_0_7segsTest.c
      
   Objective:     This program writes the value 1234 on the 7-segment displayCrystal = 8MHz:)
                  The example program below was compiled on the mikroC compiler (www.mikroe.com)
                  and aims to write on displays Kit PICGenios Microgens Technology Center.
                  Note: It does make use of the scanning technique (on-off-on cycle);
                        all the LEDs stay on for 1ms and we get the impression that
                        all the LEDs are on at the same time forever;
                        This is called Persistence Of Vision - POV :D

      Author:   microgenios, edited by J3

   PIC Lessons: How to Start to Program PIC 18 - Step-by-step for Beginners!

   Hardware:    Development Boards (OPTIONS):
                   PicGenios:   PIC18F4520 chip   ( https://loja.microgenios.com.br/produto/kit-picgenios-pic18f4520-com-gravador-usb-microicd-licen-a-compilador-mikroc-pro-for-pic/23507 )
                   EasyPIC™ 7:  PIC18F45K22 chip  ( https://www.microchip.com/Developmenttools/ProductDetails/TMIK013 )
   Software:    Development Programmer/Debugger:
                                PICkit™ 2         ( http://ww1.microchip.com/downloads/en/DeviceDoc/PICkit%202%20v2.61.00%20Setup%20A.zip )
                          mikroProg suite for PIC ( https://www.mikroe.com/blog/mikroprog-suite-for-pic-version-2-3-1-released )
       
      Date:     Dez 2019
*/
 void main(){                      // Main function of the program
    ADCON1 = 6;                    // Set all AD pins to I / O
    PORTA = 0;                     // Resets all PORTA pins
    TRISA = 0;                     // Set PORTA as output
    TRISD = 0;                     // Define PORTD as output
    PORTD = 255;                   // Set all PORTD pins as HIGH
 
 do {                              // Start of loop routine
    PORTA.B2= 1;                   // Turn on the first display
    PORTD = 0x06;                  // Write digit 1 (cathode)
    Delay_ms(1);                   // Delay de 1ms
    PORTA.B2= 0;                   // Turn off the first display
    PORTA.B3= 1;                   // Turn on the second display
    PORTD = 0x5B;                  // Write digit 2 (cathode)
    Delay_ms(1);                   // Delay de 1ms
    PORTA.B3= 0;                   // Turn off the second display
    PORTA.B4= 1;                   // Turn on the third display
    PORTD = 0x4F;                  // Write digit 3 (cathode)
    Delay_ms(1);                   // Delay de 1ms
    PORTA.B4= 0;                   // Turn off the third display
    PORTA.B5= 1;                   // Turn on the fourth display
    PORTD = 0x66;                  // Write digit 4 (cathode)
    Delay_ms(1);                   // Delay de 1ms
    PORTA.B5= 0;                   //Turn off the fourth display
   }
 while (1);
}