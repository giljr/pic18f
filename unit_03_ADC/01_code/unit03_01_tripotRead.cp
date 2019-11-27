#line 1 "C:/Users/giljr/Documents/pic/unit_03_ADC/01_code/unit03_01_tripotRead.c"
#line 85 "C:/Users/giljr/Documents/pic/unit_03_ADC/01_code/unit03_01_tripotRead.c"
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



void main() {
 unsigned int ADC_read;
 unsigned char txt[10];
#line 113 "C:/Users/giljr/Documents/pic/unit_03_ADC/01_code/unit03_01_tripotRead.c"
 PORTA.RA0 = 1;
 TRISA.RA0 = 1;

 ADCON0 = 0B00000001;
 ADCON1 = 0B00001110;
 ADCON2 = 0B10101010;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, "ADC: ");

 while ( 1 )
 {
 ADCON0.GO_DONE = 1;

 while(ADCON0.GO_DONE == 1);
 ADC_read = ((ADRESH << 8)| (int)ADRESL);
 WordToStr(ADC_read, txt);
 LCD_Out(1, 8, txt);
 Delay_ms(20);
 }

}
