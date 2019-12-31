/* Unit 07  - COMPARE   - 1KHz Signal Generator
MODO COMPARE (USING INTERRUPTIONS)
OBS: DO NOT USE LCD

Freq needed 1000hz; P = 1/F ->   1/1000Hz = 0.001 seg ->  1 ms(T)
P_maq * Prescale - > 0.5us * 2 = 1us
then we must do TMR1 in:
0.5ms(ON)+0.5ms(OFF) = 1ms -> then
500us = 0x01F4
CCPR1H = 0X01;
CCPR1L = 0XF4;
*/
#define TRUE 1
                                    /* Global variables */


 //**************Function prototypes *******************
#define TRUE 1
                                   // 1-config MCU
 void ConfigMCU();
                                   // 2-Config general interruptions
 void ConfigInterrupcao_Global();
                                   // 3-Prepare Timer1;
 void  Configuracao_Timer1();
                                   // 4-Config interruptions of particular peripheral
 void ConfigInterrucao_Compare();


void INTERRUPCAO_COMPARE_HIGH() iv 0x0008 ics ICS_AUTO {

  if(CCP1IF_bit == 1 && CCP1IE_bit == 1)
  {
    TMR1H = 0;
    TMR1L = 0;
    CCP1IF_bit = 0;                // Clean flag for comparator

    //INTCON.TMR0IF = 0;           // deleta flag ERROR! not from TMR but CCP

  }
}

                                   /* 1-config MCU */
void ConfigMCU ()
{
#ifdef P18F45K22
  ANSELB = 0;
  ANSELC = 0;
#else
   ADCON1 |= 0X0F;                 // Others uC
#endif

}

                                   /* 2-Config general interruptions  */
void ConfigInterrupcao_Global()
{
                                   // Registers GIEH, GIEL e IPEN from byte INTCON
    INTCON.GIEH = 1;               // Enable high priority
    INTCON.GIEL = 1;               // Enable low priority
    RCON.IPEN =  1;                // default heratage 16F, there one level
                                   // if = 1 two levels de prioridades PIC18F
                                   // if = 0, GIEL do not exists!
}

                                   /*  3-Prepare TMR1; */
 void  Configuracao_Timer1()
 {
                                   // TIMER 1: Config timer - CALC MEMORY
                                   // Fosc = 8MHz, P_ciclo_maq = 0.5us
                                   // to easy it up put 1:2, logo 0.5ux * 2 = 1us
                                   // so value is already in microsegundo

#ifdef P18F45K22
  T1CON = 0B00010011;              // 16 bits,TMR1 osc, PS 1:2, Fosc/4, Mod on
#else
  T1CON= 0B10010001;               // 16 bits,ext osc, PS 1:2, Fosc/4, Mod on
                                   // para PIC187452 / 4520 / 4550
#endif
  TMR1H = 0;
  TMR1L = 0;
                                   // LIGAR O TMR1
  T1CON.TMR1ON = 1;
                                   // do not need zeroing initial load
                                   // not even from registers - hot-runnuble!!!
}

/* 4-Configurar a interrupção - COMPARE - PIN OUT 1000HZ  */
void ConfigInterrucao_Compare()
{
                                   // use: PIR1: PERIPHERAL INTERRUPT REQUEST (FLAG) REGISTER 1
                                   // ccp for compare
                                   // Fire Protection Engenner FPE
  PIR1.CCP1IF = 0;
  IPR1.CCP1IP = 1;
  PIE1.CCP1IE = 1;
                                   // ccp for capture
  CCP1CON = 0;                     // Microchip recommendations - avoid unwanted interruptions:)

#ifdef P18F45K22
  T1CON = 0B00010011;              // for EasyPic v7
#else
  CCP1CON = 0B0000010;             // Compare mode, toggle output on match pg 141
#endif
                                   // Compare mode, toggle output on match (CCPxIF bit is set)
  CCPR1H = 0X01;
  CCPR1L = 0XF4;
                                   // DIRECTIONS HERE!!
  TRISC.RC2 = 0;                   // pin CCP as output
 }

/* Programa Principal */
void main() {

  ConfigMcu();
  ConfigInterrupcao_Global();
  Configuracao_Timer1();
  ConfigInterrucao_Compare();


  while (TRUE);                    // loop no outuput
  /*{

      if(PIE1.CCP1IE == 1)//se a interrupção ocorrer desvia para ISR
       {
         TMR1H = 0;
         TMR1L = 0;
         PIR1.CCP1IF = 0;         // clean flag for new camparations loop
       }
  }*/

}