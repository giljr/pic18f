#line 1 "C:/Users/giljr/Documents/pic/unit_01_IO/06_code/unit_01_06_DoubleChasing_LED.c"
#line 42 "C:/Users/giljr/Documents/pic/unit_01_IO/06_code/unit_01_06_DoubleChasing_LED.c"
void main() {
 unsigned char j = 0b10000000 ;
 unsigned char l = 0b00000001 ;




 ADCON1 |= 0X0F;


 TRISB = 0;
 PORTB = 0;


for(;;)
 {
 PORTB = (j|l);
 j>>=1;
 l<<=1;
 if(j==0) j = 0b10000000;
 if(l==0) l = 0b00000001;
 Delay_ms(100);
 }
}
