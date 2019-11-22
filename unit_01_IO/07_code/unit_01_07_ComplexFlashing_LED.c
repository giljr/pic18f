/*  Project:   Unit 01 - IO
       File:   unit_01_07_ComplexFlashing_LED.c
  
  Objective:   COMPLEX FLASHING LED: The program flashes the LED connuously with 
               the following pattern: 3 flashes with 200 ms delay between each flash 2 s delay; 
               the result closely resemble a red flashing lights from an ambulance or fire engine;
               this project an LEDs is connected to port pin RB0 of a PIC18F4520 microcontroller 
               operated from an 8 MHz crystal (on microgenios board set sw1 switch 10 = leds on PORTB)


     Author:   Dogan Ibrahim, edited by J3
     
        PDL:  is a free-format English-like text that describes the flow of control and data in a
              program. PDL is not a programming language. It is a collection of some keywords that enable
              a programmer to describe the operation of a program in a stepwise and logical manner:

              BEGIN
                  Initialize i as char (counter till 3)
                  Pre-compilation Directives (#ifdef -chip options- #else #endif)
                  Configure all PORTB pins as digital output
                  Initialize all PORTB as digital logical low
                  DO FOREVER
                     DO FOR THREE TIMES
                          Set RB0
                          wait .02 s
                          Reset RB0
                          wait .02 s
                     END DO FOR THREE TIMES
                     Wait 2 s
                  ENDDO
              END
       
       Date: Nov 2019
*/

void main()
{
unsigned char i;                     // Init a counter i
#ifdef PIC18F45K22                   // For PIC18F45K22
       ANSELB = 0;                   // Config PORTB as digital
#else                                // For PIC18F4520
       ADCON1 |= 0X0F;               // Config all ADC's pins as digital on PIC18F4520
#endif

   TRISB = 0;                        // Config PORTB as output
   PORTB = 0;                        // Optional, the MCU do it automatically ;)
                                     // Config all PORTB as logic LOW

  for(;;)                            // Endless loop
  {
      for(i = 0; i < 3; i++)         // Do 3 times
        {
            PORTB.RB0 = 1;           // LED ON
            Delay_ms(200);           // 200 ms delay
            PORTB.RB0 = 0;           // LED OFF
            Delay_ms(200);           // 200 ms delay
         }
          Delay_ms(2000);            // 2 s delay
      }
}