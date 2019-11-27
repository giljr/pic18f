#line 1 "C:/Users/giljr/Documents/pic/unit_02_LCD/08_code/unit02_08_menu.c"
#line 39 "C:/Users/giljr/Documents/pic/unit_02_LCD/08_code/unit02_08_menu.c"
void CondicaoInicialMenu();
void ConfigMCU();


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

int m_state_level_one = 1;
int submenu = 0;
int m_state_level_two = 1;
int state_selected = 1;



void ReturnToDefaultMenu()
{
 m_state_level_one = 1;
 submenu = 0;
 m_state_level_two = 1;
 state_selected = 1;


 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1,">OPTION1 [ENTER]");
 Lcd_Out(2, 1," OPTION2        ");
}


void ConfigMCU()
{




 ADCON1 |= 0X0F;

 TRISB.RB0 = 1; PORTB.RB0 = 1;
 TRISB.RB1 = 1; PORTB.RB1 = 1;
 TRISB.RB2 = 1; PORTB.RB2 = 1;
}

void main()
{
 ConfigMCU();

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);


 Lcd_Out(1, 1,">OPTION1 [ENTER]");
 Lcd_Out(2, 1," OPTION2        ");

 while ( 1 )
 {




 if ( PORTB.RB0  == 0 && submenu == 0)
 {
 switch(m_state_level_one)
 {
 case 1:
 Lcd_Chr(1,1,'>'); LCD_Out(1,9," [ENTER]");
 m_state_level_one = 2;
 state_selected = 1;
 Lcd_Chr(2,1,' '); LCD_Out(2,9,"        ");
 break;
 case 2:
 Lcd_Chr(2,1,'>'); LCD_Out(2,9," [ENTER]");
 m_state_level_one = 1;
 state_selected = 2;
 Lcd_Chr(1,1,' '); LCD_Out(1,9,"                ");
 break;
 }
 }



 if ( PORTB.RB1  == 0)
 {
 switch(state_selected)
 {
 case 1:
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1," OPTION1");
 Lcd_Out(1,9,">SENSOR1");
 Lcd_Out(2,9," EQUIP1");
 submenu = 1;
 break;
 case 2:
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1," OPTION2");
 Lcd_Out(1,9,">SENSOR2");
 Lcd_Out(2,9," EQUIP2");
 submenu = 1;
 break;
 }
 }



 if ( PORTB.RB0  == 0 && submenu == 1)
 {
 switch(m_state_level_two)
 {
 case 1:
 Lcd_Chr(1,9,'>');
 m_state_level_two = 2;
 Lcd_Chr(2,9,' ');
 break;
 case 2:
 Lcd_Chr(2,9,'>');
 m_state_level_two = 1;
 Lcd_Chr(1,9,' ');
 break;
 }
 }


 if ( PORTB.RB2  == 0 && submenu == 1)
 {
 ReturnToDefaultMenu();
 }

 Delay_ms(250);

 }

}
