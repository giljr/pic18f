#line 1 "C:/Users/giljr/Documents/pic/unit_04_TMR/01_code/unit_04_01_timer0.c"
#line 77 "C:/Users/giljr/Documents/pic/unit_04_TMR/01_code/unit_04_01_timer0.c"
void ConfigMCU()
{



 ADCON1 |= 0X0F;


 TRISD = 0;
 PORTD = 0;
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
 ConfigMCU();
 ConfigTimer();

 while ( 1 )
 {
 if(INTCON.TMR0IF == 1)
 {
 PORTD.RD0 = ~LATD.RD0;

 TMR0L = 0XF7;
 TMR0H = 0XC7;
 INTCON.TMR0IF = 0;
 }

 }




}
