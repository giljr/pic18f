#line 1 "C:/Users/giljr/Documents/pic/unit_01_IO/05_code/unit_01_05_Chasing_LED.c"
#line 40 "C:/Users/giljr/Documents/pic/unit_01_IO/05_code/unit_01_05_Chasing_LED.c"
void main() {
 unsigned char j = 1 ;





 ADCON1 |= 0X0F;


 TRISB = 0;
 PORTB = 0;


for(;;)
 {
 PORTB = j;
 Delay_ms(100);
 j = j << 1;
 if(j == 0) j = 1;

 }
}
