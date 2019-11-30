/* Project: Unit 04 - TMR
      Code: unit_04_05_timer1asCounter.c  [CNT@1PULSE]

   Objective:   In this project we will program TIMER1 AS COUNTER.
                Each pulse on PORTC.RC0 will toggle LED at PORTD.RD0:)
                See Calculation Memory presented below:)

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
                                 Toggle PORTD reg. bit 0 on/off
                                 Recharge Registers TMR1L/TMR1R
                                 Clear TMR1's overflow flag (PIR1.TMR1IF)
                              ENDIF
                       ENDDO
                 BEGIN/CONFIGMCU
                     Pre-compilation Directives
                     Configure options for PIC18F45K22 & PIC18F4520
                     Configure all PORTD as digital output (init all LEDs off)
                     Configure all PORTC as digital input (TKCI pin)
                 END/CONFIGMCU
                 BEGIN/CONFIGTIMER
                     Config T1CON as Counter for PIC18F45K22 & PIC18F4520
                     Charge TMR1L & TMR1H's acumulator initial value
                     Clear overflow's flag
                     Turn TMR1 on
                 END/CONFIGTIMER
              END

  ***************************************************************************
/* ---------------------Calculation Memory ------------------------------------
   For picGenios and easyPIC v7 boards:)
   So, let's count just 1 pulse, right? Acumulator register must be:
   X = 65536 - 1
   X = 65535 (InitialCounter - inside two registers TMR0L e TMR0H)
   Transform the number in HEX: FF FF
   ****************
   TMR0L = OX FF;
   TMR0H = 0X FF;
   ****************
   Good Practices: Before turn on any peripherals, please configure it first;);
   in other words, in configuration mode init TM0 at later time possible;)
 ---------------------------------------------------------------------------

   Date:   Nov 2019
*/
#define TRUE 1                              // Timer 1 Port D byte 0 PRESCALE 1 MODE 16 EDGE low/high
                                      // Timer 1 as counter - Please, stimulate external pulse pin:
                                      // 15°- RC0 -> T13CKI (PIC18F4520) T1CKI(PIC18F45K22)
void ConfigMCU();                     // Prototype
void ConfigTimer();

void ConfigMCU()
{
 #ifdef P18F45K22
   ANSELD = 0;                        // (PIC18F45K22) PORTD is analog
   ANSELC = 0;                        // (PIC18F45K22) PORTC is analog
 #else
   ADCON1 |= 0X0F;                    // (PIC18F45220) Determine if anal/digital pins
 #endif
   TRISD = 0;                         // LED is attached to PORTD.R0
   PORTD = 0;
   TRISC.RC0 = 1;                     // Simulate pulses PORTC.RC0 (T13CKI pin)
   PORTC.RC0 = 1;
 }

void ConfigTimer()
{
 #ifdef P18F45K22                     // (PIC18F45K22)
   T1CON = 0B10000010;                // Timer1 off, Prescale 1:1 , Mode16-BITS, edge low/high
 #else                                // (PIC18F45220)
   T1CON = 0B10000010;                // Timer1 off, Prescale 1:1 , Mode 16-BITS, edge low/high
 #endif
  TMR1H = 0XFF;                       // Initial values for accumulator registers
  TMR1L = 0XFF;                       // One more pulse, Timer1 overflow!

  PIR1.TMR1IF = 0;                    // Flag clearhigh/low
  T1CON.TMR1ON = 1;                   // Timer1 on, everything is configurhigh/low, rightD
}

void main() {
  ConfigMCU();
  ConfigTimer();

 while (TRUE)                         // Do forever
 {
   if(PIR1.TMR1IF == 1)
   {
      PORTD.RD0 = ~LATD.RD0;          // toggle LED high/low

      TMR1H = 0XFF;                   // Recharge default values
      TMR1L = 0XFF;
      PIR1.TMR1IF = 0;                // Clear Timer1's overflow Flag
   }
  }
}