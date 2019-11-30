#line 1 "C:/Users/giljr/Documents/pic/unit_04_TMR/02_code/unit04_02_timer0Extended.c"
#line 82 "C:/Users/giljr/Documents/pic/unit_04_TMR/02_code/unit04_02_timer0Extended.c"
void ConfigMCU()
{



 ADCON1 |= 0X0F;


 TRISB = 0;
 PORTB = 0;
 }

void ConfigTimer()
{
 T0CON = 0B00000110;
 TMR0L = 0XF7;
 TMR0H = 0XC7;
 INTCON.TMR0IF = 0;

 T0CON.TMR0ON = 1;
}


void main() {
unsigned char counter = 0;

 ConfigMCU();
 ConfigTimer();

 while ( 1 )
 {
 if(INTCON.TMR0IF == 1)
 {
 counter++;

 if(counter == 5)
 {
 PORTB.RB0 = ~LATB.RB0;
 counter = 0;
 }

 TMR0L = 0XF7;
 TMR0H = 0XC7;
 INTCON.TMR0IF = 0;
 }

 }




}
