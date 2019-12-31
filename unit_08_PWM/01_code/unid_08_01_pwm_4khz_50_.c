/* Output PIN RC1 or RB3: PWM 4KHZ - 50 % DutyCycle
   Fosc = 8MHZ
   STEP-BY-STEP PROCEDURE:
1ª STEP-Configure PR2 -> Period
      _________________________________________________________
      (I)Formula: PR2 = Fosc / (4 * Freq_pwm * TMR2_ps) -1
      _________________________________________________________
      logo:    PR2 = ((8000000Hz)/ (4 * 4000Hz * 4) - 1 = 124
               PR2 = 124
      OU_______________________________________________________
      (II)Formula: T_pwm = (PR2 + 1) * 4 * T_osc   * TMR2_ps
      _________________________________________________________
               T_pwm = (124 + 1) * 4 * 0.125us * 4
               T_pwm = 250 -> F_pwm = 1/ T_pwm -> F_pwm = 4 KHz

2ª STEP-Configure CCPRxL e CCPxCON<5:4> -> DutyCycle
      _________________________________________________________
      (III)Formula: 10_bits = (%DC_pwm * Fosc) /(100 * TMR2_ps * F_pwm)
      _________________________________________________________
                    10_bits = (50% * 8000000)/(100 * 4 * 4000)
                    10_bits = 250
        IMPORTANT!! Transform in binary:
           0B11111010
                   10 Load-> CCPxCON<5:4> 2 least significant bit (LSB)
     >>2   0B00111110 Load-> CCPRxL       8 Most  significant bit (MSB)
      OU_______________________________________________________
      (IV)Formula:  10_bits = (CCPRxL e CCPxCON<5:4>) / (4 * (PR2 + 1))
      _________________________________________________________
                    10_bits = 250/(4 * (125 + 1))
                    10_bits = 0.50 -> 50%
3ª STEP- What is the Signal width? -> W and T
      _________________________________________________________
      (V)Formula:   T = 250
                    W = 250 * 0.5 = 125
      _________________________________________________________
      OR_______________________________________________________
      (VI)Formula: W = (CCPRxL e CCPxCON<5:4>) * T_osc * TMR2_ps
      ____________________________________________________
                   W = 250 * (1 / 8000000) * 4     (x1000000)
                   W = 125
  (In your code, you'll need these registers- please search datasheets ;-)
  CCP1CON   = 0B; //SEARCH DATASHEET!
  CCPR1L    = 0B00111110;//  -> 250

  T2CON     = 0B; //SEARCH DATASHEET!
  PR2       = 124;

  TRISC.RC2 = 0;// (output)
*/

void PWMInit()
{
  CCP1CON   = 0B00001100; // PWM Mode

  //(CCPRxL e CCPxCON<5:4> = 250 -> DUTY-CYCLE CALC
  CCP1CON.B4  = 0;
  CCP1CON.B5  = 1;
  CCPR1L = 0B00111110;
  //***********************************************

  T2CON     = 0B00000101; // TMR2 0n, prescale 1:4, Datasheet pag 131
  PR2       = 124;

  //Mandatorily as output
  TRISC.RC2 = 0;

}
void main() {
 PWMInit();

 while(1); //Lock the program

}