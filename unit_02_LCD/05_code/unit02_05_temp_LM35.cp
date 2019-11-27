#line 1 "C:/Users/giljr/Documents/pic/unit_02_LCD/05_code/unit02_05_temp_LM35.c"
#line 88 "C:/Users/giljr/Documents/pic/unit_02_LCD/05_code/unit02_05_temp_LM35.c"
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
unsigned char txt[14];
unsigned int temp;
float mV;




 ADCON1 |= 0X0F;


 Lcd_Init();

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);


 for(;;)
 {
 temp = ADc_Read(2);
 mV = temp * 5000.0/1024.0;
 mV = mV/10.0;
 floatToStr(mV, txt);
 Lcd_cmd(_LCD_CLEAR);
 Lcd_out(1,1,"Temperature");
 Lcd_Out(2,1,Txt);
 Delay_ms(1000);
 }
}
