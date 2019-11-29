#line 1 "C:/Users/giljr/Documents/pic/unit_03_ADC/03_code/unit03_03_formatNumbers.c"
#line 92 "C:/Users/giljr/Documents/pic/unit_03_ADC/03_code/unit03_03_formatNumbers.c"
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
 unsigned int read_ADC;
 unsigned char txt[10];

 ConfigMCU();

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"S1:");
 Lcd_Out(2,1,"S2:");

 ADC_Init();

 while( 1 )
 {

 read_ADC = ADC_Read(0);

 read_ADC = (int)read_ADC * (100./1023.);
 WordToStr(read_ADC, txt);
 LCD_Out(1,4, txt);
 LCD_Chr_Cp('%');
 Delay_ms(20);


 read_ADC = ADC_Read(1);

 read_ADC = (int)read_ADC * (255./1023.);
 WordToStr(read_ADC, txt);
 LCD_Out(2,4, txt);
 Delay_ms(20);
 }
}
