#line 1 "C:/Users/giljr/Documents/pic/unit_01_IO/01_code/unit_01_01_blinkingAnLED.c"
#line 40 "C:/Users/giljr/Documents/pic/unit_01_IO/01_code/unit_01_01_blinkingAnLED.c"
void main() {






 ADCON1 |= 0X0F;




 TRISB.RB0 = 1;
 PORTB.RB0 = 1;


 TRISD = 0;
 PORTD = 0;
#line 65 "C:/Users/giljr/Documents/pic/unit_01_IO/01_code/unit_01_01_blinkingAnLED.c"
 while(1)
 {
 PORTD.RD0 = 1;
 Delay_ms(300);
 PORTD.RD0 = 0;
 Delay_ms(300);
 }
}
