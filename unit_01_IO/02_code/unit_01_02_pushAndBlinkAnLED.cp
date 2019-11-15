#line 1 "C:/Users/giljr/Documents/pic/unit_01_IO/02_code/unit_01_02_pushAndBlinkAnLED.c"
#line 39 "C:/Users/giljr/Documents/pic/unit_01_IO/02_code/unit_01_02_pushAndBlinkAnLED.c"
void main() {






 ADCON1 |= 0X0F;




 TRISB.RB0 = 1;
 PORTB.RB0 = 1;


 TRISD = 0;
 PORTD = 0;
#line 64 "C:/Users/giljr/Documents/pic/unit_01_IO/02_code/unit_01_02_pushAndBlinkAnLED.c"
 while(1)
 {


 if(PORTB.RB0 == 0 )
 {




 PORTD.RD0 = ~ LATD.RD0;
 Delay_ms(300);
 }

 }
 }
