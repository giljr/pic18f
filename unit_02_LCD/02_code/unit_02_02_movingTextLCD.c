/* Project: Unit 02 - LCD
      Code: unit_02_02_movingTextLCD.c

   Objective:   In this project we will work with moving text on LCD;
                How do you make animated greeting message?
                WELCOME!

      Author:   mikroelektronica, edited by J3

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
                  Initialize the LCD
                  Clear the LCD
                  Set cursor off

                  DO FOREVER
                      Left shifting text
                      Right shifting text
                      Wait .5 s
                  ENDDO
              END

              BEGIN/Move Delay
                     Wait .5 s
              END/Move Delay

       Date:   Oct 2019
*/

                                      // PIC18F45K22  - easyPICn7 Board
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

char txt1[] = "J3 presents now:";
char txt2[] = "PIC18-Step-by-step";
char txt3[] = "Welcome to";
char txt4[] = "Jungletronics";

char i;                               // Loop variable

void Move_Delay() {                   // Function used for text moving
  Delay_ms(500);                      // You can change the moving speed here
}

void main(){
                                      // For PIC18F45K22
#ifdef PIC18F45K22
       ANSELB = 0;                    // Config all the PORTB's pins as digital
#else                                 // For PIC18F4520
       ADCON1 |= 0X0F;                // Config all ADC's pins as digital
#endif

  Lcd_Init();                         // Initialize LCD

  Lcd_Cmd(_LCD_CLEAR);                // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);           // Cursor off
  Lcd_Out(1,1,txt3);                  // Write text in first row

  Lcd_Out(2,4,txt4);                  // Write text in second row
  Delay_ms(2000);
  Lcd_Cmd(_LCD_CLEAR);                // Clear display

  Lcd_Out(1,1,txt1);                  // Write text in first row
  Lcd_Out(2,1,txt2);                  // Write text in second row

  Delay_ms(2000);

                                      // Moving text
  for(i=0; i<4; i++) {                // Move text to the right 4 times
    Lcd_Cmd(_LCD_SHIFT_RIGHT);
    Move_Delay();
  }

  while(1) {                          // Endless loop
    for(i=0; i<8; i++) {              // Move text to the left 7 times
      Lcd_Cmd(_LCD_SHIFT_LEFT);
      Move_Delay();
    }

    for(i=0; i<8; i++) {              // Move text to the right 7 times
      Lcd_Cmd(_LCD_SHIFT_RIGHT);
      Move_Delay();
    }
  }
}