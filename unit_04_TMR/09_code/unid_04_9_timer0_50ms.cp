#line 1 "C:/Users/giljr/Documents/pic/unit_04_TMR/09_code/unid_04_9_timer0_50ms.c"
#line 27 "C:/Users/giljr/Documents/pic/unit_04_TMR/09_code/unid_04_9_timer0_50ms.c"
 void ConfigMCU();
 void ConfigTimer();
#line 59 "C:/Users/giljr/Documents/pic/unit_04_TMR/09_code/unid_04_9_timer0_50ms.c"
 void ConfigMCU()
 {



 ADCON1 = 0X0F;

 TRISD = 0;
 PORTD = 0;
 }

 void ConfigTimer()
 {



 T0CON = 0B10000111;

 TMR0H = 0XFE;
 TMR0L = 0X7A;

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
 PORTD.RD5 = ~LATD.RD5;

 TMR0H = 0XFE;
 TMR0L = 0X7A;
 INTCON.TMR0IF = 0;
 }
 }
 }
