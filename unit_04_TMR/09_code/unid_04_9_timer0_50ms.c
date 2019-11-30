  /*
   * Project name:
       unid_04_09_timer0_50ms (TMR0@.05)
   * Copyright:
       (c) J3, Oct 2019
   * Revision History:
       V 1.0
         Initial compilation
   * Status:
       100% completed
   * Description:
       Blink an LED'S PORTD @ 50ms
   * Test configuration:
       MCU:             P18F4520
       Dev.Board:       microgenios
       Oscillator:      8.000000
       Ext. Modules:    x
       SW:              mikroC PRO for PIC v7.3.0
   * NOTES:
       Use Soundscope from https://www.zeitnitz.eu/scope_en

       Date: 05/11/2019
   */
// Timer 0 Port D byte 0 PRESCALE 128 MODE 16 EDGE edge (high/low or low/high)
 #define TRUE 1

 void ConfigMCU();                     // Prototype
 void ConfigTimer();

 /* ---------------------Calculation Memory ------------------------------------
    Formulae: (picGenios and easyPIC v7 boards)
    Machine Cycle = FOSC/4 -> 8MHz/4 -> 2MHz -> 0.5us
    **************************
    Formulae: @.05s = 50.000us
    OverflowTime = P_MacCycle * Prescale * (Mode_8_16bits - InitialCounter)

    So, for períod 1 second we have:
    50.000us = 0.5us * 256 * (65536 - ? ) //solve equation by choosing prescale (ps128
    50.000us / (0.5us * 256)  = 65536 - X
    390 = 65536 - X
    X = 65536 - 390
    X = 65.146 (InitialCounter - inside two registers TMR0L e TMR0H)
    Transform the number in HEX: FE 7A
    ****************
    TMR0L = OX FE;
    TMR0H = 0X 7A;
    ****************
    Tip: What is the max period for Timer0 (PIC184520 @8MHz)?
    OverflowTime = 0.5us * 256 * (65536 - 0)
    OverflowTime =8.388.608us  ~ 8.4 segundos
    *****************
    Confirmation:
    If 8.4s takes 65536 counts then
    ?s will  yelds 390 counts; that brings 20,?s
    *****************
    Good Practices: Before turn on any peripherals, please configure it first;);
    in other words, in configuration mode init TM0 at later time possible;)
  ---------------------------------------------------------------------------*/
 void ConfigMCU()
 {
  #ifdef P18F45K22
    ANSELD = 0;                        // (PIC18F45K22) R0 is analog
  #else
    ADCON1 = 0X0F;                    // (PIC18F45220) Determine if anal/digital pins
  #endif
    TRISD = 0;                         // LED is attached to PORTD.R0 BYTE
    PORTD = 0;
  }

 void ConfigTimer()
 {
  #ifdef P18F45K22                     // (PIC18F45K22)
   T0CON = 0B10000111;                // Timer0 off, Prescale 1:128 , Mode16-BITS, LOW-HIGH
  #else                               // (PIC18F45220)
   T0CON = 0B10000111;                // Timer0 off, Prescale 1:128 , Mode 16-BITS, LOW-HIGH
  #endif
   TMR0H = 0XFE;                          // Initial values for accumulator registers
   TMR0L = 0X7A;

   INTCON.TMR0IF = 0;                    // Flag cleared
   T0CON.TMR0ON = 1;                    // Timer0 on, everything is configured, rightD
 }

 void main() {
   ConfigMCU();
   ConfigTimer();

  while (TRUE)                         // Do forever
  {
    if(INTCON.TMR0IF == 1)
    {
       PORTD.RD5 = ~LATD.RD5;          // toggle LED

       TMR0H = 0XFE;                  // Recharge default values
       TMR0L = 0X7A;
       INTCON.TMR0IF = 0;                // Clear Timer0's overflow Flag
    }
   }
 }