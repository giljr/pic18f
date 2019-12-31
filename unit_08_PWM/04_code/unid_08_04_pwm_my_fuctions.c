//Protótipos
void PWMInit(unsigned int Freq);
void PWMduty(unsigned char Duty);
void PWMStart();
void PWMStop();


void PWMduty(unsigned char Duty)
{
   int VarAux = 0;
   VarAux = 1 * 4 * (PR2+1);              //Com base no PR2 já carregado, encontra valor máximo de contagem
                                          //de TMR2, o que afeta diretamente na contagem do duty cycle
   VarAux =  (VarAux * (Duty/100.));      //Regra de 3x simples, no qual converte o valor máximo encontrado
                                          //em 0 a 100%
                                          //Ex: Se o parâmetro da função Duty = 92
                                          //VarAux =  (VarAux * (92/100.));
                                          //VarAux passa a ser igual a 92% de seu valor original, ou seja
                                          //Duty agora é de 92% do seu máximo valor
   //Carrega os dois LSB encontrado em VarAux nos bits CCP1CON<5:4>
   CCP1CON.B4 = ((VarAux & 0x01) == 0x01); //Mascara para setar/Resetar somente CCP1CON.B4
   CCP1CON.B5 = ((VarAux & 0x02) == 0x02); //idem para B5

   VarAux = VarAux >>2;  //Desloca para a direita o valor do Duty para carregar em CCPR1L
                         //pois já carregamos os LSBs nas duas linhas acima.
   CCPR1L = VarAux;      //Salva Duty em CCPR1L
   //VarAux = 0b0000111011
   //CCP1CON<5:4> = 11
   //VarAux = 0b0000111011 >> 2  =0b0000001110
   //CCPR1L = 0B00001110;
}



//Esta função calcula o Período do PWM com base na Freq enviado como parâmetro
// Cristal usado: Fosc = 8MHz
//
//1° Etapa: Cálculo do Período
//Fórmula:
//PR2 = ( ((Fosc)/(4 * FPWM * PRESCALER)) -1)
//PR2 = (8.000.000Hz / (4 * 5.000Hz * 4) ) - 1
//PR2 = 99
void PWMInit(unsigned int Freq)
{
  float Aux, Tosc;
  Tosc = (1./(Clock_kHz()*1000));       //Equivale a: 1./8000Hz*1000
                                        //Clock_KHz é uma função inline do compilador mikroC
                                        //no qual informa o valor do oscilador Fosc configurado no painel
                                        //edit Project

  Aux = 1./Freq;                        //Encontra o período com base na frequência carregada no parâmentro
  PR2 = ceil((Aux/(4 * Tosc * 4)) - 1); //Encontra o valor de PR2.
                                        //A função ceil arredonda o resultado.
                                        //tomar cuidado que o resultado deverá estar entre 0 a 255

  T2CON = 0b00000001;                   //Desliga TIMER2 e carrega prescaler 1:4
  CCP1CON = 0b00001100;                 //Configura CCP no modo PWM. Apartir desse momento o PWM já está ligado.
}

//Start na geração do sinal PWM em CCP1
void PWMStart()
{
  T2CON.TMR2ON = 1;  //Liga TIMER e inicia a PWM
}

//Stop na geração do sinal PWM em CCP1
void PWMStop()
{
  T2CON.TMR2ON = 0;  //desliga TIMER e inicia a P
}

void main() {
  unsigned char dc;

  TRISC.RC2 = 0 ;    //Configura pino CCP1/RC2 como saida
  PORTC.RC2 = 0 ;

  PWMInit(5000);     //Inicia PWM a 5KHz - unidade Hz
  PWMduty(1);       //% Duty Cycle -variar de 0% a 100%
  PWMStart();        //Start PWM
  //PWMStop();       //Stop PWM

  while(1)
   {
      for(dc = 0 ; dc < 100 ; dc++)
              {
              PWMduty(dc);     //Altera Duty Cycle do 0% ao 100%
              Delay_ms(20);
              }

      for(dc = 100 ; dc > 0 ; dc--)
              {
              PWMduty(dc);
              Delay_ms(20);
              }

   }

}