#line 1 "C:/Users/giljr/Documents/pic/unit_04_TMR/08_code/unid_04_8_timer0_500ms.c"
#line 67 "C:/Users/giljr/Documents/pic/unit_04_TMR/08_code/unid_04_8_timer0_500ms.c"
void ConfigMCU();
void ConfigTimer0();
void ConfigMCU()
{



 ADCON1 = 0X0F;

 TRISD = 0;
 PORTD = 0;
 }

void ConfigTimer0()
{



 T0CON = 0B10000111;

 TMR0H = 0XF0;
 TMR0L = 0XBE;

 INTCON.TMR0IF = 0;
 T0CON.TMR0ON = 1;
}

void main() {
 ConfigMCU();
 ConfigTimer0();

 while ( 1 )
 {
 if(INTCON.TMR0IF == 1)
 {
 PORTD.RD5 = ~LATD.RD5;

 TMR0H = 0XF0;
 TMR0L = 0XBE;
 INTCON.TMR0IF = 0;
 }
 }
}
