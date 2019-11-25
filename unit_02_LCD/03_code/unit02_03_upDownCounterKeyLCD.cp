#line 1 "C:/Users/giljr/Documents/pic/unit_02_LCD/03_code/unit02_03_upDownCounterKeyLCD.c"
#line 92 "C:/Users/giljr/Documents/pic/unit_02_LCD/03_code/unit02_03_upDownCounterKeyLCD.c"
sbit LCD_RS at LATE2_bit;
sbit LCD_EN at LATE1_bit;
sbit LCD_D4 at LATD4_bit;
sbit LCD_D5 at LATD5_bit;
sbit LCD_D6 at LATD6_bit;
sbit LCD_D7 at LATD7_bit;

sbit LCD_RS_Direction at TRISE2_bit;
sbit LCD_EN_Direction at TRISE1_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;


void main(){
signed int counter = 0 ;
unsigned char txt[10];




 ADCON1 |= 0X0F;


 TRISB.RB0 = 1;
 PORTB.RB0 = 1;

 TRISB.RB1 = 1;
 PORTB.RB1 = 1;

 Lcd_Init();

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 Lcd_Out(1, 1, "Value:");

 while( 1 )
 {
 if (  PORTB.RB0  == 0 )
 {
 counter++;
 WordToStr(counter, txt);
 Lcd_Out(1,7, txt);
 Delay_ms(300);
 }

 if (  PORTB.RB1  == 0 )
 {
 counter--;
 WordToStr(counter, txt);
 Lcd_Out(1,7, txt);
 Delay_ms(300);
 }

 }

}
