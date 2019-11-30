/* Project: Unit 05 - INT
      Code: unit_05_01_blinkInterruption.c

   Objective:   This is Interruption Hello World (blinking LEDs)!
                By enabling interruption, an LED (connected to PORTD.RD0)
                will toggle every 200 ms, while, to comparative purpose,
                by using polling technique, another LED (connected to PORTD.RD1) 
                will toggle every 1s (1000ms/200ms => scaled 5:1).
                See Calculation memory below:)

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
                     Call CONFIGTMR0
                     Call CONFIGGLABALINTERRUPTION
                     Call CONFIGINDIVIDUALVCTTMR0
                 DO FOREVER
                        IF Timer0 overflow THEN
                           Toggle PORTD reg. bit 0 on/off
                           Recharge Registers TMR0L/TMR0R
                           Clear TMR0's overflow flag
                        ENDIF
                 ENDDO
                 BEGIN/CONFIGMCU
                     Pre-compilation Directives (config PORTD as digital)
                     Configure options for PIC18F45K22 & PIC18F4520
                     Configure all PORTD as digital output (init all LEDs off)
                 END/CONFIGMCU
                 BEGIN/CONFIGTMR0
                     Config T0CON
                     Charge TMR0L & TMR0H's acumulator initial value
                     Clear overflow's flag
                     Turn TMR0 on
                 END/CONFIGTMR0
                 BEGIN/CONFIGGLABALINTERRUPTION
                     Config general interruptions High & Low (GIEH & GIEL)
                     Config interruption priority (IPEN)
                 END/CONFIGGLABALINTERRUPTION
                 BEGIN/CONFIGINDIVIDUALVCTTMR0
                     Config IF, IP & IE vectors (Flag, Prior & Enable)
                 END/CONFIGINDIVIDUALVCTTMR0
              END

       Date:   Nov 2019
*/

/* ---------------------Calculation Memory ------------------------------------
   Interrupton: which registers must be set up(Timer0)? T0CON, TMROH & TMR0L
   Hardware: picGenios and easyPIC v7 boards
   Machine Cycle = FOSC/4 -> 8MHz/4 -> 2MHz -> p = 0.5us
   **************************
   Formulae:
   OverflowTime = P_MacCycle * Prescale * (Mode_16bits - InitialCounter)
   200000us     =    0.5us   *    32    *       (65536 - X)
   200000  /  (0.5 * 32) = 65536 - X
   12500                 = 65536 - X
   12500 - 65536         = - X (-1)
   53036                 = X
   X = 53036 (InitialCounter - inside two registers TMR0L e TMR0H)
   Transform the number in HEX: CF 2C
   ****************
   T0CON = 0B00000100 (see datasheet)
   TMR0L = OX CF;
   TMR0H = 0X 2C;
   ****************
   Good Practices: Before turn on any peripherals, please configure it first;);
   in other words, in configuration mode init TM0 as late as possible;)
   -------------------------------------------------------------------------
   Date: nov 2019
   */
#define TRUE 1
                                    // Prototypes:
 void configMCU();                  // Set PORT & TRIS
 void configTMR0();                 // Set timer's mode, ps, etc
 void configGlobalInterruption();   // Set GIEH & GIEL & IPEN
 void configIndividualVctTMR0();    // Set individual int vectors (IF, IP & IE)
                                    // Goto Menu TOOLS > Interrupt Assistance
 void INTERRUPTION_HIGH() iv 0x0008 ics ICS_AUTO
{                                   // 0X008h is high priority
                                    // whereas  0x018h is low
  if(INTCON.TMR0IF == 1)
  {
    PORTD.RD0 = ~LATD.RD0;
                                    // Never ever forget this block!
                                    // or your program loop and is a goner o/
    TMR0H = 0XCF;
    TMR0L = 0X2C;

    INTCON.TMR0IF = 0;              // Clear flag & reset interruption cycle

  }
  
  //  else
        //if(INT2CON) {}            // Here you can rank priorities:)
        
}
  void configMCU()                   // Timer0 Port & Directions
 {
#ifdef P18F45K22
 ANSELD = 0;
#else
 ADCON1 |= 0X0F;                    // Analog pinouts
#endif

  TRISD = 0;
  PORTD = 0;                         // LEDs' control pins
}
void configTMR0()                    // TIMER0 em 200us
{
  T0CON = 0B00000100;               // Timer OFF, Mod 16-bits, Mode Timer, Prescale 1:32
  TMR0H = 0XCF;
  TMR0L = 0X2C;

  INTCON.TMR0IF = 0;                // Clear Flag
  T0CON.TMR0ON = 1;                 // Timer0 on!
}
void configGlobalInterruption()     // Interruptions's master keys
{
  INTCON.GIEH = 1;                  // High priority enabled
  INTCON.GIEL = 1;                  // Low prioritY enabled
  RCON.IPEN =   1;                  // Compatibility family 16F (just one level)
                                    // If = 1 two priorities levels (PIC18F)
                                    // If = 0, GIEL not applicable!
}
void configIndividualVctTMR0()
{
                                    // See datasheet page 133
  INTCON.TMR0IF  = 0;               // Overflow flag; please init zero
  INTCON2.TMR0IP = 1;               // Interruption priority vector: HIGH
  INTCON.TMR0IE  = 1;               // TIMER0's interruption enabled
}
void main() {
  configMCU();                      // configure CHIP
  configTMR0();                     // configure TMR0 master ints keys
  configGlobalInterruption();       // Configure globals ints
  configIndividualVctTMR0();        // configure TMR0 individual int vcts
  
  //while(TRUE);                    // Free Program

  while(TRUE)
     {
        PORTD.RD6 = ~LATD.RD6;
        Delay_ms(1000);             // Killing processor here!
                                    // In 1000ms, 5 interruptions potentially
     }
}