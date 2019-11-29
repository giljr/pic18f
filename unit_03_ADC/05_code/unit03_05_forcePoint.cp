#line 1 "C:/Users/giljr/Documents/pic/unit_03_ADC/05_code/unit03_05_forcePoint.c"
#line 55 "C:/Users/giljr/Documents/pic/unit_03_ADC/05_code/unit03_05_forcePoint.c"
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
 unsigned int Valor_ADC = 0;
 unsigned char Tensao[10];






 TRISA.RA0 = 1;
 ADCON1 = 0B00001101;


 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"ADC1:");

 ADC_Init();

 while( 1 )
 {
 Valor_ADC = ADC_Read(1);
 Valor_ADC = Valor_ADC * (1023/1023.);
 Tensao[0] = (Valor_ADC/1000) + '0';
 Tensao[1] = (Valor_ADC/100)%10 + '0';
 Tensao[2] = '.';
 Tensao[3] = (Valor_ADC/10)%10 + '0';
 Tensao[4] = (Valor_ADC/1)%10 + '0';
 Tensao[5] = 0;
 Lcd_Out(1,6,Tensao);
 }
}
