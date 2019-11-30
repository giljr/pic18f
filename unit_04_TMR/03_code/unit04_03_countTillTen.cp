#line 1 "C:/Users/giljr/Documents/pic/unit_04_TMR/03_code/unit04_03_countTillTen.c"
#line 66 "C:/Users/giljr/Documents/pic/unit_04_TMR/03_code/unit04_03_countTillTen.c"
void ConfigMCU()
{





 ADCON1 |= 0X0F;



 TRISA.RA4 = 1;

 PORTA.RA4 = 1;

 TRISB = 0;
 PORTB = 0;
 }

void ConfigTimer()
{
 T0CON = 0B00111000;
 TMR0H = 0XFF;
 TMR0L = 0XF6;

 INTCON.TMR0IF = 0;
 T0CON.TMR0ON = 1;
}


void main() {
 ConfigMCU();
 ConfigTimer();

 while ( 1 )
 {
 if(INTCON.TMR0IF == 1)
 {
 PORTB.RB0 = ~LATB.RB0;

 TMR0H = 0XFF;
 TMR0L = 0XF6;
 INTCON.TMR0IF = 0;
 }
 }
}
