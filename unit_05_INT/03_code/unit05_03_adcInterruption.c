/* Project: Unit 05 - INT
      Code: unit_05_03_adcInterruption.c

   Objective:   In this project let's use INTERRUPTION: 
                Read 20 sample form ADC and present the arithmetic result in the LCD.
                At the end of the conversion, then the Interrupt Indicator Flag will be set (ADIF).
                Consequently, as soon as it is set, the program will be diverted
                for an interrupt routine. (formerly void interrupt_low ())
                In this routine we should do the ADC readings and
                store the values in a buffer in an amount
                suggested and when the buffer is full we make the
                arithmetic mean of the sum of the values in int (10 bits) and
                display the media on an LCD
                Here you will learn how to use UNION \o/

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
                     Call CONFIGMCU
                     Call CONFIGADC1
                     Call CONFIGGLABALINTERRUPTION
                     Call CONFIGINDIVIDUALVCTTMR0
                 DO FOREVER
                        IF Timer0 overflow THEN
                           Toggle PORTD reg. bit 0 on/off
                           Recharge Registers TMR0L/TMR0R
                           Clear TMR0's overflow flag
                        ENDIF
                 ENDDO
                 BEGIN/CONFIGMCU
                     Pre-compilation Directives (config PORTD as digital)
                     Configure options for PIC18F45K22 & PIC18F4520
                     Configure all PORTD as digital output (init all LEDs off)
                 END/CONFIGMCU
                 BEGIN/CONFIGADC1
                     Config T0CON
                     Charge TMR0L & TMR0H's acumulator initial value
                     Clear overflow's flag
                     Turn TMR0 on
                 END/CONFIGADC1
                 BEGIN/CONFIGGLABALINTERRUPTION
                     Config general interruptions High & Low (GIEH & GIEL)
                     Config interruption priority (IPEN)
                 END/CONFIGGLABALINTERRUPTION
                 BEGIN/CONFIGINDIVIDUALVCTTMR0
                     Config IF, IP & IE vectors (Flag, Prior & Enable)
                 END/CONFIGINDIVIDUALVCTTMR0
              END

       Date:   Nov 2019
*/

/* ---------------------Calculation Memory ------------------------------------
   Interrupton: which registers must be set up(Timer0)? T0CON, TMROH & TMR0L
   Hardware: picGenios and easyPIC v7 boards
   Machine Cycle = FOSC/4 -> 8MHz/4 -> 2MHz -> p = 0.5us
   **************************
   Formulae:
   OverflowTime = P_MacCycle * Prescale * (Mode_16bits - InitialCounter)
   200000us     =    0.5us   *    32    *       (65536 - X)
   200000  /  (0.5 * 32) = 65536 - X
   12500                 = 65536 - X
   12500 - 65536         = - X (-1)
   53036                 = X
   X = 53036 (InitialCounter - inside two registers TMR0L e TMR0H)
   Transform the number in HEX: CF 2C
   ****************
   T0CON = 0B00000100 (see datasheet)
   TMR0L = OX CF;
   TMR0H = 0X 2C;
   ****************
   Good Practices: Before turn on any peripherals, please configure it first;);
   in other words, in configuration mode init TM0 as late as possible;)
   -------------------------------------------------------------------------
   Date: nov 2019
*/

#define TRUE 1
                                       // Protypes
void configMCU();
void configADC1();
void configGlobalInterruption();
void configIndividualVctADC();

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
union TwoBytes{                        // Declaring a TwoBytes structure:
 unsigned char BYTE[2];                // BYTE1 | BYTE2
 unsigned int INTEGER;                 // I N T E G E R
}TWO;


#define N_SAMPLING 20                  // Configurable Sampling variable

unsigned char txt[10];                 // LCD presenting array

                                       // VOLATILES used on interruptions
volatile unsigned int BufferADC[N_SAMPLING];
volatile unsigned long int averageResult = 0;
volatile char StatusADC = 0;
                                       // Interruptions Service Routine (ISR)
void INTERRUPTION_ADC_HIGH() iv 0x0008 ics ICS_AUTO {
  volatile static char _i = 0;         // Variable to control sampling's times

  if (PIR1.ADIF == 1 && PIE1.ADIE == 1)
  {                                    // Interruptions enable? Disable for writing on LCD.
   PIR1.ADIF = 0;                      // Clear flag
   TWO.BYTE[0] = ADRESL;
   TWO.BYTE[1] = ADRESH;               // Read .BYTE(chars) e store at int(INTEGER)
   if(_i < N_SAMPLING){
    BufferADC[_i] = TWO.INTEGER;       // leio o int do meu union
    ++_i;
                                       // First SAMPLE, inc o _xi
                                       // False condition when buffer are full (N sampling)
   }
   else {
                                       // For calculation: aritmetic mean
   PIE1.ADIE = 0;                      // Turn off interruption to calculate number

   averageResult = 0 ;                 // Init long variable, add int by int
   for(_i = 0; _i < N_SAMPLING; ++ _i)
   {
      averageResult += BufferADC[_i];  //  max 20460 - int will serve but here's long;)
   }
   averageResult /= N_SAMPLING;        // Aritmethic calc
   _i = 0;                             // Next sampling
   }
  }
}

                                       // Config general master interruptions vectors
void configGlobalInterruption()
{
    INTCON.GIEH = 1;
    INTCON.GIEL = 1;                   // High priority
    RCON.IPEN =  1;
}


void configIndividualVctADC()
{
  PIR1.ADIF = 0;                       // Flag signalize end ADC's conversions
  IPR1.ADIP = 1;                       // High priority
  PIE1.ADIE = 1;                       // Interruption enable
                                       // As soon go_done=1, aquisition and conversion

}
 void configMCU()                      // Timer0 Port & Directions
 {
#ifdef P18F45K22
  ANSELA.B0 = 1;
  ANSELB = 0;
  ANSELD = 0;
#else                                  // A/D Port Configuration Control bits
 //ADCON1 |= 0X0F;                     // If all digitals
  ADCON1 |= 0B00001110;                // AN1 analogic  pg 226 Datasheet
#endif
                                       // else no needed, only cmds to 45K20
  TRISA.RA0 = 1;                       // Input signal ADC
  PORTA.RA0 = 1;                       // optional

  TRISD = 0;
  PORTD = 0;
}
void configADC1()
{
  ADCON0 =  0B00000101;                // AN1 - > AD on
  ADCON1 =  0B00001110;                // AN0/RA0 config as AD, ref internal V
                                       // Frequency adjust
  ADCON2 =  0B10101010;                // justify right, fosc/32, TAD = 12
}

void main() {
  configMCU();
  configADC1();
  configGlobalInterruption();          // config general ints
  configIndividualVctADC();

  Lcd_Init();                          // Init LCD, 4-bit Mode
  Lcd_Cmd(_LCD_CLEAR);                 // Screen clear
  Lcd_Cmd(_LCD_CURSOR_OFF);            // Clear cursor
  Lcd_Out(1, 1, "ADC: ");              // Line x Colunm

        while(TRUE)
        {
           ADCON0.GO_DONE = 1;         // START ADC's conversion
                                       // Reset GO_DONE

           if(PIE1.ADIE == 0) {        // Interruption disabled?
             wordToStr((int)averageResult, txt);
             LCD_Out (1,5, txt);
             Delay_ms(20);

               PIE1.ADIE = 1;          // After writing LCD enable interruption again
                                       // PIE1.ADIE == 1;//Watch out! Its not comparation!!!!BUG!!!!
                                       // Comparation is only on IF!!!!HERE IT'S IGUALITY!!!!!

          }
        }
}