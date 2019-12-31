/*
  PWM AND TRIMPOT (for motor on RC1)
  CANAL ANALÓGICO - AN0
  PWM Output RC1 ou RB3 (see CCP MUX Bit on Project > Edit Project)
  video aula 07 - Unidade 08 CCP - PWM  jul,2017
  enable PWM, LCD, ADC and CONVERSIONS libs @ Library Manager's mikroC PRO sw
*/

 /* Variáveis Globais */
#define TRUE 1


// DEfinição bit-a-bit - Relacionada à PORT (dados)
//para picMicrogenios

sbit LCD_RS at LATE2_bit;
sbit LCD_EN at LATE1_bit;
sbit LCD_D4 at LATD4_bit;
sbit LCD_D5 at LATD5_bit;
sbit LCD_D6 at LATD6_bit;
sbit LCD_D7 at LATD7_bit;

//para picMicrogenios
sbit LCD_RS_Direction at TRISE2_bit;
sbit LCD_EN_Direction at TRISE1_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;
// End LCD module connections


/* Prototipo de Função */
void ConfigMCU();

/* Configuração para o chip 18F4520 e 45k22 */
void ConfigMCU ()
{
#ifdef P18F45K22
  ANSELB = 0;
  ANSELA.B0 = 1;
#else
   ADCON1 = 0B00001110;// somente pino RA0/AN0 analogico, os outros digitais
#endif
TRISA.RA0 = 1;
PORTA.RA0 = 1; //entrada AN0
}


/* Programa Principal */
void main() {
unsigned int Leitura_ADC;
unsigned char txtDta[10];

  ConfigMcu();

  Lcd_Init(); //sempre chamado para inicializar LCD, 4-bit Mode
  Lcd_Cmd(_LCD_CLEAR); //desliga cursor
  Lcd_Cmd(_LCD_CURSOR_OFF);//desliga cursor
  Lcd_Out(1, 1, "ADC:");  //linha x Coluna

  //basta 3 linhas para não sofrer tanto, como antes
  PWM1_Init(5000);
  PWM1_Set_Duty(255); // 0(%) -> 255(100%)
  PWM1_Start(); // start pwm ; temos mais de um canal ccp , escolha 1 ou 2...

  while (TRUE)
  {
     //Leitura_ADC = ADC_Read(1); //le o vlr trimpot no RA0
     Leitura_ADC = (int) ADC_Read(1) * (255./1023.); //regra de 3 simples
     PWM1_Set_Duty(Leitura_ADC);// faça leitura 3 simples

     WordToStr(Leitura_ADC, txtDta);
     Lcd_Out(1, 5, txtDta);
     Delay_ms(20);
  }


}