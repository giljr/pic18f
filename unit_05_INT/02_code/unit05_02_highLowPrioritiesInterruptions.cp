#line 1 "C:/Users/giljr/Documents/pic/unit_05_INT/02_code/unit05_02_highLowPrioritiesInterruptions.c"
#line 128 "C:/Users/giljr/Documents/pic/unit_05_INT/02_code/unit05_02_highLowPrioritiesInterruptions.c"
 void configMCU();
 void configTMR0();
 void configTMR1();
 void configGlobalInterruption();
 void configIndividualVctTMR0();
 void configIndividualVctTMR1();

 void INTERRUPTION_HIGH() iv 0x0008 ics ICS_AUTO
{

 if(INTCON.TMR0IF == 1)
 {
 PORTD.RD0 = ~LATD.RD0;


 TMR0H = 0XCF;
 TMR0L = 0X2C;

 INTCON.TMR0IF = 0;

 }
}

void INTERRUPTION_LOW() iv 0x0018 ics ICS_AUTO {
 volatile unsigned char counter;

 if(PIR1.TMR1IF == 1)
 {
 counter++;

 if(counter == 4)
 {
 PORTD.RD4 ^= 1;
 counter = 0;
 }

 TMR1H = 0X0B;
 TMR1L = 0XDC;

 PIR1.TMR1IF = 0;

 }
}

 void configMCU()
 {



 ADCON1 |= 0X0F;


 TRISD = 0;
 PORTD = 0;
}
void configTMR0()
{



 T0CON = 0B00000100;

 TMR0H = 0XCF;
 TMR0L = 0X2C;

 INTCON.TMR0IF = 0;
 T0CON.TMR0ON = 1;
}
void configTMR1()
{



 T1CON = 0B10110000;

 TMR1H = 0X0B;
 TMR1L = 0XDC;

 PIR1.TMR1IF = 0;
 T1CON.TMR1ON = 1;
}
void configGlobalInterruption()
{
 INTCON.GIEH = 1;
 INTCON.GIEL = 1;
 RCON.IPEN = 1;


}
void configIndividualVctTMR0()
{

 INTCON.TMR0IF = 0;
 INTCON2.TMR0IP = 1;
 INTCON.TMR0IE = 1;
}
void configIndividualVctTMR1()
{

 PIR1.TMR1IF = 0;
 IPR1.TMR1IP = 0;
 PIE1.TMR1IE = 1;
}
void main() {
 configMCU();
 configTMR0();
 configTMR1();
 configGlobalInterruption();
 configIndividualVctTMR0();
 configIndividualVctTMR1();



 while( 1 )
 {
 PORTD.RD5 = ~LATD.RD5;
 Delay_ms(1000);

 }
}
