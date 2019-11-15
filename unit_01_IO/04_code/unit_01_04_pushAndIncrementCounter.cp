#line 1 "C:/Users/giljr/Documents/pic/unit_01_IO/04_code/unit_01_04_pushAndIncrementCounter.c"
#line 56 "C:/Users/giljr/Documents/pic/unit_01_IO/04_code/unit_01_04_pushAndIncrementCounter.c"
unsigned char myCounter = 0;

void increment (unsigned char counter)
 {
 switch (counter)
 {
 case 1:{PORTD.RD0 = 1; break;}
 case 2:{PORTD.RD1 = 1; break;}
 case 3:{PORTD.RD2 = 1; break;}
 case 4:{PORTD.RD3 = 1; break;}
 case 5:{PORTD.RD4 = 1; break;}
 case 6:{PORTD.RD5 = 1; break;}
 case 7:{PORTD.RD6 = 1; break;}
 case 8:{PORTD.RD7 = 1; break;}
 default: {PORTD = 0; MyCounter = 0; break;}
 }
 }

void main() {
unsigned char flag = 0;







 ADCON1 |= 0X0F;




 TRISB.RB0 = 1;
 PORTB.RB0 = 1;


 TRISD = 0;
 PORTD = 0;
#line 101 "C:/Users/giljr/Documents/pic/unit_01_IO/04_code/unit_01_04_pushAndIncrementCounter.c"
 while(1)
 {



 if(PORTB.RB0 == 0 && flag == 0 )
 {


 increment(++myCounter);
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
