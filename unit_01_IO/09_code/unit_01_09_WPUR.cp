#line 1 "C:/Users/giljr/Documents/pic/unit_01_IO/09_code/unit_01_09_WPUR.c"
#line 47 "C:/Users/giljr/Documents/pic/unit_01_IO/09_code/unit_01_09_WPUR.c"
void main() {







 INTCON2.RBPU = 0;
 ADCON1 |= 0X0F;


 TRISB.RB0 = 1;
 PORTB.RB0 = 1;


 TRISD = 0;
 PORTD = 0;


 while( 1 )
 {
 if(PORTB.RB0 == 0)
 {
 PORTD.RD0 =~LATD.RD0;
 Delay_ms(300);
 }
 }
 }
