/*  Project:   Unit 01 - IO
       File:   unit_01_11_UpDownCounter.c

  Objective:   While KEY_UP turn on all the PORTB LEDS;
               While KEY DOWN turn off all PORTB LEDS, in a row:)

     Author:   microgenios, edited by J3

       Date:   Nov 2019
*/

#define TRUE 1
#define BTN_UP PORTB.RB0
#define BTN_DOWN PORTB.RB1
#define LEDS PORTD

                                     //Prototype
void configMCU();

void configMCU()
{
    #ifdef PIC18F45K22               // For PIC18F45K22
       ANSELB = 0;                   // Config PORTB as digital
    #else                            // For PIC18F4520
       ADCON1 |= 0X0F;               // Config all ADC's pins as digital on PIC18F4520
    #endif

    TRISB.RB0 = 1;                   // Config PORTB.RB0 as input (UP key)
    PORTB.RB0 = 1;                   // Optional, the MCU do it automatically ;)
    
    TRISB.RB1 = 1;                   // Config PORTB.RB1 as input (DOWN key)
    PORTB.RB1 = 1;                   // Optional, the MCU do it automatically ;)
    
    TRISD = 0;                       // Config PORTD as output
    PORTD = 0;                       // Turn off all the LEDs on PORTD
}
void main()
{
     unsigned char flag1 = 0;        // auxiliary flag to manipulate key's pulses
     unsigned char flag2 = 0;
     
     configMCU();                    // Config all the MCU

    while(TRUE)                      // Endless loop
      {
          if(BTN_UP == 0 && flag1 == 0 && LEDS < 255)
            {
                if (LEDS == 0) {LEDS = 0b00000001;}
                else
                  LEDS = (LEDS << 1)| LEDS;
                flag1 = 1;
            }
          if(BTN_UP == 1 && flag1 == 1)
              {
                  Delay_ms(20);
                  flag1 = 0;
              }
          if(BTN_DOWN == 0 && flag2 == 0 && LEDS > 0)
              {
                  LEDS = (LEDS/2);
                  flag2 = 1;
              }
          if(BTN_DOWN == 1 && flag2 == 1)
              {
                  Delay_ms(20);
                  flag2 = 0;
              }
      }
}