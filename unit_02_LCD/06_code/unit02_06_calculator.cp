#line 1 "C:/Users/giljr/Documents/pic/unit_02_LCD/06_code/unit02_06_calculator.c"
#line 76 "C:/Users/giljr/Documents/pic/unit_02_LCD/06_code/unit02_06_calculator.c"
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



unsigned char getkeypad()
{
 unsigned char i, Key = 0;
 PORTC = 0x01;

 while((PORTC &  0xF0 ) == 0)
 {
 PORTC = (PORTC << 1);
 Key++;
 if(Key == 4)
 {
 PORTC = 0x01;
 Key = 0;
 }
 }
 Delay_Ms(20);
 for(i = 0x10; i !=0; i <<=1)
 { if((PORTC & i) != 0)break; Key = Key + 4; }
 PORTC = 0x0F;
 while((PORTC &  0xF0 ) != 0);
 Delay_Ms(20);
 return (Key);
 }

void main(){
 unsigned char MyKey, i,j,op[12];
 unsigned long Calc, Op1, Op2;
 char *lcd;





 ADCON1 |= 0X0F;


 PORTE = 0;
 TRISE = 0;

 PORTD = 0;
 TRISD = 0XF0;

 Lcd_Init();

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 Lcd_Out(1,1,"CALCULATOR");


 for(;;)
 {
 MyKey = 0;
 Op1 = 0;
 Op2 = 0;

 Lcd_Out(1,1,"No1: ");

 while(1)
 {
 MyKey = getkeypad();
 if(MyKey ==  11 )break;
 MyKey++;
 if(MyKey == 10)MyKey = 0;
 Lcd_Chr_Cp(MyKey + '0');
 Op1 = 10 * Op1 + MyKey;
 }

 Lcd_Out(2,1,"No2: ");

 while(1)
 {
 MyKey = getkeypad();
 if(MyKey ==  11 )break;
 MyKey++;
 if(MyKey == 10)MyKey = 0;
 Lcd_Chr_Cp(MyKey + '0');
 Op2 = 10 * Op1 + MyKey;
 }
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Op: ");
 MyKey = getkeypad();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Res=");

 switch(MyKey)
 {
 case  12 :
 Calc = Op1 + Op2;
 break;
 case  13 :
 Calc = Op1 - Op2;
 break;
 case  14 :
 Calc = Op1 * Op2;
 break;
 case  15 :
 Calc = Op1/Op2;
 break;
 }

 LongToStr(Calc, op);
 lcd = Ltrim(op);
 Lcd_Out_Cp(lcd);
 Delay_ms(5000);
 Lcd_Cmd(_LCD_CLEAR);
 }

}
