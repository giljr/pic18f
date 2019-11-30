/* Project: Unit 04 - TMR
      Code: unit_04_04_timer1.c  [TMR@MAX]

   Objective:   In this project we will program TIMER1 AS TIMER
                to count its maximum scale and present results on the LED.
                See Calculation Memory are presented below:)

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
                  Call CONFIGMCU
                  Call CONFIGTIMER
                       DO FOREVER
                              IF Timer1 overflow THEN
                                 Toggle PORTB reg. bit 0 on/off
                                 Recharge Registers TMR1L/TMR1R
                                 Clear TMR1's overflow flag (PIR1.TMR1IF)
                              ENDIF
                       ENDDO
                 BEGIN/CONFIGMCU
                     Pre-compilation Directives
                     Configure options for PIC18F45K22 & PIC18F4520
                     Configure all PORTB as digital output (init all LEDs off)
                 END/CONFIGMCU
                 BEGIN/CONFIGTIMER
                     Config T1CON for PIC18F45K22 & PIC18F4520
                     Charge TMR1L & TMR1H's acumulator initial value
                     Clear overflow's flag
                     Turn TMR1 on
                 END/CONFIGTIMER
              END

  ***************************************************************************
 /* ---------------------Calculation Memory ------------------------------------
   For picGenios and easyPIC v7 boards;)
   Machine Cycle = FOSC/4 -> 8MHz/4 -> 2MHz -> 0.5us
   **************************
   Formulae:
   OverflowTime = P_MacCycle * Prescale * (Mode_8_16bits - InitialCounter)

   So, what is the max period for Timer1 (@8MHz)?
   OverflowTime = 0.5us * 8 * (65536 - 0)
   OverflowTime = 262.144us  ~ 262 ms

   *****************
   Good Practices: Before turn on any peripherals, please configure it first;);
   in other words, in configuration mode init TM0 at later time possible;)
   **************************************************************************

   Date:   Nov 2019
*/
#define TRUE 1

void ConfigMCU();                     // Prototype
void ConfigTimer();

void ConfigMCU()
{
 #ifdef P18F45K22
   ANSELD = 0;                        // (PIC18F45K22) RA is analog
 #else
   ADCON1 |= 0X0F;                    // (PIC18F45220) Determine if anal/digital pins
 #endif
   TRISB = 0;                         // LED is attached to PORTD.RD0
   PORTB = 0;
 }

void ConfigTimer()
{
 #ifdef P18F45K22                     // (PIC18F45K22)
   T1CON = 0B00110010;                // Timer1 off, Prescale 1:8, Mode 16-BITS
 #else                                // (PIC18F45220)
   T1CON = 0B10110000;                // Timer1 off, Prescale 1:8, Mode 16-BITS
 #endif                               // mode counter, mode16-bits, timer off, edge high-low
  TMR1H = 0;                          // Initial values for accumulator registers
  TMR1L = 0;

  PIR1.TMR1IF = 0;                    // Flag cleared
  T1CON.TMR1ON = 1;                   // Timer1 on, everything is configured, right?
}

void main() {
  ConfigMCU();
  ConfigTimer();

 while (TRUE)                         // Do forever
 {
   if(PIR1.TMR1IF == 1)
   {
      PORTB.RB0 = ~LATB.RB0;          // toggle LED

      TMR1H = 0;                      // Recharge default values
      TMR1L = 0;
      PIR1.TMR1IF = 0;                // Clear Timer1's overflow Flag
   }
  }
}