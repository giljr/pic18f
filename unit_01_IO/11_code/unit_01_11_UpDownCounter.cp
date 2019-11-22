#line 1 "C:/Users/giljr/Documents/pic/unit_01_IO/11_code/unit_01_11_UpDownCounter.c"
#line 28 "C:/Users/giljr/Documents/pic/unit_01_IO/11_code/unit_01_11_UpDownCounter.c"
void configMCU();

void configMCU()
{



 ADCON1 |= 0X0F;


 TRISB.RB0 = 1;
 PORTB.RB0 = 1;

 TRISB.RB1 = 1;
 PORTB.RB1 = 1;

 TRISD = 0;
 PORTD = 0;
}
void main()
{
 unsigned char flag1 = 0;
 unsigned char flag2 = 0;

 configMCU();

 while( 1 )
 {
 if( PORTB.RB0  == 0 && flag1 == 0 &&  PORTD  < 255)
 {
 if ( PORTD  == 0) { PORTD  = 0b00000001;}
 else
  PORTD  = ( PORTD  << 1)|  PORTD ;
 flag1 = 1;
 }
 if( PORTB.RB0  == 1 && flag1 == 1)
 {
 Delay_ms(20);
 flag1 = 0;
 }
 if( PORTB.RB1  == 0 && flag2 == 0 &&  PORTD  > 0)
 {
  PORTD  = ( PORTD /2);
 flag2 = 1;
 }
 if( PORTB.RB1  == 1 && flag2 == 1)
 {
 Delay_ms(20);
 flag2 = 0;
 }
 }
}
