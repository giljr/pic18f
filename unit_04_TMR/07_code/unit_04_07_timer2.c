/* Project: Unit 04 - TMR
      Code: unit_04_07_timer2.c  [TMR@.32s]

   Objective:   In this project we will program TIMER2;
                Each TMR2's pulse  will toggle LED at PORTD.RD0.
                Two buttons are used to STOP / GO the Timer2
                See Math Formula Memory presented below:)

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
                              IF RB0 is pressed  THEN  turn TMR2 on  ENDIF
                              IF RB1 is pressed  THEN  turn TMR2 off ENDIF
                              IF Timer2 overflow THEN
                                 Toggle PORTD reg. bit 0 on/off
                                 (TMR2 is auto-reset by hardware)
                                 Clear TMR2's flag
                              ENDIF
                       ENDDO
                 BEGIN/CONFIGMCU
                     Pre-compilation Directives
                     Configure options for PIC18F45K22 & PIC18F4520
                     Configure all PORTD as digital output (init all LEDs off)
                     Configure all PORTB as digital input (KEY)
                 END/CONFIGMCU
                 BEGIN/CONFIGTIMER
                     Config T2CON as Timer for PIC18F45K22 & PIC18F4520
                     Charge PR2 acumulator initial value
                     Clear overflow's flag
                     Turn TMR2 on
                 END/CONFIGTIMER
              END

/********************** Math formula for Timer2 Setup ************************
  MaxTime = P_MachineCycle * Prescale * Postscale * (PR2 + 1)
  MaxTime = 0.5us * 16 * 16 * (255 + 1)
  MaxTime: 32.768us or roughly ~33ms
 *****************************************************************************
  Good Practices: Before turn on any peripherals, please configure it first;)
  In other words, in configuration mode init TM2 at later time possible;)
 ---------------------------------------------------------------------------
    Date:   Nov 2019
*/
#define TRUE 1
void configMCU()
{
 #ifdef P18F45K22
   ANSELD = 0;                        // (PIC18F45K22) PORTD is analog (LED)
   ANSELB = 0;                        //               PORTB is analog (KEY)
 #else
   ADCON1 |= 0X0F;                    // (PIC18F45220) Determine if anal/digital
 #endif
  TRISB.RB0 = 1;                      // Key RB0 as input
  TRISB.RB1 = 1;                      // Key RB1 as input
  TRISD = 0;                          // LED  as output
  PORTD = 0;                          // All LEDs are off
}
void configTimer()
{
 #ifdef P18F45K22                     // (PIC18F45K22)
   T2CON = 0B01111000;                // Define TIMER2 OFF, prescaler 1:16, postscale 1:16
 #else                                // (PIC18F45220)
   T2CON = 0B01111011;                // Define TIMER2 OFF, prescaler 1:16, postscale 1:16
 #endif
   PR2 =  255;                        // Count for 32ms
   PIR1.TMR2IF = 0;                   // Clear TIMER2's flag
   T2CON.TMR2ON = 1;                  // Timer2 on, everything is configure, right:D
}

void main(){                          // Main routine
 
 configMCU();
 ConfigTimer();
 
 while (TRUE){

    if (PORTB.RB0 == 0) {             // If RB0's key pressed...
         T2CON.TMR2ON = 1;            // Timer2 on
       }

    if (PORTB.RB1 == 0){              // If R10's key pressed...
         T2CON.TMR2ON = 0;            // Timer2 off
       }

    if (PIR1.TMR2IF == 1) {           // If TMR2 overflow...
         PORTD.RD4 = ~LATD.RD4;       // toggle LED
         PIR1.TMR2IF = 0;             // Clear TMR2's overflow flag
        }
   }
}