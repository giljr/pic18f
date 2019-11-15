#line 1 "C:/Users/giljr/Documents/pic/unit_01_IO/03_code/unit_01_03_pushAndBlinkAndDebounce.c"
#line 56 "C:/Users/giljr/Documents/pic/unit_01_IO/03_code/unit_01_03_pushAndBlinkAndDebounce.c"
void main() {
unsigned char flag = 0;







 ADCON1 |= 0X0F;




 TRISB.RB0 = 1;
 PORTB.RB0 = 1;


 TRISD = 0;
 PORTD = 0;
#line 83 "C:/Users/giljr/Documents/pic/unit_01_IO/03_code/unit_01_03_pushAndBlinkAndDebounce.c"
 while(1)
 {



 if(PORTB.RB0 == 0 && flag == 0 )
 {

 PORTD.RD0 = ~ LATD.RD0;
 flag = 1;
 Delay_ms(40);
 }

 if(PORTB.RB0 == 1 && flag == 1 )
 {
 flag = 0;
 Delay_ms(40);
 }

 }
}
