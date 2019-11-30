#line 1 "C:/Users/giljr/Documents/pic/unit_05_INT/06_code/unit05_06_IOC.c"
#line 65 "C:/Users/giljr/Documents/pic/unit_05_INT/06_code/unit05_06_IOC.c"
volatile char temp;

 void configMCU();
 void configGlobalInterruption();
 void configIndividualVctIOC();

 void INTERRUPCAO_HIGH() iv 0x0008 ics ICS_AUTO {
 if(INTCON.INT0IF == 1)
 {
 if(INTCON.RBIF == 1)
 {
 PORTD.RD6 ^= 1;


 temp = PORTB;
 PORTB = temp;





 INTCON.RBIF = 0;
 }
 }
}

void ConfigMCU()
{










 ADCON1 |= 0X0F;
 INTCON2.RBPU = 0;


 TRISD = 0;
 PORTD = 0;

 TRISB.RB0 = 1;

}

void configGlobalInterruption()
{
 INTCON.GIEH = 1;
 INTCON.GIEL = 1;
 RCON.IPEN = 1;
}

void configIndividualVctIOC()
{
#line 127 "C:/Users/giljr/Documents/pic/unit_05_INT/06_code/unit05_06_IOC.c"
 INTCON.RBIF = 0;
 INTCON2.RBIP = 1;
 INTCON.RBIE = 1;
}

void main() {
 configMCU();
 configGlobalInterruption();
 configIndividualVctIOC();


 while( 1 )
 {
 Delay_ms(300);
 PORTD.RD5 ^= 1;
 }
}
