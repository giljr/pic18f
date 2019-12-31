#line 1 "C:/Users/giljr/Documents/pic/unid_07_CMPR/02_code/unid_07_02_pulse_1khz.c"
#line 20 "C:/Users/giljr/Documents/pic/unid_07_CMPR/02_code/unid_07_02_pulse_1khz.c"
 void ConfigMCU();

 void ConfigInterrupcao_Global();

 void Configuracao_Timer1();

 void ConfigInterrucao_Compare();


void INTERRUPCAO_COMPARE_HIGH() iv 0x0008 ics ICS_AUTO {

 if(CCP1IF_bit == 1 && CCP1IE_bit == 1)
 {
 TMR1H = 0;
 TMR1L = 0;
 CCP1IF_bit = 0;



 }
}


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


 void Configuracao_Timer1()
 {








 T1CON= 0B10010001;


 TMR1H = 0;
 TMR1L = 0;

 T1CON.TMR1ON = 1;


}


void ConfigInterrucao_Compare()
{



 PIR1.CCP1IF = 0;
 IPR1.CCP1IP = 1;
 PIE1.CCP1IE = 1;

 CCP1CON = 0;




 CCP1CON = 0B0000010;


 CCPR1H = 0X01;
 CCPR1L = 0XF4;

 TRISC.RC2 = 0;
 }


void main() {

 ConfigMcu();
 ConfigInterrupcao_Global();
 Configuracao_Timer1();
 ConfigInterrucao_Compare();


 while ( 1 );
#line 131 "C:/Users/giljr/Documents/pic/unid_07_CMPR/02_code/unid_07_02_pulse_1khz.c"
}
