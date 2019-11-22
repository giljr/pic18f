#line 1 "C:/Users/giljr/Documents/pic/unit_01_IO/07_code/unit_01_07_ComplexFlashing_LED.c"
#line 36 "C:/Users/giljr/Documents/pic/unit_01_IO/07_code/unit_01_07_ComplexFlashing_LED.c"
void main()
{
unsigned char i;



 ADCON1 |= 0X0F;


 TRISB = 0;
 PORTB = 0;


 for(;;)
 {
 for(i = 0; i < 3; i++)
 {
 PORTB.RB0 = 1;
 Delay_ms(200);
 PORTB.RB0 = 0;
 Delay_ms(200);
 }
 Delay_ms(2000);
 }
}
