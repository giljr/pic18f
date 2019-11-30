/* Project: Unit 04 - TMR
      Code: unit_04_06_timer1asCounterLCD.c  [CNT@65536PULSES]

   Objective:   In this project we will program TIMER1
                AS COUNTER and present results on LCD.
                Here you will learn about UNION \o/
                (see please preview example using LED)

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
                  Declare prototype functions
                  Declare LCD module connections
                  Declare union structure
                  Declare variable LCD auxiliary
                  Call CONFIGMCU
                  Call CONFIGTIMER
                  Initializa LCD
                  Clear LCD's screen
                  Set LCD's Cursor off
                  Present heading 'Value' at the LCD's first line
                       DO FOREVER
                              Populate union structure (2 bytes)
                              Present integer to LCD
                              Wait .02s
                              IF Timer1 overflow THEN
                                 Recharge Registers TMR1L/TMR1R
                                 Clear TMR1's overflow flag (PIR1.TMR1IF)
                              ENDIF
                       ENDDO
                 BEGIN/CONFIGMCU
                     Pre-compilation Directives
                     Configure options for PIC18F45K22 & PIC18F4520
                     Configure all PORTB as digital output (LCD)
                     Configure all PORTC as digital input (TKCI pin)
                 END/CONFIGMCU
                 BEGIN/CONFIGTIMER
                     Pre-compilation Directives
                     Config T1CON as Counter for PIC18F45K22 & PIC18F4520
                     Charge (TMR1L & TMR1H) acumulator initial value
                     Clear overflow's flag
                     Turn TMR1 on
                 END/CONFIGTIMER
              END

  ***************************************************************************
   Good Practices: Before turn on any peripherals, please configure it first;);
   in other words, in configuration mode init TM1 at later time possible;)
 ---------------------------------------------------------------------------

   Date:   Nov 2019
*/
void ConfigMCU();                     // Prototype declaration
void ConfigTimer();

#define TRUE 1                              // Timer 1 Port D byte 0 PRESCALE 1 MODE 16 EDGE low/high
                                      // Timer 1 as counter - Please, stimulate external pulse pin:
                                      // 15°- RC0 -> T13CKI (PIC18F4520) T1CKI(PIC18F45K22)
                                      // PIC18F45K22  - easyPIC v7 Board
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

union TwoBytes {                      // Declaring a data structure:
   unsigned char BYTE[2];             // BYTE1 | BYTE2
   unsigned int INTEGER;              // I N T E G E R
} TWO;

unsigned char txt[10];                // Variable to converte n° to text

void ConfigMCU()
{
 #ifdef P18F45K22
   ANSELC = 0;                        // (PIC18F45K22) PORTC is analog
   ANSELB = 0;                        //               PORTB is analog
 #else
   ADCON1 |= 0X0F;                    // (PIC18F45220) Determine if anal/digital pins
 #endif
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
  TMR1H = 0;                          // Initial values for accumulator registers
  TMR1L = 0;                          // One more pulse, Timer1 overflow!

  PIR1.TMR1IF = 0;                    // Flag clearhigh/low
  T1CON.TMR1ON = 1;                   // Timer1 on, everything is configure, right:D
}

void main() {
  ConfigMCU();
  ConfigTimer();
  
  Lcd_Init();                         // Initialize LCD

  Lcd_Cmd(_LCD_CLEAR);                // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);           // Cursor off

  Lcd_Out(1,1,"Value:");              // Write text in first row

 while (TRUE)                         // Do forever
 {
    TWO.BYTE[1] = TMR1H;              // Please, in this order!
    TWO.BYTE[0] = TMR1L;              // Read PIC18(L)F2X/4XK22 datasheet @ 12.7 Timer1/3/5 Gate
                                      // PIC18F2420/2520/4420/4520 datasheet @ 12.2 Timer1 16-Bit Read/Write Mode
    WordToStr(TWO.INTEGER, txt);      // Convert number to txt[10]
    LCD_Out(1, 7, txt);               // Show at LCD's first line
    Delay_ms(20);
    
    if(PIR1.TMR1IF == 1)              // Timer1 will overflow at 65536 pulses:/
    {
         TMR1H = 0;                   // Recharge default values
         TMR1L = 0;
         PIR1.TMR1IF = 0;             // Clear Timer1's overflow Flag
    }

  }
}