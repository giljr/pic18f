/* Project: Unit 04 - TMR
      Code: unit_04_03_countTillTen.c  [CNT@10pulses]

   Objective:   In this project we will program TIMER0 AS COUNTER 
                to count until 10 PULSES and present result on LED.
                There is no Calculation Memory because we are in asynch count mode:(
                To simulate, enter 10 pulses on pin RA4 (PIC18F4520's sixth pin).

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
                              IF Timer0 overflow THEN
                                 Autoincrement counter variable
                                 IF counter > 5 THEN
                                      Toggle PORTD reg. bit 0 on/off
                                      Clear counter variable
                                 ENDIF
                                 Recharge Registers TMR0L/TMR0R
                                 Clear TMR0's overflow flag
                              ENDIF
                       ENDDO
                 BEGIN/CONFIGMCU
                     Pre-compilation Directives (config PORTB and PORTD as digital)
                     Configure options for PIC18F45K22 & PIC18F4520
                     Configure all PORTD as digital output (init all LEDs off)
                 END/CONFIGMCU
                 BEGIN/CONFIGTIMER
                     Config T0CON
                     Charge TMR0L & TMR0H's acumulator initial value
                     Clear overflow's flag
                     Turn TMR0 on
                 END/CONFIGTIMER
              END
              
  ********************************************************
  X = 65536 - 10 = 65526 (Put HEX (FFF6) at TMR0L e TMR0H)
  ********************************************************
  ****************
  TMR0L = OXF6;
  TMR0H = 0XFF;
  ****************
   **************************************************************************
   Good Practices: Before turn on any peripherals, please configure it first;);
   in other words, in configuration mode init TM0 at later time possible;)

  Date:   Oct 2019
*/
#define TRUE 1

void ConfigMCU()
{
 #ifdef P18F45K22
 ANSELD = 0;
 ANSELA = 0;                        // RA is analog

 #else
 ADCON1 |= 0X0F;                    // Determine if anal/digital pins
 #endif
                                    // Find datasheet for TOCKI pin (RA4)
                                    // External clock attached on RA4 (4520)
   TRISA.RA4 = 1;                   // Input pin for simulate external pulses
                                    // T0CKI - Timer0 external clock input.
   PORTA.RA4 = 1;                   // Opcional
                                    // LED PORTD.RD0 
   TRISD = 0;
   PORTD = 0;
 }

void ConfigTimer()
{
  T0CON = 0B00111000;               // mode counter, mode16-bits, timer off, edge high-low
  TMR0H = 0XFF;                     // valor de carga inicial
  TMR0L = 0XF6;

  INTCON.TMR0IF = 0;                // Flag de sinalização de estouro do Timer0
  T0CON.TMR0ON = 1;                 // liga o Timer0 depois de configurarmos tudo.
}


void main() {
  ConfigMCU();
  ConfigTimer();

 while (TRUE)
 {
   if(INTCON.TMR0IF == 1)
   {
      PORTD.RD0 = ~LATD.RD0;        // toggle LED
                                    // Recharge default values
      TMR0H = 0XFF;
      TMR0L = 0XF6;
      INTCON.TMR0IF = 0;            // Timer0's overflow Flag
   }
  }
}