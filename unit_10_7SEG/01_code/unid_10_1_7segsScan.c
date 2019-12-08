/*   Project: Unit 10 - 7SEGS
        Code: unit_10_1_7segsScan.c

   Objective:   This program use interruptions and writes the value 1234 on the 7-segment displayCrystal = 8MHz:)
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
   ---------------------Calculation Memory ------------------------------------
   Hardware: PicGenios or easyPIC v7 boards
   Machine Cycle = FOSC/4 -> 8MHz/4 -> 2MHz -> 0.5us
   Formulae:
   OverflowTime = P_MacCycle * Prescale * (Mode_8_16bits - InitialCounter)
   So, for períod 1 second we have:
   2.000us = 0.5us * ? * (65536 - ? ) solve equation by choosing prescale (128)
   //2.000us = 0.5us * 8 * (65536 - ? )
   2.000us / (0.5us * 8)  = 65356 - X
   500 = 65536 - X
   X = 65536 - 500
   X = 65036 (InitialCounter - inside two registers TMR0L e TMR0H)
   Transform the number in HEX: FE 0C
   ****************
   TMR0L = OX FE;
   TMR0H = 0X 0C;
   ****************
      Date:     Dez 2019
*/
#define TRUE 1
                                // Prototype
void configMCU();
void configTimer0();
void configGlobalInterruption();
void configGlobalInterruption();





                                  // unsigned char dVector[] = {63,6,91,79,102,109, 125, 7, 2127, 111};

void INTERRUPTION_HIGH() iv 0x0008 ics ICS_AUTO {
         
static enum {
  d1 = 1,
  d2,
  d3,
  d4
  } state_machine = d1;


/* // Not scanning results in fashion light
                  PORTD = 6;
                  PORTA.RA5 = 1;
                  Delay_ms(20);
                  PORTA.RA5 = 0;
                  Delay_ms(20);
                  */
                  
// 7seg scanning  (Turn on, Wait, Turn off, Turn on, Wait, Turn off...)

if(INTCON.TMR0IF == 1)
     {
            PORTA &= 0B11000011;  //picGenios: Apaga RA2/RA3/RA4/RA5 display pins
            switch(state_machine)
          {
            case d1: {
                         PORTD = 102;
                         PORTA.RA5 = 1;
                         state_machine = d2;
                         break;
                       }
            case d2: {
                         PORTD = 79;
                         PORTA.RA4 = 1;
                         state_machine = d3;
                         break;
                       }
            case d3: {
                         PORTD = 91;
                         PORTA.RA3 = 1;
                         state_machine = d4;
                         break;
                       }
            case d4: {
                         PORTD = 6;
                         PORTA.RA2 = 1;
                         state_machine = d1;
                         break;
                     }
          }
     }

                                  // Interruption Timer0
    TMR0H = 0XFE;
    TMR0L = 0X06;
    INTCON.TMR0IF = 0;            // Clear flag & reset interruption cycle

}

 void configMCU()                 // Timer0 Port & Directions
 {
#ifdef P18F45K22
 ANSELD = 0;
 ANSELA = 0;
#else
 ADCON1 |= 0X0F;                  // Analog pinouts
#endif

  TRISA = 0;
  PORTA = 0;                      // LEDs' control pins
  TRISD = 0;
  PORTD = 0;                      // LEDs' control pins
}

void configTimer0()
{

#ifdef P18F45K22                  // (PIC18F45K22)
   T0CON = 0B00000010;            // Timer1 off, Prescale 1:8, Mode 16-BITS
#else
      T0CON = 0B00000010;  
#endif                            // prescale 1:8, mode 16-bit, TIMER OFF
      TMR0L = 0XFE;
      TMR0H = 0X0C;               // Recharge initial counter &
      INTCON.TMR0IF = 0;          // clean overflow Timer0's flag

      T0CON.TMR0ON = 1;           // Timer0 on
}

void configGlobalInterruption()   // Interruptions's master keys
{
  INTCON.GIEH = 1;                // High priority enabled
  INTCON.GIEL = 1;                // Low prioritY enabled
  RCON.IPEN =   1;                // Compatibility family 16F (just one level)
                                  // If = 1 two priorities levels (PIC18F)
                                  // If = 0, GIEL not applicable!
}
void configIndividualVctTMR0()
{
                                  // See datasheet page 133
  INTCON.TMR0IF  = 0;             // Overflow flag; please init zero
  INTCON2.TMR0IP = 1;             // Interruption priority vector: HIGH
  INTCON.TMR0IE  = 1;             // TIMER0's interruption enabled
}

void main()
{
    configMCU();
    configTimer0();
    configGlobalInterruption();
    configIndividualVctTMR0();
   
                                  // Config Timer0's overflow time for 2ms
                                  // Calculation Memory - TMR0 @ 2ms

                                  // Enable general interruptions vectors
                                  // Enable individual vectors to Timer0
                                  // Turn on Timer0

  while(TRUE)
  {     
        // readSEnsor();
        // keypad();
        //...do others tasks
   }



}