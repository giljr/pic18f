#line 1 "C:/Users/giljr/Documents/pic/unit_06_CCP/04_code/unit06_04_captureDutyCycle.c"
#line 82 "C:/Users/giljr/Documents/pic/unit_06_CCP/04_code/unit06_04_captureDutyCycle.c"
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
volatile unsigned int t3;
volatile unsigned char _state =  0 ;

static enum State{
 turn1 = 0,
 turn2,
 turn3
}m_state = turn1;

 void INTERRUPTION_HIGH() iv 0x0008 ics ICS_AUTO {
 if(PIR1.CCP1IF)
 {
 switch(m_state) {

 case(turn1):{
 ONE.BYTE[0] = CCPR1L;
 ONE.BYTE[1] = CCPR1H;
 t1 = ONE.INTEGER;
 CCP1CON = 0;
 CCP1CON = 0B00000100;
 m_state = t2;
 break;
 }

 case(turn2):{
 ONE.BYTE[0] = CCPR1L;
 ONE.BYTE[1] = CCPR1H;
 t2 = ONE.INTEGER;
 CCP1CON = 0;
 CCP1CON = 0B00000101;
 m_state = t3;
 break;
 }

 case(turn3):{
 ONE.BYTE[0] = CCPR1L;
 ONE.BYTE[1] = CCPR1H;
 t3 = ONE.INTEGER;
 PIE1.CCP1IE = 0;
 m_state = t1;
 break;
 }
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

 CCP1CON = 0B00000101;

 PIR1.CCP1IF = 0;
 IPR1.CCP1IP = 1;
 PIE1.CCP1IE = 1;

 TRISC.RC2 = 1;


 T1CON = 0B00010011;
 TMR1H = 0;
 TMR1L = 0;
 T1CON.TMR1ON = 1;

}

void main() {
 unsigned int w;
 unsigned int duty;
 unsigned int p = 0;
 unsigned char txt[20];

 configMcu();
 configGlobalInterruption();
 configIndividualVctCAPT();

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"D:");
 Lcd_Out(1,9,"W:");
 Lcd_Out(2,9,"P:");

 while ( 1 )
 {
 if(PIE1.CCP1IE == 0)
 {
 w = t2 - t1;
 p = t3 - t1;
 duty = 100*((float)w/(float)p);

 WordToStr(duty, txt);
 LCD_Out(1,3,txt);


 WordToStr(w, txt);
 LCD_Out(1,11,txt);


 WordToStr(p, txt);
 LCD_Out(2,11,txt);


 Delay_ms(300);
 PIE1.CCP1IE = 1;
 }
 }
}
