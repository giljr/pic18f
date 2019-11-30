/* Project: Unit 05 - INT
      Code: unit_05_06_IOC.c

   Objective:   This is the Hello World for IOC - Interrupt-on-Change:D
                When user presses PORTD.RB4 the LED's at PORTD.RB0 will change for
                both rising and falling edge(press, hold and release to see effect)
                PORTD.RB1 is blinking by the polling tecnique.
                Try to desable the IOC patch -> everything will stop working:/
                PORTB Interrupt-on-Change:
                An input change on PORTB<7:4> sets flag bit, RBIF
                (INTCON<0>). The interrupt can be enabled/disabled
                by setting/clearing enable bit, RBIE (INTCON<3>).
                Interrupt priority for PORTB interrupt-on-change is
                determined by the value contained in the interrupt
                priority bit, RBIP (INTCON2<0>).
                Note: to start it up, press PORTB.RB0, BUGGED PERIPHERAL:|
                Look for pins: KBI<0-3> Interrupt-on-change pin (PIC18F4520)
                              IOC1<0:3> Interrupt-on-change pin (PIC18F45K22)

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
                     Call CONFIGGLABALINTERRUPTION
                     Call CONFIGINDIVIDUALVCTIOC
                 DO FOREVER(ISR)
                        IF Timer0 overflow THEN
                           Toggle PORTD reg. bit 0 on/off
                           Unpatch it! (BUG)
                           Clear TMR0's overflow flag
                        ENDIF
                 ENDDO(ISR)
                 BEGIN/CONFIGMCU
                     Pre-compilation Directives (config PORTD as digital)
                     Configure options for PIC18F45K22 & PIC18F4520
                     Configure all PORTD as digital output (init all LEDs off)
                     Configure RB0/INT0 pin as input (simulate input signal)
                 END/CONFIGMCU
                 BEGIN/CONFIGGLABALINTERRUPTION
                     Config general interruptions High & Low (GIEH & GIEL)
                     Config interruption priority (IPEN)
                 END/CONFIGGLABALINTERRUPTION
                 BEGIN/CONFIGINDIVIDUALVCTIOC
                     Config IF, IP* & IE vectors (Flag, Prior & Enable)
                     Config INTCON2.INTEDG0 = 1(Peculiar to this peripheral only)
                 END/CONFIGINDIVIDUALVCTIOC
              END

       Date:   Nov 2019
*/
#define TRUE 1
volatile char temp;                    // Declaring volatile to avoid otimizer's elimination
                                       // Prototypes
 void configMCU();                     // Config PORTS & TRIS
 void configGlobalInterruption();      // Config GIEH, GIEL & IPEN
 void configIndividualVctIOC();       // Individual peripheral configs (INT0)

 void INTERRUPCAO_HIGH() iv 0x0008 ics ICS_AUTO {
  if(INTCON.INT0IF == 1)
   {
       if(INTCON.RBIF == 1)
     {
       PORTD.RD6 ^= 1;                 // Toggle LED on PORTD's 1º bit
                                       // IOC patch: Technique Used to Fix the RB Circuit Design Problem
                                       // It is recommended to read Ref 1 ° first, then Ref 2 °.
          temp = PORTB;                // Reads PORTB value to redeem PORTB real state value
          PORTB = temp;                // Write the value again to load it into the LATB as it is by the value
                                       // guaranteed by LAT which is internally made XOR operation by MCU.
                                       // (so it's called: state change interrupt)
                                       // References to study the problem with using RB interrupt:
                                       // Ref 1°: http://www.xargs.com/pic/portb-change-bug.html
                                       // Ref 2°: http://www.mikroe.com/forum/viewtopic.php?t=23556
          INTCON.RBIF = 0;             // Flag's cleared
     }
   }
}

void ConfigMCU()
{
#ifdef P18F45K22
 ANSELB = 0;                           // IOC's on Port B, so it must be digital
 ANSELD = 0;                           // WPUR (Weak Pull-ups Resistors) set up:
 INTCON2.RBPU = 0;                     // Remember, RBPU is negated, zero turn it on!
                                       // Turn on pull-ups resistor to PORTB;
                                       // For PIC18F45K22 RBPU is like general key;
                                       // For PIC18F45K22 WPUB is responsable for control
                                       // each pin individual resistors;
 WPUB.WPUB0 = 1 ;                      // Turn on pull-ups at RB0's pin.
#else
 ADCON1 |= 0X0F;                       // 0B11110000 config PORTB<7:4> as input
 INTCON2.RBPU = 0;
#endif

 TRISD = 0;
 PORTD = 0;

 TRISB.RB0 = 1;                        // RB0/INT0 pin as input

}

void configGlobalInterruption()
{                                      // General global interruptions set up
  INTCON.GIEH = 1;
  INTCON.GIEL = 1;
  RCON.IPEN = 1;
}

void configIndividualVctIOC()
{                                      // Individual peripheral configs (IOC is know as RB)
#ifdef P18F45K22
  IOCB.IOCB4 = 1;                      // Individual selection IOC only for PIC18F45k22
                                       // Select: RB<4:7>
#endif
  INTCON.RBIF = 0;                     // Overflow's Flag; this sets on/off interruptions;
  INTCON2.RBIP = 1;                    // High-priority interrupt source;
  INTCON.RBIE = 1;                     // IF, IP & IF is enough:)
}

void main() {
  configMCU();
  configGlobalInterruption();
  configIndividualVctIOC();

 //while(1);                           // I stopped processing!
 while(TRUE)
 {                                     // Togle RD1 using pulling :/
   Delay_ms(300);
   PORTD.RD5 ^= 1;
  }
}