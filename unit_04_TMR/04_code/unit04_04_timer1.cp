#line 1 "C:/Users/giljr/Documents/pic/unit_04_TMR/04_code/unit04_04_timer1.c"
#line 67 "C:/Users/giljr/Documents/pic/unit_04_TMR/04_code/unit04_04_timer1.c"
void ConfigMCU();
void ConfigTimer();

void ConfigMCU()
{



 ADCON1 |= 0X0F;

 TRISB = 0;
 PORTB = 0;
 }

void ConfigTimer()
{



 T1CON = 0B10110000;

 TMR1H = 0;
 TMR1L = 0;

 PIR1.TMR1IF = 0;
 T1CON.TMR1ON = 1;
}

void main() {
 ConfigMCU();
 ConfigTimer();

 while ( 1 )
 {
 if(PIR1.TMR1IF == 1)
 {
 PORTB.RB0 = ~LATB.RB0;

 TMR1H = 0;
 TMR1L = 0;
 PIR1.TMR1IF = 0;
 }
 }
}
