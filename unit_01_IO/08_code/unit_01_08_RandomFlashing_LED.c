/*  Project:   Unit 01 - IO
       File:   unit_01_08_RandomFlashing_LED.c
       
  Objective:   RANDOM FLASHING LEDS: The program uses a pseudorandom number generator to generate 
               a number between 0 and 32767. This number is then divided by 128 to limit it between 1 and 255. 
               The resultant number is sent to PORTB of the microcontroller. This process is repeated every second.
               In this project 8 LEDs are connected to PORTB of a PIC18F452O microcontroller operated @ 8 MHz crystal.

               
        NOTE:  Unable C_Stdlib and C_Type libs on mikroC Pro for PIC's Library Manager \o/

     Author:   Dogan Ibrahim, edited by J3
        
        PDL:   is a free-format English-like text that describes the flow of control and data in a
               program. PDL is not a programming language. It is a collection of some keywords that enable
               a programmer to describe the operation of a program in a stepwise and logical manner:

              BEGIN
                  Initialize an integer p to hold 16 bits
                  Pre-compilation Directives (#ifdef -chip options- #else #endif)
                  Configure all PORTB pins as digital output
                  Initialize all PORTB as digital logical low
                  Initialize random number seed
                  
                  DO FOREVER
                         Generate a random number on p
                         Devide p/128 so that the number within 2^8
                         Send the number to PORTB
                         wait 1 s
                  ENDDO
              END
       Date:   Nov 2019
*/

void main()
{
unsigned int p;                      // Init an integer to hold 16 bits

#ifdef PIC18F45K22                   // For PIC18F45K22
       ANSELB = 0;                   // Config PORTB as digital
#else                                // For PIC18F4520
       ADCON1 |= 0X0F;               // Config all ADC's pins as digital on PIC18F4520
#endif

   TRISB = 0;                        // Config PORTB as output
   PORTB = 0;                        // Optional, the MCU do it automatically ;)
                                     // Config all PORTB as logic LOW
    srand(10);                       // Inialize random number seed
      
    for(;;)                          // Endless loop
      {
          p = rand();                // Generate a random number
          p = p / 128;               // Number between 1 and 255
          PORTB = p;                 // Send to PORTC
          Delay_ms(1000);            // 1 s delay
      }
}