#line 1 "C:/Users/giljr/Documents/pic/unit_06_CCP/03_code/unit06_03_captureWidth.c"
#line 80 "C:/Users/giljr/Documents/pic/unit_06_CCP/03_code/unit06_03_captureWidth.c"
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


 void configMCU();
 void configGlobalInterruption();
 void configIndividualVctINT0();

 volatile union TwoBytes{
 unsigned char BYTE[2];
 unsigned int INTEGER;
} ONE;

volatile unsigned int t2;
volatile unsigned int t1;
volatile unsigned char _state =  0 ;



 void INTERRUPTION_HIGH() iv 0x0008 ics ICS_AUTO {
 if(PIR1.CCP1IF == 1)
 {
 if(_state ==  0 )
 {


 ONE.BYTE[0] = CCPR1L;
 ONE.BYTE[1]= CCPR1H;
 t1 = ONE.INTEGER;
 CCP1CON = 0;

 CCP1CON = 0B00000100;
 _state =  1 ;
 }
 else if(_state ==  1 )
 {

 ONE.BYTE[0] = CCPR1L;
 ONE.BYTE[1]= CCPR1H;
 t2 = ONE.INTEGER;
 CCP1CON = 0;

 CCP1CON = 0B00000101;
 _state =  0 ;
 PIE1.CCP1IE = 0;
 }

 PIR1.CCP1IF = 0;
 }
}

void ConfigMCU()
{




 ADCON1 |= 0X0F;

 TRISB =0;
 TRISC.RC2 = 1;
 PORTC.RC2 = 1;
}

void configGlobalInterruption()
{
 INTCON.GIEH = 1;
 INTCON.GIEL = 1;
 RCON.IPEN = 1;
}

void configIndividualVctCAPT()
{
 CCP1CON = 0;

 CCP1CON = 0B00000111;

 PIR1.CCP1IF = 0;
 IPR1.CCP1IP = 1;
 PIE1.CCP1IE = 1;

 TRISC.RC2 = 1;


 T1CON = 0B11010000;
 TMR1H = 0;
 TMR1L = 0;
 T1CON.TMR1ON = 1;

}

void main() {
 unsigned int p = 0;
 unsigned char txt[10];

 configMcu();
 configGlobalInterruption();
 configIndividualVctCAPT();

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, "Period: ");

 while ( 1 )
 {
 if(PIE1.CCP1IE == 0)
 {
 p = t2 - t1;
 WordToStr (p, txt);
 Lcd_Out (1,10, txt);

 Delay_ms(20);
 PIE1.CCP1IE = 1;
 }
 }
}
