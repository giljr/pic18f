#line 1 "C:/Users/giljr/Documents/pic/unit_01_IO/08_code/unit_01_08_RandomFlashing_LED.c"
#line 35 "C:/Users/giljr/Documents/pic/unit_01_IO/08_code/unit_01_08_RandomFlashing_LED.c"
void main()
{
unsigned int p;




 ADCON1 |= 0X0F;


 TRISB = 0;
 PORTB = 0;

 srand(10);

 for(;;)
 {
 p = rand();
 p = p / 128;
 PORTB = p;
 Delay_ms(1000);
 }
}
