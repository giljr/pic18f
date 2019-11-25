#line 1 "C:/Users/giljr/Documents/pic/unit_02_LCD/01_code/unit02_01_helloWorlldLCD.c"
#line 71 "C:/Users/giljr/Documents/pic/unit_02_LCD/01_code/unit02_01_helloWorlldLCD.c"
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




 ADCON1 |= 0X0F;


 Lcd_Init();

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 Lcd_Out(1,1,"First Line");
 Lcd_Out(2,1,"Second Line");

}
