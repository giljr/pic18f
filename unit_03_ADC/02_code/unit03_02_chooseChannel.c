/* Project: Unit 03 - ADC
      Code: unit_03_02_chooseChannel.c

   Objective:   We will  create a function to read 
                a tripot at channel AN0 or AN1
                depending on the parameter passed:)

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

                  Call READADC function

                DO FOREVER
                    Call ADCREAD
                    Convert number to txt
                    Show the result in LCD
                    Wait .2s
                ENDDO
                
                BEGIN/ADCREAD 
                    Switch channel 0 or 1
                    Initialize ADC Module
                    Wait ADC termination time (GO_DONE bit)
                    Return ADRESH & ADRESL
                ENDIF END/ADCREAD


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
#define TRUE 1
                                       // Definition bit-to-bit - Related to PORT (data)
                                       // For picMicrogenios

sbit LCD_RS at LATE2_bit;
sbit LCD_EN at LATE1_bit;
sbit LCD_D4 at LATD4_bit;
sbit LCD_D5 at LATD5_bit;
sbit LCD_D6 at LATD6_bit;
sbit LCD_D7 at LATD7_bit;
                                       // picMicrogenios
sbit LCD_RS_Direction at TRISE2_bit;
sbit LCD_EN_Direction at TRISE1_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;
                                       // End LCD module connections
                                       // DCRead = ADCRead(0);
unsigned int ADCRead(unsigned char channel)
{
switch(channel)
   {
                                       // cases: 0 = AN0 or 1 = AN1
 case 0: {
            //ANSELA.B0 = 1;           // Only for for 18F45K22 - Please, uncomment for easyPIC v7
            TRISA.RA0 = 1;             // Input using AN0
            PORTA.RA0 = 1;             // optional

            ADCON0 =  0B00000001;      // AN0 - > AD on
            ADCON1 =  0B00001110;      // AN0/RA0 config as AD, ref internal v
                                       // Take care! PIC18F45K22 - > ANSELx
                                       // Frequency Adjust - This is the hard byte to config :)
                                       // ADCON2 =  0B10101010; //justify right, fosc/32, TAD = 12
            break;
         }

 case 1: {
            //ANSELA.B1 = 1;           // Only for for 18F45K22 - Please, uncomment for easyPIC v7
            TRISA.RA1 = 1;             // Input using AN0
            PORTA.RA1 = 1;             // Optional

            ADCON0 =  0B00000101;      // AN0 - > AD LIGADO
            //ADCON1 =  0B00001111;    // If use PIC18F45k22
             ADCON1 =  0B00001101;     // please config ADCON1=0B00001101
                                       // if PIC18F45K22 ADCON1=0B00001111 or 0B00000000
                                       // this chip use ANSEL
                                       // AN0/RA0 config as AD, ref internal v
                                       // Take care: PIC18F45K22 - > ANSELx
                                       // Frequency adjust
                                       // ADCON2 =  0B10101010;//justify right, fosc/32, TAD = 12
            break;
         }

    }
         ADCON2 =  0B10101010;         // justify right, fosc/32, TAD = 12
         delay_us(40);                 // Aquisition time de 7.45us; mode RC osc give it a time:)
                                       // between switch channel ADC and start w/ GO_DONE (capacitor charging)
         ADCON0.GO_DONE = 1;           // START convertion ADC
                                       // GO_DONE restart at zero by the hardware
           while(ADCON0.GO_DONE == 1); // wait ADC end
           return ((ADRESH << 8) | (int)ADRESL);
}

void main() {
  unsigned int Reading_ADC;
  unsigned char txt[10];
#ifdef P18F45K22
  ANSELB = 0;                          // DISPLAY LCD
#endif

  TRISA.RA0 = 1;                       // Input AN0
  PORTA.RA0 = 1;                       // Optional

  ADCON0 =  0B00000001;                // AN0 - > AD ON
  ADCON1 =  0B00001110;                // AN0/RA0 config as AD, ref internal V

  ADCON2 =  0B10101010;                // justify right, fosc/32, TAD = 12

      Lcd_Init();                      // Init LCD, 4-bit Mode
      Lcd_Cmd(_LCD_CLEAR);             // Cursor clear
      Lcd_Cmd(_LCD_CURSOR_OFF);        // Cursor off
      Lcd_Out(1, 1, "ADC: ");          // Line x Colunm


   while(TRUE)
   {
      Reading_ADC = ADCRead(0);        // Read channel AN0 = 0 ; change to AN1 = 1
      WordToStr(Reading_ADC, txt);
      LCD_Out (1,1, txt);
      Delay_ms(20);
   }
}