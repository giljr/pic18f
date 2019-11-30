#line 1 "C:/Users/giljr/Documents/pic/unit_05_INT/01_code/unit05_01_blinkInterruption.c"
#line 87 "C:/Users/giljr/Documents/pic/unit_05_INT/01_code/unit05_01_blinkInterruption.c"
 void configMCU();
 void configTMR0();
 void configGlobalInterruption();
 void configIndividualVctTMR0();

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
void main() {
 configMCU();
 configTMR0();
 configGlobalInterruption();
 configIndividualVctTMR0();



 while( 1 )
 {
 PORTD.RD6 = ~LATD.RD6;
 Delay_ms(1000);

 }
}
