#define TRUE 1
/*
 * Project name:
     Unidade 04 - TMR0 (TMR0@50ms)
 * Copyright:
     (c) J3, Oct 2019
 * Revision History:
     V1.0
       Initial Compilation
 * Status:
     100% completed :)
 * Description:
     Blink an LED's PORTD @ 50ms usint TMR0
 * Test configuration:
     MCU:             P18F4520
     Dev.Board:       microgenios
     Oscillator:      8.000000
     Ext. Modules:    MicroICD
     SW:              mikroC PRO for PIC v7.3.0
 * NOTES:
     Using Template to accelarate coding:)

     Date: 05/11/2019
 */

// Timer@50ms 0 Port D byte 0 PRESCALE 128 MODE 16 EDGE LOW/HIGH (high/low or low/high)

void ConfigMCU();                     // Prototype
void ConfigTimer();

/* ---------------------Calculation Memory ------------------------------------
   Formulae: (picGenios and easyPIC v7 boards)
   Machine Cycle = FOSC/4 -> 8MHz/4 -> 2MHz -> 0.5us
   **************************
   Formulae: @0.05s = 50.000us
   OverflowTime = P_MacCycle * Prescale * (Mode_8_16bits - InitialCounter)

   So, for períod 1 second we have:
   50.000us = 0.5us * 128 * (65536 - ? ) //solve equation by choosing prescale (128)
   50.000us = 0.5us * 128 * (65536 - ? )
   50.000us / (0.5us * 128)  = 65356 - X
   781 = 65536 - X
   X = 65536 - 781
   X = 64755 (InitialCounter - inside two registers TMR0L e TMR0H)
   Transform the number in HEX: FC F3
   ****************
   TMR0L = OXFC;
   TMR0H = 0XF3;
   ****************
   Tip: What is the max period for Timer0 (PIC184520 @8MHz)?
   OverflowTime = 0.5us * 256 * (65536 - 0)
   OverflowTime =8.388.608us  ~ 8.4 segundos
   *****************
   Confirmation:
   If 8.4s takes 65536 counts then
   ?s will  yelds ? counts; that brings 0,?s
   *****************
   Good Practices: Before turn on any peripherals, please configure it first;);
   in other words, in configuration mode init TM0 at later time possible;)
 ---------------------------------------------------------------------------*/

void ConfigMCU()
{
 #ifdef P18F45K22
   ANSELD = 0;                        // (PIC18F45K22) R0 is analog
 #else
   ADCON1 = 0X0F;                     // (PIC18F45220) Determine if anal/digital pins
 #endif
   TRISD = 0;                         // LED is attached to PORTD.R0 BYTE
   PORTD = 0;
 }

void ConfigTimer()
{
 #ifdef P18F45K22                     // (PIC18F45K22)
   T0CON = 0B00000110;                // Timer0 off, Prescale 1:128 , Mode16-BITS, LOW/HIGH
 #else                                // (PIC18F45220)
   T0CON = 0B00000110;                // Timer0 off, Prescale 1:128 , Mode 16-BITS, LOW/HIGH
 #endif
  TMR0H = 0XFC;                       // Initial values for accumulator registers
  TMR0L = 0XF3;

  INTCON.TMR0IF = 0;                  // Flag cleared
  T0CON.TMR0ON = 1;                   // Timer0 on, everything is configured, rightD
}

void main() {
  ConfigMCU();
  ConfigTimer();

 while (TRUE)                         // Do forever
 {
   if(INTCON.TMR0IF == 1)
   {
      PORTD.RD0 = ~LATD.RD0;          // toggle LED

      TMR0H = 0XFC;                   // Recharge default values
      TMR0L = 0XF3;
      INTCON.TMR0IF = 0;              // Clear Timer0's overflow Flag
   }
  }
}