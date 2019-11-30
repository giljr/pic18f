#line 1 "C:/Users/giljr/Documents/pic/unit_05_INT/05_code/unit05_05_INT0_INT1_INT2.c"
#line 77 "C:/Users/giljr/Documents/pic/unit_05_INT/05_code/unit05_05_INT0_INT1_INT2.c"
 void configMCU();
 void configGlobalInterruption();
 void configIndividualVctINT0();
 void configIndividualVctINT1();
 void configIndividualVctINT2();

 void INTERRUPTION_HIGH() iv 0x0008 ics ICS_AUTO {
 if(INTCON.INT0IF == 1)
 {
 PORTD.RD4 ^= 1;
 INTCON.INT0IF = 0;
 } else
 if(INTCON3.INT1IF = 1)
 {
 PORTD.RD5 ^= 1;
 INTCON3.INT1IF = 0;
 }

}
 void INTERRUPTION_LOW() iv 0x0018 ics ICS_AUTO {
 if(INTCON3.INT2IF = 1)
 {
 PORTD.RD6 ^= 1;
 INTCON3.INT2IF = 0;
 }
}

void ConfigMCU()
{
#line 117 "C:/Users/giljr/Documents/pic/unit_05_INT/05_code/unit05_05_INT0_INT1_INT2.c"
 ADCON1 |= 0X0F;
 INTCON2.RBPU = 0;


 TRISD = 0;
 PORTD = 0;

 TRISB.RB0 = 1;
 TRISB.RB1 = 1;
 TRISB.RB2 = 1;

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


 INTCON.INTEDG0 = 1;

}

void configIndividualVctINT1()
{
 INTCON3.INT1IF = 0;
 INTCON3.INT1IP = 0;
 INTCON3.INT1IE = 1;
 INTCON3.INTEDG1 = 0;

}

void configIndividualVctINT2()
{
 INTCON3.INT2IF = 0;
 INTCON3.INT2IP = 1;
 INTCON3.INT2IE = 1;
 INTCON2.INTEDG1 = 1;
}

void main() {
 configMCU();
 configGlobalInterruption();
 configIndividualVctINT0();
 configIndividualVctINT1();
 configIndividualVctINT2();

 while(1);

}
