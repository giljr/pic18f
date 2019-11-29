#line 1 "C:/Users/giljr/Documents/pic/unit_03_ADC/02_code/unit03_02_ChooseChannel.c"
#line 95 "C:/Users/giljr/Documents/pic/unit_03_ADC/02_code/unit03_02_ChooseChannel.c"
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


unsigned int ADCRead(unsigned char channel)
{
switch(channel)
 {

 case 0: {

 TRISA.RA0 = 1;
 PORTA.RA0 = 1;

 ADCON0 = 0B00000001;
 ADCON1 = 0B00001110;



 break;
 }

 case 1: {

 TRISA.RA1 = 1;
 PORTA.RA1 = 1;

 ADCON0 = 0B00000101;

 ADCON1 = 0B00001101;






 break;
 }

 }
 ADCON2 = 0B10101010;
 delay_us(40);

 ADCON0.GO_DONE = 1;

 while(ADCON0.GO_DONE == 1);
 return ((ADRESH << 8) | (int)ADRESL);
}

void main() {
 unsigned int Reading_ADC;
 unsigned char txt[10];
#line 162 "C:/Users/giljr/Documents/pic/unit_03_ADC/02_code/unit03_02_ChooseChannel.c"
 TRISA.RA0 = 1;
 PORTA.RA0 = 1;

 ADCON0 = 0B00000001;
 ADCON1 = 0B00001110;

 ADCON2 = 0B10101010;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, "ADC: ");


 while( 1 )
 {
 Reading_ADC = ADCRead(1);
 WordToStr(Reading_ADC, txt);
 LCD_Out (1,1, txt);
 Delay_ms(20);
 }
}
