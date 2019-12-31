#line 1 "C:/Users/giljr/Documents/pic/unid_07_CMPR/01_code/unid_07_01_pulse_50hz.c"
#line 25 "C:/Users/giljr/Documents/pic/unid_07_CMPR/01_code/unid_07_01_pulse_50hz.c"
 void ConfigMCU();

 void ConfigInterrupcao_Global();

 void Configuracao_TMR1();

 void ConfigInterrucao_CCP_Compare();

void ConfigMCU ()
{




 ADCON1 |= 0X0F;


}


void ConfigInterrupcao_Global()
{

 INTCON.GIEH = 1;
 INTCON.GIEL = 1;
 RCON.IPEN = 1;


}


 void Configuracao_TMR1()
 {







 T1CON = 0B10010001;



 TMR1H = 0;
 TMR1L = 0;

 T1CON.TMR1ON = 1;


}


void ConfigInterrucao_CCP_Compare()
{

 CCP1CON = 0;

 CCP1CON = 0B00000010;

 CCPR1H = 0X27;
 CCPR1L = 0X10;
#line 92 "C:/Users/giljr/Documents/pic/unid_07_CMPR/01_code/unid_07_01_pulse_50hz.c"
 TRISC.RC2 = 0;
 TRISB.RB0 = 0;
 PORTB = 0;

 }


void main() {
 unsigned int Periodo = 0;
 unsigned char TxtDta[10];

 ConfigMcu();
 ConfigInterrupcao_Global();
 Configuracao_TMR1();
 ConfigInterrucao_CCP_Compare();


 while ( 1 )
 {

 if(PIR1.CCP1IE == 1)
 {
 TMR1H = 0;
 TMR1L = 0;
 PIR1.CCP1IF = 0;
 }
 }


}
