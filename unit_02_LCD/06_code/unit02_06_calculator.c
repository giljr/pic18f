/* Project: Unit 02 - LCD
      Code: unit_02_06_calculator.c

   Objective:   In this project we will make a 
                Calculator with a Keypad and Liquid Crystal Display:)

        Note:   Select on Library Manager the LCD library fo mokroC PRO for PIC:)
                > LCD
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

                  Write text on the first line
                  Write text on the second line
              END

       Date:   Oct 2019
*/

                                                   // PIC18F45K22  - easyPIC v7 Board
                                                   // LCD module connections
#define MASK 0xF0
#define Enter 11 
#define Plus 12 
#define Minus 13 
#define Mulply 14 
#define Divide 15
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
                                      
unsigned char getkeypad() 
{
 unsigned char i,  Key = 0;
 PORTC = 0x01;                                     // Start with column 1
     
     while((PORTC & MASK) == 0)                    // While no key pressed
 {
     PORTC = (PORTC << 1);                         // next column
     Key++;                                        // column number
     if(Key == 4)              
        {
            PORTC = 0x01;                          // Back to column 1
            Key = 0;
        }
 }
  Delay_Ms(20);                                    // Switch debounce
        for(i = 0x10; i !=0; i <<=1)               // Find the key pressed
        {            if((PORTC & i) != 0)break;            Key = Key + 4;         }
     PORTC = 0x0F;
     while((PORTC & MASK) != 0);                   // Wait unl key released
     Delay_Ms(20);                                 // Switch debounce
     return (Key);                                 // Return key number
 }
        
void main(){
     unsigned char MyKey, i,j,op[12];      
     unsigned long Calc, Op1, Op2;      
     char *lcd;
                                                   // For PIC18F45K22
#ifdef P18F45K22
       ANSELE = 0;                                 // Config all the PORTB's pins as digital
       ANSELD = 0;                                 // Config all the PORTC's pins as digital
#else                                              // For PIC18F4520
       ADCON1 |= 0X0F;                             // Config all ADC's pins as digital
#endif

   PORTE = 0;
   TRISE = 0;
   
   PORTD = 0;
   TRISD = 0XF0;                                   // RC4–RC7 are inputs
   
  Lcd_Init();                                      // Initialize LCD

  Lcd_Cmd(_LCD_CLEAR);                             // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);                        // Cursor off

  Lcd_Out(1,1,"CALCULATOR");                       // Write text in first row
  
  // // Program loop //     
  for(;;)                                          // Endless loop
  {
      MyKey = 0;         
      Op1 = 0;         
      Op2 = 0;
        
        Lcd_Out(1,1,"No1: ");                      // Display No1:
        
            while(1)                               // Get ?rst no
          {
             MyKey = getkeypad();
             if(MyKey == Enter)break;              // If ENTER pressed
             MyKey++;
             if(MyKey == 10)MyKey = 0;             // If 0 key pressed
             Lcd_Chr_Cp(MyKey + '0');
             Op1 = 10 * Op1 + MyKey;               // First number in Op1
          }
          
           Lcd_Out(2,1,"No2: ");                   // Display No2:
                    
          while(1)                                 // Get ?rst no
          {
             MyKey = getkeypad();
             if(MyKey == Enter)break;              // If ENTER pressed
             MyKey++;
             if(MyKey == 10)MyKey = 0;             // If 0 key pressed
             Lcd_Chr_Cp(MyKey + '0');
             Op2 = 10 * Op1 + MyKey;               // Second number in Op2
          }
          Lcd_Cmd(_LCD_CLEAR);                     // Clear LCD         
          Lcd_Out(1,1,"Op: ");                     // Display Op:
          MyKey = getkeypad();                     // Get operaon
          Lcd_Cmd(_LCD_CLEAR);
          Lcd_Out(1,1,"Res=");                     // Display Res=
        
          switch(MyKey)                            // Perform the operaon
           {
            case Plus:                   
                 Calc = Op1 + Op2;                 // If ADD
                 break;
             case Minus:
                  Calc = Op1 - Op2;                // If Subtract
                   break;
             case Mulply:                   
                  Calc = Op1 * Op2;                // If Mulply
                  break;
             case Divide:
                  Calc = Op1/Op2;                  // If Divide
                  break;
           }
        
        LongToStr(Calc, op);                       // Convert to string in op
        lcd = Ltrim(op);                           // Remove leading blanks
        Lcd_Out_Cp(lcd);                           // Display result
        Delay_ms(5000);                            // Wait 5 s
        Lcd_Cmd(_LCD_CLEAR);                       // Clear LCD
  }

}