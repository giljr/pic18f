/* Project: Unit 06 - CCP
      Code: unit_06_03_captureWidth.c

   Objective:   This capture will calculate pulse width (t1-----w-----t2)
                Do input a signal on RC2 pin to see its rating in microseconds.

    LIB Note:   Enable THIS LIBRARIES FOR mikroC PRO for PIC:
                > LDC
                > CONVERSIONS

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
                     Set LCD module connections
                     Call CONFIGMCU
                     Call CONFIGGLABALINTERRUPTION
                     Call CONFIGINDIVIDUALVCTINT0
                 DO FOREVER(ISR)
                        IF Timer0 overflow THEN
                           Toggle PORTD reg. bit 0 on/off
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
                 BEGIN/CONFIGINDIVIDUALVCTINT0
                     Config IF, IP* & IE vectors (Flag, Prior & Enable)
                     Config INTCON2.INTEDG0 = 1(Peculiar to this peripheral only)
                 END/CONFIGINDIVIDUALVCTINT0
              END
   *****************************************************************************
   Calculation Memory   TIMER 1: Timer Calculation
   Fosc = 8MHz, P_ciclo_maq = 0.5us
   Prescale 1:2, so 0.5ux * 2 = 1us (the number are in microsecond already!)
   *****************************************************************************
       Date:   Nov 2019
*/
                                      // PIC18F45K22  - easyPIC v7 Board
#define TRUE 1
#define T1 0
#define T2 1                          // PERIOD = T2 - T1
                                      // LCD module connections
/*sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;*/
                                      // End LCD module connections

                                      // picMicrogenios board
sbit LCD_RS at LATE2_bit;
sbit LCD_EN at LATE1_bit;
sbit LCD_D4 at LATD4_bit;
sbit LCD_D5 at LATD5_bit;
sbit LCD_D6 at LATD6_bit;
sbit LCD_D7 at LATD7_bit;

sbit LCD_RS_Direction at TRISE2_bit;
sbit LCD_EN_Direction at TRISE1_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;
                                       // End LCD module connections
                                       // Prototypes
 void configMCU();                     // Config PORTS & TRIS
 void configGlobalInterruption();      // Config GIEH, GIEL & IPEN
 void configIndividualVctINT0();       // Individual peripheral configs (INT0)

 volatile union TwoBytes{              // BYTE1 | BYTE2
 unsigned char BYTE[2];                // I N T E G E R
 unsigned int INTEGER;                 // ONE BYTE1 + ONE BYTE2 = ONE INTEGER ;b
} ONE;

volatile unsigned int t2;              // State machine variables
volatile unsigned int t1;
volatile unsigned char _state = T1;



 void INTERRUPTION_HIGH() iv 0x0008 ics ICS_AUTO {
   if(PIR1.CCP1IF == 1)
    {
        if(_state == T1)
        {
                                       // capture read variables
                                       // p = t2 -t1
          ONE.BYTE[0] = CCPR1L;        // using union struct
          ONE.BYTE[1]= CCPR1H;         // easy, right?
          t1 = ONE.INTEGER;            // t1: first sampling
          CCP1CON = 0;                 // Microchip's Recomendation: reset before CCP module's manipulation
                                       // Avoiding false interruptions
          CCP1CON = 0B00000100;        // Falling edge capture
          _state = T2;                 // jump to the next state T2
         }
         else if(_state == T2)
         {

          ONE.BYTE[0] = CCPR1L;
          ONE.BYTE[1]= CCPR1H;
          t2 = ONE.INTEGER;            // T2: second sampling
          CCP1CON = 0;                 // Microchip's Recomendation: reset before CCP module's manipulation
                                       // Avoiding false interruptions
          CCP1CON = 0B00000101;        // Rising edge capture
          _state = T1;                 // jump to the previews state T1
          PIE1.CCP1IE = 0;             // To write to LCD, turn interruption off!
         }

     PIR1.CCP1IF = 0;                  // Flag is cleared
    }
}

void ConfigMCU()
{
#ifdef P18F45K22
 ANSELB = 0;                           // LCD are on PORTB
 ANSELC = 0;                           // Input RC2 pin
#else
 ADCON1 |= 0X0F;
#endif
 TRISB =0;
 TRISC.RC2 = 1;
 PORTC.RC2 = 1;
}

void configGlobalInterruption()        // General glebal interruptions set up
{
  INTCON.GIEH = 1;                     // Enable Interruptions High Priority
  INTCON.GIEL = 1;                     // Enable Interruptions Low Priority
  RCON.IPEN = 1;                       // Enable Priority
}

void configIndividualVctCAPT()         // Capture peripheral setup
{                                      // ccp for capture
  CCP1CON = 0;                         // Reset the module: Microchip recommends:)
                                       // STANDARD CCPx CONTROL REGISTER
  CCP1CON = 0B00000111;                // Capture 16 th mode: every rising edge
                                       // Fire Protection Enginner = FPE :/
  PIR1.CCP1IF = 0;                     // F for Flag's clear
  IPR1.CCP1IP = 1;                     // P for Priority
  PIE1.CCP1IE = 1;                     // E CCP enable
                                       // Directions' pin
  TRISC.RC2 = 1;                       // CCP as input

                                       // TMR1 configuration inside Capture mode
  T1CON = 0B11010000;                  //16-bit mode, TMR1 osc, PS 1:2, clock source Fosc/4, stop TMR1
  TMR1H = 0;
  TMR1L = 0;
  T1CON.TMR1ON = 1;                    // TMR1 on!

}

void main() {
  unsigned int p = 0;                  // p = t2 - t1 (period time)
  unsigned char txt[10];               // Vector to transform number to txt for LCD screen

  configMcu();                         // call all subroutine above
  configGlobalInterruption();
  configIndividualVctCAPT();

  Lcd_Init();                          // Init LCD, 4-bit Mode
  Lcd_Cmd(_LCD_CLEAR);                 // Screen clear
  Lcd_Cmd(_LCD_CURSOR_OFF);            // Cursor off
  Lcd_Out(1, 1, "Period: ");           // Line x Colunm
                                       // Enable interruptions
 while (TRUE)
  {
      if(PIE1.CCP1IE == 0)             // Turn off interruptions to write to LCD (ISR force stop)
       {
          p = t2 - t1;                 // p: period; t2: second time sampling; t1: first time sampling
          WordToStr (p, txt);
          Lcd_Out (1,10, txt);

          Delay_ms(20);
          PIE1.CCP1IE = 1;             // Again, turn interruption on! (see ISR)
       }
  }
}