#line 1 "C:/Users/giljr/Documents/pic/unit_04_TMR/05_code/unit_04_05_timer1asCounter.c"
#line 67 "C:/Users/giljr/Documents/pic/unit_04_TMR/05_code/unit_04_05_timer1asCounter.c"
void ConfigMCU();
void ConfigTimer();

void ConfigMCU()
{




 ADCON1 |= 0X0F;

 TRISD = 0;
 PORTD = 0;
 TRISC.RC0 = 1;
 PORTC.RC0 = 1;
 }

void ConfigTimer()
{



 T1CON = 0B10000010;

 TMR1H = 0XFF;
 TMR1L = 0XFF;

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
 PORTD.RD0 = ~LATD.RD0;

 TMR1H = 0XFF;
 TMR1L = 0XFF;
 PIR1.TMR1IF = 0;
 }
 }
}
