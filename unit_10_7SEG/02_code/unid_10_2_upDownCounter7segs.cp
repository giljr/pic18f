#line 1 "C:/Users/giljr/Documents/pic/unid_10_7SEG/02_code/unid_10_2_upDownCounter7segs.c"
#line 23 "C:/Users/giljr/Documents/pic/unid_10_7SEG/02_code/unid_10_2_upDownCounter7segs.c"
void configMCU();
void configTimer0();
void configGlobalInterruption();
void configGlobalInterruption();

 unsigned char DMatriz[] = {63, 6, 91, 79, 102, 109, 125, 7, 127, 111};
 unsigned char Dta[4];






void INTERRUPTION_HIGH() iv 0x0008 ics ICS_AUTO {

static enum {
 d1 = 1,
 d2,
 d3,
 d4
 } state_machine = d1;
#line 53 "C:/Users/giljr/Documents/pic/unid_10_7SEG/02_code/unid_10_2_upDownCounter7segs.c"
if(INTCON.TMR0IF == 1)
 {
 PORTA &= 0B11000011;
 switch(state_machine)
 {
 case d1: {
 PORTD = Dta[0];
 PORTA.RA5 = 1;
 state_machine = d2;
 break;
 }
 case d2: {
 PORTD = Dta[1];
 PORTA.RA4 = 1;
 state_machine = d3;
 break;
 }
 case d3: {
 PORTD = Dta[2];
 PORTA.RA3 = 1;
 state_machine = d4;
 break;
 }
 case d4: {
 PORTD = Dta[3];
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



 TRISB.RB0 = 1;
 PORTB.RB0 = 1;

 TRISB.RB1 = 1;
 PORTB.RB1 = 1;
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
 unsigned int Count = 0;
 unsigned int varAux;
 configMCU();
 configTimer0();
 configGlobalInterruption();
 configIndividualVctTMR0();








 while( 1 )
 {
 if(PORTB.RB0 == 0 && Count < 9999)
 {
 Count++;
 Delay_ms(300);
 }

 if(PORTB.RB1 == 0 && Count > 0)
 {
 Count--;
 Delay_ms(300);
 }


 varAux = Count;

 Dta[0] = DMatriz[varAux%10000];
 varAux /= 1000;
 Dta[1] = DMatriz[varAux%1000;
 varAux /= 100;
 Dta[2] = DMatriz[(vrAux/1%)%0
 varAux /= 10;
 Dta[3] = DMatriz[(vrAux/1%%0
 varAux /= 10; Delay_ms(10);


 }
}
