#line 1 "C:/Users/giljr/Documents/pic/unit_04_TMR/10_code/unid_04_timer0_50ms.c"
#line 28 "C:/Users/giljr/Documents/pic/unit_04_TMR/10_code/unid_04_timer0_50ms.c"
void ConfigMCU();
void ConfigTimer();
#line 62 "C:/Users/giljr/Documents/pic/unit_04_TMR/10_code/unid_04_timer0_50ms.c"
void ConfigMCU()
{



 ADCON1 = 0X0F;

 TRISD = 0;
 PORTD = 0;
 }

void ConfigTimer()
{



 T0CON = 0B00000110;

 TMR0H = 0XFC;
 TMR0L = 0XF3;

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

 TMR0H = 0XFC;
 TMR0L = 0XF3;
 INTCON.TMR0IF = 0;
 }
 }
}
