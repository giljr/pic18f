/*
COMPARE MODE (DO NOT USE INTERRUPTION BUT  SOFTWARE POLLING)
GENERATE SIGNAL OF 50HZ

Freq needed 50hz; P = 1/F ->   1/50Hz = 0.02 seg ->  20 ms(T)
P_maq * Prescale - > 0.5us * 2 = 1us
we must have TMR1 in:
10ms(ON)+10ms(OFF) then
10000us = 0x2710
CCPR1H = 0X27;
CCPRQL = 0X10;
 Formula -> T  = CPF -> F = T / [CP * 2 (on/off)]
 CCPR1H:CCPR1L = 1/(FreqHz_needed * P_CicloMaq * Prescale * 2)
               = 1 / (50 * 0.0000005us * 2 * 2) = 10000
  For Period multiply by 2 , 20000us = 50Hz output pin
*/

#define TRUE 1
 /* Globals variable */


 //**************functions prototypes *******************
#define TRUE 1
                                      // 1-config Timer
 void ConfigMCU();
                                      // 2-Config interruptions in general
 void ConfigInterrupcao_Global();
                                      // 3-Prepare TMR1;
 void  Configuracao_TMR1();
                                      // 4-Config interruptions peripherals
 void ConfigInterrucao_CCP_Compare();

void ConfigMCU ()
{
#ifdef P18F45K22
  ANSELB = 0;
  ANSELC = 0;
#else
   ADCON1 |= 0X0F;                    // Others uC
#endif

}

                                      /* 2-Config a general interruptions  */
void ConfigInterrupcao_Global()
{
    // General interruptions GIEH, GIEL e IPEN of byte INTCON
    INTCON.GIEH = 1;                  // General config enable interruptions
    INTCON.GIEL = 1;                  // Enable low priorities, this is not general key
    RCON.IPEN =  1;                   // default family heritage 16F, just one level of priority
                                      // if = 1 two levels de priorities PIC18F
                                      // if = 0, GIEL do not exists!
}

/*  3-Prepare TMR1; */
 void  Configuracao_TMR1()
 {
                                      // TIMER 1: Config timer - Calculation Memory
                                      // Fosc = 8MHz, P_ciclo_maq = 0.5us
                                      // To easy it up put 1:2, logo 0.5ux * 2 = 1us
                                      // capture is in microsegundo
#ifdef P18F45K22
  T1CON = 0B00010011;                 // 16 bits,TMR1 osc, PS 1:2, Fosc/4, Mod On
#else  
  T1CON = 0B10010001;
                                      // 16 bits,ext osc, PS 1:2, Fosc/4, Mod On
                                      // for PIC187452 / 4520 / 4550
#endif
  TMR1H = 0;
  TMR1L = 0;
                                      // Turn on TMR1
  T1CON.TMR1ON = 1;
                                      // do not zeroing initial load
                                      // Not even the register. It just hot-runnable!
}

/* 4-Config interruptions for particular peripheral - COMPARE - PIN OUT 50HZ*/
void ConfigInterrucao_CCP_Compare()
{
                                      // ccp for capture
  CCP1CON = 0;                        // Microchip recommendations, Avoid interruptions not asked

  CCP1CON = 0B00000010;               // The firsts 4 bits pg 141
                                      // Compare mode, toggle output on match (CCPxIF bit is set)
  CCPR1H = 0X27;
  CCPR1L = 0X10;
                                      // Fire Protection Engenner FPE
  /*PIR1.CCP1IF = 0;
  IPR1.CCP1IP = 1;
  PIE1.CCP1IE = 1;*/
                                      // Directions here!!!
  TRISC.RC2 = 0;                      // pin CCP as saida
  TRISB.RB0 = 0;
  PORTB = 0;
  
 }

/* Main Program*/
void main() {
  unsigned int Periodo = 0;
  unsigned char TxtDta[10];           // Array for string (LCD)'s transform

  ConfigMcu();
  ConfigInterrupcao_Global();
  Configuracao_TMR1();
  ConfigInterrucao_CCP_Compare();

                                      /* SOFTWARE POLLING */
  while (TRUE)
  {
      //if(CCP1IE_bit == 1)           // ALTERNATIVE
      if(PIR1.CCP1IE == 1)            // monitore the FLAG'a comparation
       {
         TMR1H = 0;
         TMR1L = 0;
         PIR1.CCP1IF = 0;             // Clears the flag for comparations loop
       }
  }


}