#line 1 "C:/Users/giljr/Documents/pic/unit_04_TMR/07_code/unit_04_07_timer2.c"
#line 61 "C:/Users/giljr/Documents/pic/unit_04_TMR/07_code/unit_04_07_timer2.c"
void configMCU()
{




 ADCON1 |= 0X0F;

 TRISB.RB0 = 1;
 TRISB.RB1 = 1;
 TRISD = 0;
 PORTD = 0;
}
void configTimer()
{



 T2CON = 0B01111011;

 PR2 = 255;
 PIR1.TMR2IF = 0;
 T2CON.TMR2ON = 1;
}

void main(){

 configMCU();
 ConfigTimer();

 while ( 1 ){

 if (PORTB.RB0 == 0) {
 T2CON.TMR2ON = 1;
 }

 if (PORTB.RB1 == 0){
 T2CON.TMR2ON = 0;
 }

 if (PIR1.TMR2IF == 1) {
 PORTD.RD4 = ~LATD.RD4;
 PIR1.TMR2IF = 0;
 }
 }
}
