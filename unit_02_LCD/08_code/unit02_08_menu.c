/* Project: Unit 02 - LCD
      Code: unit_02_08_menu.c

   Objective:   This project explains how to make a two-level menu:)

    LIB Note:   Select on Library Manager the LCD library for mokroC PRO for PIC:)
                > LCD

      Author:   microgenios, edited by J3

   PIC Lessons: How to Start to Program PIC 18 - Step-by-step for Beginners!

   Hardware:    Development Boards (OPTIONS):
                   PicGenios:   PIC18F4520 chip   ( https://loja.microgenios.com.br/produto/kit-picgenios-pic18f4520-com-gravador-usb-microicd-licen-a-compilador-mikroc-pro-for-pic/23507 )
                   EasyPIC™ 7:  PIC18F45K22 chip  ( https://www.microchip.com/Developmenttools/ProductDetails/TMIK013 )
   Software:    Development Programmer/Debugger:
                                PICkit™ 2         ( http://ww1.microchip.com/downloads/en/DeviceDoc/PICkit%202%20v2.61.00%20Setup%20A.zip )
                          mikroProg suite for PIC ( https://www.mikroe.com/blog/mikroprog-suite-for-pic-version-2-3-1-released )
   The LCD is connected to the microcontroller as follows:
                        easyPIC v7 board:                     microgenios board:
                    Microcontroller      LCD               Microcontroller      LCD
                    ===============      ===               ===============      ===
                        RB0              D4                    RB4              D4
                        RB1              D5                    RB5              D5
                        RB2              D6                    RB6              D6
                        RB3              D7                    RB7              D7
                        RB4              E                     RE1              E
                        RB5              R/S                   RE2              R/S
                        GND              RW                    GND              RW

       Date:   Nov 2019
*/
#define TRUE 1
#define SELECT_MENU PORTB.RB0
#define ENTER_MENU PORTB.RB1
#define RETURN_MAIN_MENU PORTB.RB2

//**************************Prototypes******************************************
void CondicaoInicialMenu();
void ConfigMCU();

//**************************Variables********************************************
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

int m_state_level_one = 1;       // Menu's level one. Machine state begins here! level 1
int submenu = 0;                 // Variable that info the menu's level
int m_state_level_two = 1;       // Menu's level two
int state_selected = 1;

//******************************FUNCTION******************************************
// This function is called whenever we want to return Menu's default condition - That is: level one
void ReturnToDefaultMenu()
{
  m_state_level_one = 1;
  submenu = 0;                   //force condition to default menu - Level one
  m_state_level_two = 1;
  state_selected = 1;

                                 // Returns LCD's text - level one
  Lcd_Cmd(_LCD_CLEAR);           // Delete all text and subscribe default text
  Lcd_Out(1, 1,">OPTION1 [ENTER]");
  Lcd_Out(2, 1," OPTION2        ");
}
  
                                 // Configure MCU-IO's pins initial conditions .
void ConfigMCU()
{
#ifdef P18F45K22
  ANSELB = 0;
  ANSELD = 0;
#else
  ADCON1 |= 0X0F;
#endif
  TRISB.RB0 = 1; PORTB.RB0 = 1;  //SELETION
  TRISB.RB1 = 1; PORTB.RB1 = 1;  //ENTER
  TRISB.RB2 = 1; PORTB.RB2 = 1;  //RETURN
}

void main()
{
  ConfigMCU();

  Lcd_Init();                    // Initialize LCD's display
  Lcd_Cmd(_LCD_CLEAR);           // Delete display
  Lcd_Cmd(_LCD_CURSOR_OFF);      // Cursor off

                                 // Initial LCD Display's messages
  Lcd_Out(1, 1,">OPTION1 [ENTER]");
  Lcd_Out(2, 1," OPTION2        ");

  while (TRUE)
        {
                                 // This is the MENU's first level
                                 // Note that this is a state machine pattern.
                                 // Each case the state variable is changed

        if (SELECT_MENU == 0 && submenu == 0)
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

                                 // Here, the operator pressed ENTER key. If we know the value 0f
                                 // state_selected  we will know which sunmenu chose
        if (ENTER_MENU == 0)
          {
             switch(state_selected)
                {
                case 1:
                   Lcd_Cmd(_LCD_CLEAR);
                   Lcd_Out(1, 1," OPTION1");
                   Lcd_Out(1,9,">SENSOR1");
                   Lcd_Out(2,9," EQUIP1");
                   submenu = 1;  // Informa que estamos no segundo nível do menu
                break;
                case 2:
                   Lcd_Cmd(_LCD_CLEAR);
                   Lcd_Out(1, 1," OPTION2");
                   Lcd_Out(1,9,">SENSOR2");
                   Lcd_Out(2,9," EQUIP2");
                   submenu = 1;  // again
                break;
                }
             }

                                 // This routine for manipulation of the MENU's second level
                                 // Note that only in the second level, this if is true
        if (SELECT_MENU == 0 && submenu == 1)
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

                                 // This routine return to the default MENU
        if (RETURN_MAIN_MENU == 0 && submenu == 1)
             {
               ReturnToDefaultMenu();
             }

        Delay_ms(250);           // needed to treat debounce here!

         }

}