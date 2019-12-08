#line 1 "C:/Users/giljr/Documents/pic/unid_10_7SEG/unid_10_0_7segsTest.c"


 void main(){
 ADCON1 = 6;
 PORTA = 0;
 TRISA = 0;
 TRISD = 0;
 PORTD = 255;

 do {
 PORTA.F2= 1;
 PORTD = 0x06;
 Delay_ms(1);
 PORTA.F2= 0;
 PORTA.F3= 1;
 PORTD = 0x5B;
 Delay_ms(1);
 PORTA.F3= 0;
 PORTA.F4= 1;
 PORTD = 0x4F;
 Delay_ms(1);
 PORTA.F4= 0;
 PORTA.F5= 1;
 PORTD = 0x66;
 Delay_ms(1);
 PORTA.F5= 0;
 }
 while (1);
}
