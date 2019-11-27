#line 1 "C:/Users/giljr/Documents/pic/unit_02_LCD/07_code/unit02_07_keypad.c"
#line 70 "C:/Users/giljr/Documents/pic/unit_02_LCD/07_code/unit02_07_keypad.c"
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


void lcdr(char a[5])
{
 TRISD = 0x00;
 Lcd_Cmd(_LCD_CLEAR);
 LCD_out_cp(a);
 TRISD = 0XFF;
}

void main(){
 char line;






 ADCON1 |= 0X0F;


 ADCON1 = 0x06;
 TRISE = 0;
 TRISD = 0;

 Lcd_Init();

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 Lcd_Out(1,1,"Keypad V1");


 PORTB = 0XFF;
 TRISB = 0;

 TRISD = 0XFF;
 PORTD = 0XFF;
 TRISD = 0XFF;

 do
 {

 PORTB.RB0 = 0;
 line = PORTD;
 if (line.RD0 == 0) lcdr("<--");
 else if (line.RD1 == 0) lcdr("7");
 else if (line.RD2 == 0) lcdr("4");
 else if (line.RD3 == 0) lcdr("1");
 PORTB.RB0 = 1;


 PORTB.RB1 = 0;
 line = PORTD;
 if (line.RD0 == 0) lcdr("0");
 else if (line.RD1 == 0) lcdr("8");
 else if (line.RD2 == 0) lcdr("5");
 else if (line.RD3 == 0) lcdr("2");
 PORTB.RB1 = 1;


 PORTB.RB2 = 0;
 line = PORTD;
 if (line.RD0 == 0) lcdr("-->");
 else if (line.RD1 == 0) lcdr("9");
 else if (line.RD2 == 0) lcdr("6");
 else if (line.RD3 == 0) lcdr("3");
 PORTB.RB2 = 1;

 delay_ms(100);
 }

 while(1);

}
