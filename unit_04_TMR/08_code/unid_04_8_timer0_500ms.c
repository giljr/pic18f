#define TRUE 1

/*
 * Project name: Unit 04 - TMR
                 unit_04_08_timer0_500ms.c [TMR0@.5s]
 * Copyright:
     (c) J3, Oct 2019
 * Revision History:
     Version 1.0 - Oct, 2019
       Initial compilation
 * Status:
     100% complete
 * Description:
     Blink an LED's PORTD @.5s
 * Test configuration:
     MCU:             P18F4520
     Dev.Board:       PicGenios:   PIC18F4520 chip   ( https://loja.microgenios.com.br/produto/kit-picgenios-pic18f4520-com-gravador-usb-microicd-licen-a-compilador-mikroc-pro-for-pic/23507 )
                      EasyPIC™ 7:  PIC18F45K22 chip  ( https://www.microchip.com/Developmenttools/ProductDetails/TMIK013 )
     Oscillator:      8.000000
     Ext. Modules:     PICkit™ 2         ( http://ww1.microchip.com/downloads/en/DeviceDoc/PICkit%202%20v2.61.00%20Setup%20A.zip )
                       mikroProg suite for PIC ( https://www.mikroe.com/blog/mikroprog-suite-for-pic-version-2-3-1-released )
     SW:              mikroC PRO for PIC v7.3.0
 * NOTES:
     Use templates Tools > Options > Auto Complete: configtimer, calmem, ptemplate and, of course 
     data sheets for PIC18F4520 or PIC18F45K22:
     https://ww1.microchip.com/downloads/en/DeviceDoc/39631E.pdf
     http://ww1.microchip.com/downloads/en/DeviceDoc/40001412G.pdf
     
     Use soundscope from Christian Zeitnitz https://www.zeitnitz.eu/scope_en for test the frequency ;)
     
     Date: Oct 2019
 */

// Timer 0 Port D byte 0 PRESCALE 256 MODE md EDGE edge (high/low or low/high)

/* ---------------------Calculation Memory ------------------------------------
   Formulae: (picGenios and easyPIC v7 boards)
   Machine Cycle = FOSC/4 -> 8MHz/4 -> 2MHz -> 0.5us
   **************************
   Formulae:
   OverflowTime = P_MacCycle * Prescale * (Mode_8_16bits - InitialCounter)

   So, for períod 0.5 second we have:
   500.000us = 0.5us * ? * (65536 - ? ) //solve equation by choosing prescale (128)
   500.000us = 0.5us * 256 * (65536 - ? )
   500.000us / (0.5us * 256)  = 65356 - X
   3906 = 65536 - X
   X = 65536 - 3906
   X = 61630 (InitialCounter - inside two registers TMR0L e TMR0H)
   Transform the number in HEX: FE 79
   ****************
   TMR0L = 0X F0;
   TMR0H = 0X BE;
   ****************
   Tip: What is the max period for Timer0 (8MHz)?
   OverflowTime = 0.5us * 256 * (65536 - 0)
   OverflowTime =8.388.608us  ~ 8.4 segundos
   *****************
   Confirmation:
   If 8.4s takes 65536 counts then
   ?s will  yelds 3906 counts; that brings 0,50064697265625s
   *****************
   Good Practices: Before turn on any peripherals, please configure it first;);
   in other words, in configuration mode init TM0 at later time possible;)
 ---------------------------------------------------------------------------*/
 
void ConfigMCU();                     // Prototype
void ConfigTimer0();
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

void ConfigTimer0()
{
 #ifdef P18F45K22                     // (PIC18F45K22)
   T0CON = 0B10000111;                // Timer0 off, Prescale 1:256 , Mode16-BITS, LOW-HIGH
 #else                                // (PIC18F4520)
   T0CON = 0B10000111;                // Timer0 off, Prescale 1:256 , Mode 16-BITS, LOW-HIGH
 #endif
  TMR0H = 0XF0;                       // Initial values for accumulator registers
  TMR0L = 0XBE;

  INTCON.TMR0IF = 0;                  // Flag cleared
  T0CON.TMR0ON = 1;                   // Timer0 on, everything is configured, rightD
}

void main() {
  ConfigMCU();
  ConfigTimer0();

 while (TRUE)                         // Do forever
 {
   if(INTCON.TMR0IF == 1)
   {
      PORTD.RD5 = ~LATD.RD5;          // toggle LED

      TMR0H = 0XF0;                   // Recharge default values
      TMR0L = 0XBE;
      INTCON.TMR0IF = 0;               // Clear Timer0's overflow Flag
   }
  }
}