/* Project: Unit 03 - ADC
      Code: unit_03_05_forcePoint.c

   Objective:   This code tells you how to force a point to a numbers to turn it into (fake) float

   Lib Notes :  Select these Libraries (LIB.MANAGER) for mikroC PRO for PIC compiler:)
                 > ADC
                 > LCD
                 > Conversions

      Author:   mickroelektronica, edited by J3

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
   Date: Nov 2019

*/
 #define TRUE  1

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

void main(){
  unsigned int Valor_ADC = 0;
  unsigned char Tensao[10];

#ifdef P18F45K22
  TRISA.RA0 = 1;
  ANSELA = 0X01;
  ANSELB = 0;                                // Configure PORTB pins as digital
#else
  TRISA.RA0 = 1;
  ADCON1 = 0B00001101;                       //Configure RA0/AN0 and RA1/AN1 as ADC
#endif

  Lcd_Init();                                // Initialize Lcd
  Lcd_Cmd(_LCD_CLEAR);                       // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);                  // Cursor off
  Lcd_Out(1,1,"ADC1:");                      // Write line x Colunm to LCD

  ADC_Init();

 while(TRUE)
  {
    Valor_ADC = ADC_Read(1);
    Valor_ADC = Valor_ADC * (1023/1023.);    //0 to 1023 -> 0 to 1234
    Tensao[0] = (Valor_ADC/1000) + '0';      // 6 + '0'  = '6'
    Tensao[1] = (Valor_ADC/100)%10 + '0';    //'6' - '0' = 6
    Tensao[2] = '.';
    Tensao[3] = (Valor_ADC/10)%10 + '0';
    Tensao[4] = (Valor_ADC/1)%10 + '0';
    Tensao[5] = 0;                           // terminator NULL
    Lcd_Out(1,6,Tensao);                     // Show numbers at display
  }
}