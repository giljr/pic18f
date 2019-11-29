#line 1 "C:/Users/giljr/Documents/pic/unit_03_ADC/04_code/unit03_04_voltimeter.c"
#line 91 "C:/Users/giljr/Documents/pic/unit_03_ADC/04_code/unit03_04_voltimeter.c"
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


void ConfigMCU();

void ConfigMCU()
{





 ADCON1 |= 0B00001101;


 TRISA.RA0 = 1;
 PORTA.RA0 = 1;

 TRISA.RA1 = 1;
 PORTA.RA1 = 1;

}
void main(){
 unsigned long Vin, mV;
 unsigned char txt[12];
 char *str;

 ConfigMCU();

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"Voltimeter v1");
 Delay_ms(2000);

 ADC_Init();

 while( 1 )
 {
 Lcd_Cmd(_LCD_CLEAR);

 Vin = ADC_Read(1);


 Lcd_Out(1,1,"mV = ");
 mV = (Vin * 5000) >> 10;
 LongToStr(mV,txt);
 str = Ltrim(txt);


 Lcd_Out(1,6,str);
 Delay_ms(1000);
 }
}
