/* Project: Unit 02 - LCD
      Code: unit_02_05_temp_LM35.c

   Objective:   In this project, the design of a digital thermometer is described. 
                An analog temperature sensor (LM35DZ) is used to sense the temperature,
                and the temperature is displayed on an LCD:)
                The output voltage is given by
                LM35 is conected to PIC's channel A/D AN2
                RE0:    Sensor de temperatura LM35
                Vo = 10 mV/°C
                Thus, for example, at 20°C, the output voltage is 200 mV,
                at 25°C it is 250 mV, and so on.

    LIB Note:   Select on Library Manager the LCD library for mokroC PRO for PIC:)
                > ADC
                > LCD
                > Conversions
                > C_String

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
                        RB4              E                     RE1              E
                        RB5              R/S                   RE2              R/S
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
                         Read temperature from channel 2
                         Convert reading into millivolts
                         Divide by 10 to find the temperature in Degrees C
                         Convert temperature into string
                         Clear display
                         Display Heading “Temperature”
                         Display the temperature
                         Wait 1s
                  ENDDO
               END

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
                                           // Loop variable
void main(){
unsigned char txt[14];
unsigned int temp;
float mV;
                                           // For PIC18F45K22
#ifdef PIC18F45K22
       ANSELB = 0;                         // Config all the PORTB's pins as digital
#else                                      // For PIC18F4520
       ADCON1 |= 0X0F;                     // Config all ADC's pins as digital
#endif

  Lcd_Init();                              // Initialize LCD

  Lcd_Cmd(_LCD_CLEAR);                     // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);                // Cursor off

                                           // Do forever
  for(;;) 
  { 
       temp = ADc_Read(2);                 // Read from channel 2
       mV = temp * 5000.0/1024.0;          // Convert to mV
       mV = mV/10.0;                       // mV is now the Degrees C
       floatToStr(mV, txt);                // Convert to string
       Lcd_cmd(_LCD_CLEAR);                // Clear LCD
       Lcd_out(1,1,"Temperature");         // Display heading
       Lcd_Out(2,1,Txt);                   // Display temperature
       Delay_ms(1000);                     // Wait 1 s and repeat}
  }
}