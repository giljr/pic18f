#line 1 "C:/Users/giljr/Documents/pic/unid_10_7SEG/01_code/unid_10_1_7segsScan.c"
#line 23 "C:/Users/giljr/Documents/pic/unid_10_7SEG/01_code/unid_10_1_7segsScan.c"
void configMCU();
void configTimer0();
void configGlobalInterruption();
void configGlobalInterruption();







void INTERRUPTION_HIGH() iv 0x0008 ics ICS_AUTO {

static enum {
 d1 = 1,
 d2,
 d3,
 d4
 } state_machine = d1;
#line 51 "C:/Users/giljr/Documents/pic/unid_10_7SEG/01_code/unid_10_1_7segsScan.c"
if(INTCON.TMR0IF == 1)
 {
 PORTA &= 0B11000011;
 switch(state_machine)
 {
 case d1: {
 PORTD = 102;
 PORTA.RA5 = 1;
 state_machine = d2;
 break;
 }
 case d2: {
 PORTD = 79;
 PORTA.RA4 = 1;
 state_machine = d3;
 break;
 }
 case d3: {
 PORTD = 91;
 PORTA.RA3 = 1;
 state_machine = d4;
 break;
 }
 case d4: {
 PORTD = 6;
 PORTA.RA2 = 1;
 state_machine = d1;
 break;
 }
 }
 }


 TMR0H = 0XFE;
 TMR0L = 0X06;
 INTCON.TMR0IF = 0;

}

 void configMCU()
 {




 ADCON1 |= 0X0F;


 TRISA = 0;
 PORTA = 0;
 TRISD = 0;
 PORTD = 0;
}

void configTimer0()
{




 T0CON = 0B00000010;

 TMR0L = 0XFE;
 TMR0H = 0X0C;
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

void main()
{
 configMCU();
 configTimer0();
 configGlobalInterruption();
 configIndividualVctTMR0();








 while( 1 )
 {


 }



}
