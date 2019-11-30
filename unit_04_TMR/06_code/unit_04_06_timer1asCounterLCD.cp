#line 1 "C:/Users/giljr/Documents/pic/unit_04_TMR/06_code/unit_04_06_timer1asCounterLCD.c"
#line 66 "C:/Users/giljr/Documents/pic/unit_04_TMR/06_code/unit_04_06_timer1asCounterLCD.c"
void ConfigMCU();
void ConfigTimer();
#line 90 "C:/Users/giljr/Documents/pic/unit_04_TMR/06_code/unit_04_06_timer1asCounterLCD.c"
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


union TwoBytes {
 unsigned char BYTE[2];
 unsigned int INTEGER;
} TWO;

unsigned char txt[10];

void ConfigMCU()
{




 ADCON1 |= 0X0F;

 TRISC.RC0 = 1;
 PORTC.RC0 = 1;
 }

void ConfigTimer()
{



 T1CON = 0B10000010;

 TMR1H = 0;
 TMR1L = 0;

 PIR1.TMR1IF = 0;
 T1CON.TMR1ON = 1;
}

void main() {
 ConfigMCU();
 ConfigTimer();

 Lcd_Init();

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 Lcd_Out(1,1,"Value:");

 while ( 1 )
 {
 TWO.BYTE[1] = TMR1H;
 TWO.BYTE[0] = TMR1L;

 WordToStr(TWO.INTEGER, txt);
 LCD_Out(1, 7, txt);
 Delay_ms(20);

 if(PIR1.TMR1IF == 1)
 {
 TMR1H = 0;
 TMR1L = 0;
 PIR1.TMR1IF = 0;
 }

 }
}
