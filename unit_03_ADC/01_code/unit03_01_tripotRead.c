/* Project: Unit 03 - ADC
      Code: unit_03_01_tripotRead.c

   Objective:   This is the hello world for ADC Module!
                We will read a tripot at channel AN0
                and present the result in the LCD:)

        Note:   Select these Libraries for mikroC PRO for PIC compiler:)
                 > LCD
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
                  Configure PORTA as digital outputs
                  Configure PORTD as digital outputs
                  Configure ADC's Registers (ADCON0,1 & 2)
                  Initialize the LCD
                  Clear the LCD
                  Set cursor off

                  Write heading text on the first line
                  
                DO FOREVER
                    Initialize ADC Module
                    Wait ADC termination time (GO_DONE bit)
                    Read Registers ADRESH & ADRESL
                    Show the result in LCD
                    Wait .2s
                ENDDO
                
              END

       Date:   Nov 2019
*/
#define TRUE 1

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


void main() {
     unsigned int ADC_read;
     unsigned char txt[10];
     
                                      // For PIC18F45K22
#ifdef PIC18F45K22
       ANSELA.RA0 = 1                 // Config AN0 as analog
       ANSELB = 0;                    // Config all the PORTB's pins as digital
       ANSELD = 0;                    // Config all the PORTCs pins as digital

#endif

     PORTA.RA0 = 1;                   // tripot at AN0
     TRISA.RA0 = 1;                   // optional
     
     ADCON0 = 0B00000001;             // ADC Configurations bits - ADC on
     ADCON1 = 0B00001110;             // AN0 as AD, Internal REF V
     ADCON2 = 0B10101010;             // Right justify, FOSC/32, 12 TAD
     
     Lcd_Init();                      // Init LCD, 4-bit Mode
     Lcd_Cmd(_LCD_CLEAR);             // Clear LCD
     Lcd_Cmd(_LCD_CURSOR_OFF);        // Cursor off
     Lcd_Out(1, 1, "ADC: ");          // line x Column
     
     while (TRUE)
     {
           ADCON0.GO_DONE = 1;        // Init ADC
           
           while(ADCON0.GO_DONE == 1);
           ADC_read = ((ADRESH << 8)| (int)ADRESL);
           WordToStr(ADC_read, txt);
           LCD_Out(1, 8, txt);
           Delay_ms(20);
     }

}