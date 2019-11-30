#line 1 "C:/Users/giljr/Documents/pic/unit_05_INT/04_code/unit05_04_INT0.c"
#line 53 "C:/Users/giljr/Documents/pic/unit_05_INT/04_code/unit05_04_INT0.c"
 void configMCU();
 void configGlobalInterruption();
 void configIndividualVctINT0();

 void INTERRUPCAO_HIGH() iv 0x0008 ics ICS_AUTO {
 if(INTCON.INT0IF == 1)
 {
 PORTD.RD4 ^= 1;
 INTCON.INT0IF = 0;
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

void configIndividualVctINT0()
{
 INTCON.INT0IF = 0;


 INTCON.INT0IE = 1;


 INTCON2.INTEDG0 = 1;

}

void main() {
 configMCU();
 configGlobalInterruption();
 configIndividualVctINT0();

 while(1);

}
