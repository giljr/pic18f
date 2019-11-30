#line 1 "C:/Users/giljr/Documents/pic/unit_05_INT/03_code/unit05_03_adcInterruption.c"
#line 93 "C:/Users/giljr/Documents/pic/unit_05_INT/03_code/unit05_03_adcInterruption.c"
void configMCU();
void configADC1();
void configGlobalInterruption();
void configIndividualVctADC();
#line 116 "C:/Users/giljr/Documents/pic/unit_05_INT/03_code/unit05_03_adcInterruption.c"
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

union TwoBytes{
 unsigned char BYTE[2];
 unsigned int INTEGER;
}TWO;




unsigned char txt[10];


volatile unsigned int BufferADC[ 20 ];
volatile unsigned long int averageResult = 0;
volatile char StatusADC = 0;

void INTERRUPTION_ADC_HIGH() iv 0x0008 ics ICS_AUTO {
 volatile static char _i = 0;

 if (PIR1.ADIF == 1 && PIE1.ADIE == 1)
 {
 PIR1.ADIF = 0;
 TWO.BYTE[0] = ADRESL;
 TWO.BYTE[1] = ADRESH;
 if(_i <  20 ){
 BufferADC[_i] = TWO.INTEGER;
 ++_i;


 }
 else {

 PIE1.ADIE = 0;

 averageResult = 0 ;
 for(_i = 0; _i <  20 ; ++ _i)
 {
 averageResult += BufferADC[_i];
 }
 averageResult /=  20 ;
 _i = 0;
 }
 }
}


void configGlobalInterruption()
{
 INTCON.GIEH = 1;
 INTCON.GIEL = 1;
 RCON.IPEN = 1;
}


void configIndividualVctADC()
{
 PIR1.ADIF = 0;
 IPR1.ADIP = 1;
 PIE1.ADIE = 1;


}
 void configMCU()
 {






 ADCON1 |= 0B00001110;


 TRISA.RA0 = 1;
 PORTA.RA0 = 1;

 TRISD = 0;
 PORTD = 0;
}
void configADC1()
{
 ADCON0 = 0B00000101;
 ADCON1 = 0B00001110;

 ADCON2 = 0B10101010;
}

void main() {
 configMCU();
 configADC1();
 configGlobalInterruption();
 configIndividualVctADC();

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, "ADC: ");

 while( 1 )
 {
 ADCON0.GO_DONE = 1;


 if(PIE1.ADIE == 0) {
 wordToStr((int)averageResult, txt);
 LCD_Out (1,5, txt);
 Delay_ms(20);

 PIE1.ADIE = 1;



 }
 }
}
