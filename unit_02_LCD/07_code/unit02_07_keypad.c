/* Project: Unit 02 - LCD
      Code: unit_02_04_customChar.c

   Objective:   This program shows on lcd which keys you type on microgenios 3x4 keyboard

        Note:   Select on Library Manager for mikroC PRO for PIC:)
                > LCD
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
                  Define microcontroller - LCD connections
                  Define bit map of the required font
                  Configure PORTB as digital and output
                  Initalize LCD
                  Display text on LCD
                  CALL CustomChar to display the created font
              END

              BEGIN/CustomChar
                      Display required font as character 0
              END/CustomChar

       Date:   Nov 2019
*/

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
                                      
void lcdr(char a[5])                  // Auxiliary Function - LCD Return (lcdr)
{
     TRISD = 0x00;
     Lcd_Cmd(_LCD_CLEAR);
     LCD_out_cp(a);
     TRISD = 0XFF;
}

void main(){                          // KEYPAD 4X3 Matrix -> 4 LINE X 3 COLUMN
  char line;                          // define line variable  for matrix 4LN X 3CL
                                      // PORTD is LINE
                                      // PORTB is COLUMN
                                      // For PIC18F45K22
#ifdef PIC18F45K22
       ANSELB = 0;                    // Config all the PORTB's pins as digital
#else                                 // For PIC18F4520
       ADCON1 |= 0X0F;                // Config all ADC's pins as digital
#endif

  ADCON1 = 0x06;                      // Define AD's pin as general I/O
  TRISE = 0;
  TRISD = 0;                          // Configure PORTA as output
  
  Lcd_Init();                         // Initialize LCD

  Lcd_Cmd(_LCD_CLEAR);                // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);           // Cursor off

  Lcd_Out(1,1,"Keypad V1");           // Write text in first row
  

  PORTB = 0XFF;                       // PORTB as FF
  TRISB = 0;                          // Configure PORTB as output
  
  TRISD = 0XFF;                       // TRISD as FF
  PORTD = 0XFF;                       // PORTD as FF
  TRISD = 0XFF;                       // Configure PORTD as input

  do                                  // Routine's init for keypad scanning
  {
     //PORTB.f0 = 0;                    // Unable keypad's first column
      PORTB.RB0 = 0;
     line = PORTD;
     if (line.RD0 == 0) lcdr("<--");
     else if (line.RD1 == 0) lcdr("7");
     else if (line.RD2 == 0) lcdr("4");
     else if (line.RD3 == 0) lcdr("1");
     PORTB.RB0 = 1;                    // Disable keypad's first column
     
     //PORTB.f1 = 0;                    // Unable keypad's second column
     PORTB.RB1 = 0;
     line = PORTD;
     if (line.RD0 == 0) lcdr("0");
     else if (line.RD1 == 0) lcdr("8");
     else if (line.RD2 == 0) lcdr("5");
     else if (line.RD3 == 0) lcdr("2");
     PORTB.RB1 = 1;                    // Disable keypad's second column
     
     //PORTB.f2 = 0;                    // Unable keypad's third column
     PORTB.RB2 = 0;
     line = PORTD;
     if (line.RD0 == 0) lcdr("-->");
     else if (line.RD1 == 0) lcdr("9");
     else if (line.RD2 == 0) lcdr("6");
     else if (line.RD3 == 0) lcdr("3");
     PORTB.RB2 = 1;                    // Disable keypad's third column
     
     delay_ms(100);
  }
  
  while(1);

}