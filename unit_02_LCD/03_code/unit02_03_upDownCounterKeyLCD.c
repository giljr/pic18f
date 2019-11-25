/* Project: Unit 02 - LCD
      Code: unit_02_03_upDownCounterKeyLCD.c

   Objective:   In this project we will press an up key (RBO) to make
                a counter increment and a down key (RB1) to decrement it:)

    LIB Note:   Select on Library Manager the for mikroC PRO for PIC:)
                > LCD library
                > Conversions

      
      Author:   microgenios, edited by J3

   PIC Lessons: How to Start to Program PIC 18 - Step-by-step for Beginners!

   Hardware:    Development Boards (OPTIONS):
                   PicGenios:   PIC18F4520 chip   ( https://loja.microgenios.com.br/produto/kit-picgenios-pic18f4520-com-gravador-usb-microicd-licen-a-compilador-mikroc-pro-for-pic/23507 )
                   EasyPIC™ 7:  PIC18F45K22 chip  ( https://www.microchip.com/Developmenttools/ProductDetails/TMIK013 )
   Software:    Development Programmer/Debugger:
                                PICkit™ 2         ( http://ww1.microchip.com/downloads/en/DeviceDoc/PICkit%202%20v2.61.00%20Setup%20A.zip )
                          mikroProg suite for PIC ( https://www.mikroe.com/blog/mikroprog-suite-for-pic-version-2-3-1-released )
   The LCD is connected to the microcontroller as follows:
                        easyPIC v7 board:                     microgenios board:
                    Microcontroller      LCD               Microcontroller      LCD
                    ===============      ===               ===============      ===
                        RB0              D4                    RB4              D4
                        RB1              D5                    RB5              D5
                        RB2              D6                    RB6              D6
                        RB3              D7                    RB7              D7
                        RB4              E                     RB1              E
                        RB5              R/S                   RB2              R/S
                        GND              RW                    GND              RW


        PDL:    is a free-format English-like text that describes the flow of control and data in a
                program. PDL is not a programming language. It is a collection of some keywords that enable
                a programmer to describe the operation of a program in a stepwise and logical manner:

              BEGIN
                  Choose the board to work with (easyPIC or microgenios)
                  Configure  LCD module connections

                  Configure PORTB as digital outputs
                  Define PORTB.RB0 as UP_KEY
                  Define PORTB.RB1 as DOWN_KEY
                  Initialize the LCD
                  Clear the LCD
                  Set cursor off
                  Write heading 'Value:' in the first line
                  
                  DO FOREVER
                  
                     IF key up is pressed THEN
                        Increment a counter
                        Convert number to text
                        Write to LCD
                        Wait .3s  
                     ENDIF
                        
                     IF key down is pressed THEN
                        Decrement a counter
                        Convert number to text
                        Write to LCD
                        Wait .3sc
                     ENDIF
                  ENDO
              END

       Date:   Nov 2019
*/
#define TRUE 1
#define UP_KEY PORTB.RB0
#define DOWN_KEY PORTB.RB1
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
                                      // Loop variable
void main(){
signed int counter = 0 ;
unsigned char txt[10];
                                      // For PIC18F45K22
#ifdef PIC18F45K22
       ANSELB = 0;                    // Config all the PORTB's pins as digital
#else                                 // For PIC18F4520
       ADCON1 |= 0X0F;                // Config all ADC's pins as digital
#endif

  TRISB.RB0 = 1;                      // Up key ON PORTB.RB0
  PORTB.RB0 = 1;

  TRISB.RB1 = 1;                      // Down key ON PORTB.RB3
  PORTB.RB1 = 1;
  
  Lcd_Init();                         // Initialize LCD

  Lcd_Cmd(_LCD_CLEAR);                // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);           // Cursor off

  Lcd_Out(1, 1, "Value:");            // Write heading text in the first line

  while(TRUE)
  {
             if ( UP_KEY == 0 )
             {
                  counter++;
                  WordToStr(counter, txt);
                  Lcd_Out(1,7, txt);
                  Delay_ms(300);      // debouncing
             }
             
             if ( DOWN_KEY == 0 )
             {
                  counter--;
                  WordToStr(counter, txt);
                  Lcd_Out(1,7, txt);
                  Delay_ms(300);     // debouncing
             }
             
  }

}