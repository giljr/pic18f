#line 1 "C:/Users/giljr/Documents/pic/unid_8_PWM/03_code/unid_08_03_pwm_AN1_LCD.c"
#line 16 "C:/Users/giljr/Documents/pic/unid_8_PWM/03_code/unid_08_03_pwm_AN1_LCD.c"
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


void ConfigMCU ()
{




 ADCON1 = 0B00001110;

TRISA.RA0 = 1;
PORTA.RA0 = 1;
}



void main() {
unsigned int Leitura_ADC;
unsigned char txtDta[10];

 ConfigMcu();

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, "ADC:");


 PWM1_Init(5000);
 PWM1_Set_Duty(255);
 PWM1_Start();

 while ( 1 )
 {

 Leitura_ADC = (int) ADC_Read(1) * (255./1023.);
 PWM1_Set_Duty(Leitura_ADC);

 WordToStr(Leitura_ADC, txtDta);
 Lcd_Out(1, 5, txtDta);
 Delay_ms(20);
 }


}
