/* Project: Unit 04 - TMR
      Code: unit_04_01_timer0Extended.c [TMR0@5s]

   Objective:   In this project let's configure Timer0 to overflow at each 5s.
                An LED (attached on PORTD.RB0) will blink at each 5 second:)
                See Calculation Memory for better code's undenstanding:)

      Author:   microgenios, edited by J3

   PIC Lessons: How to Start to Program PIC 18 - Step-by-step for Beginners!

   Hardware:    Development Boards (OPTIONS):
                   PicGenios:   PIC18F4520 chip   ( https://loja.microgenios.com.br/produto/kit-picgenios-pic18f4520-com-gravador-usb-microicd-licen-a-compilador-mikroc-pro-for-pic/23507 )
                   EasyPIC™ 7:  PIC18F45K22 chip  ( https://www.microchip.com/Developmenttools/ProductDetails/TMIK013 )
   Software:    Development Programmer/Debugger:
                                PICkit™ 2         ( http://ww1.microchip.com/downloads/en/DeviceDoc/PICkit%202%20v2.61.00%20Setup%20A.zip )
                          mikroProg suite for PIC ( https://www.mikroe.com/blog/mikroprog-suite-for-pic-version-2-3-1-released )

        PDL:    is a free-format English-like text that describes the flow of control and data in a
                program. PDL is not a programming language. It is a collection of some keywords that enable
                a programmer to describe the operation of a program in a stepwise and logical manner:

              BEGIN
                  Initialize a counter char variable (count 1-5 max)
                  Call CONFIGMCU
                  Call CONFIGTIMER
                       DO FOREVER
                              IF Timer0 overflow THEN
                                 Autoincrement counter variable
                                 IF counter > 5 THEN
                                      Toggle PORTB reg. bit 0 on/off
                                      Clear counter variable
                                 ENDIF
                                 Recharge Registers TMR0L/TMR0R
                                 Clear TMR0's overflow flag
                              ENDIF
                       ENDDO
                 BEGIN/CONFIGMCU
                     Pre-compilation Directives (config PORTB as digital)
                     Configure options for PIC18F45K22 & PIC18F4520
                     Configure all PORTB as digital output (init all LEDs off)
                 END/CONFIGMCU
                 BEGIN/CONFIGTIMER
                     Config T0CON
                     Charge TMR0L & TMR0H's acumulator initial value
                     Clear overflow's flag
                     Turn TMR0 on
                 END/CONFIGTIMER
              END

       Date:   Nov 2019
*/

/* ---------------------Calculation Memory ------------------------------------
   Formulae: (picGenios and easyPIC v7 boards)
   Machine Cycle = FOSC/4 -> 8MHz/4 -> 2MHz -> 0.5us
   **************************
   Formulae:
   OverflowTime = P_MacCycle * Prescale * (Mode_8_16bits - InitialCounter)

   So, for períod 1 second we have:
   1.000.000us = 0.5us * ? * (65536 - ? ) //solve equation by choosing prescale (128)
   1.000.000us = 0.5us * 128 * (65536 - ? )
   1.000.000us / (0.5us * 128)  = 65356 - X
   15625 = 65536 - X
   X = 65536 - 15625
   X = 49911 (InitialCounter - inside two registers TMR0L e TMR0H)
   Transform the number in HEX: C2 F7
   ****************
   TMR0L = OX F7;
   TMR0H = 0X C7;
   ****************
   Tip: What is the max period for Timer0 (8MHz)?
   OverflowTime = 0.5us * 256 * (65536 - 0)
   OverflowTime =8.388.608us  ~ 8.4 segundos
   *****************
   Good Practices: Before turn on any peripherals, please configure it first;);
   in other words, in configuration mode init TM0 at later time possible;)
 ---------------------------------------------------------------------------*/
#define TRUE 1

void ConfigMCU()
{
 #ifdef P18F45K22
 ANSELD = 0;
 #else
 ADCON1 |= 0X0F;
 #endif

 TRISB = 0;                               // LED as output
 PORTB = 0;                               // LED off
 }

void ConfigTimer()
{
      T0CON = 0B00000110;                 // prescale 1:128, mode 16-bit
      TMR0L = 0XF7;
      TMR0H = 0XC7;                       // Recharge initial counter &
      INTCON.TMR0IF = 0;                  // clean overflow Timer0's flag

      T0CON.TMR0ON = 1;                   // Timer0 on
}


void main() {
unsigned char counter = 0;                // variable used for extend overflow time for TMR0

      ConfigMCU();
      ConfigTimer();

 while (TRUE)
 {
   if(INTCON.TMR0IF == 1)
   {
      counter++;                          // By using counter you can make this
                                          // time as big as you wish:)
      if(counter == 5)
      {
          PORTB.RB0 = ~LATB.RB0;          // toggle LED's logic signal
          counter = 0;
      }

      TMR0L = 0XF7;
      TMR0H = 0XC7;                       // initial recharged default values
      INTCON.TMR0IF = 0;                  // Flag Timer0's overflow signal
   }

 }
 // FOR PIC18F45K22 (easyPIC v7):
 // Now, just as ilustration, go to Project > EditProject e set PLL (4xfreq)(só PIC45K22)
 // The LED will blink at higher frequency. Why?
 // Answer: PLL multiply machine cycle by 4 (the LED blinks at 1s/4 = .25s)
}