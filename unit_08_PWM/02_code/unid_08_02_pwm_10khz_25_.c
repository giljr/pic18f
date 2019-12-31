/* PWM Measurements:
  Frequency : 10khz
  + Duty-Cicly: 25%
  - Duty-Cicly: 75%
  Period      : 10us
  ---------------------
  Fosc = 8MHZ

  STEP-BY-STEP PROCEDURE:
1ª STEP-Configure PR2 -> Period
      _________________________________________________________
      (I)Formula: PR2 = Fosc / (4 * Freq_pwm * TMR2_ps) -1
      _________________________________________________________
      logo:    PR2 = ((8000000Hz)/ (4 * 10000Hz * 4) - 1)
               PR2 = 49
      OU_______________________________________________________
      (II)Formula: T_pwm = (PR2 + 1) * 4 * T_osc   * TMR2_ps
      _________________________________________________________
      T_pwm = (49 + 1) * 4 * 0.125us * 4
      T_pwm = 100 -> F_pwm = 1/ T_pwm (X1000) -> F_pwm = 10 KHz

2ª STEP-Configure CCPRxL e CCPxCON<5:4> -> DutyCycle
      _________________________________________________________
      (III)Formula: 10_bits = (%DC_pwm * Fosc) /(100 * TMR2_ps * F_pwm)
      _________________________________________________________
                    10_bits = (25 * 8000000)/(100 * 4 * 10000)
                    10_bits = 50
        IMPORTANT!! Transform in binary:
           0B00110010
                   10 Load-> CCPxCON<5:4> 2 least significant bit (LSB)
     >>2   0B00001100 Load-> CCPRxL       8 Most  significant bit (MSB)
      OU_______________________________________________________
      (IV)Formula:  10_bits = (CCPRxL e CCPxCON<5:4>) / (4 * (PR2 + 1))
      _________________________________________________________
                    10_bits = 50/(4 * (49 + 1))
                    10_bits = 0.25 -> 25%
3ª STEP- What is the Signal width? -> W and T
      _________________________________________________________
      (V)Formula:   T = 50
                    W = 50 * 0.5 = 25
      _________________________________________________________
      OR_______________________________________________________
      (VI)Formula: W = (CCPRxL e CCPxCON<5:4>) * T_osc * TMR2_ps
      ____________________________________________________
                   W = 50 * (1 / 8000000) * 4
                   W = 25
  (In your code, you'll need these registers- please search datasheets ;-)
  CCP1CON   = 0B?? ; // PWM Mode - Datasheet search
  //(CCPRxL e CCPxCON<5:4> = ? -> DUTY-CYCLE CALC
  CCP1CON.B4  = ?;
  CCP1CON.B5  = ?;
  CCPR1L = 0B??;
  //***********************************************

  T2CON     = 0B??; // Datasheet search
  PR2       = ?;

  TRISC.RC2 = 0;// (output)
*/

void PWMInit()
{
  CCP1CON = 0;
  CCP1CON   = 0B00001100; // PWM Mode

  //(CCPRxL e CCPxCON<5:4> = 50 -> DUTY-CYCLE CALC
  CCP1CON.B4  = 0;
  CCP1CON.B5  = 1;
  CCPR1L = 0B00001100;
  //***********************************************

  T2CON     = 0B00000101; // TMR2 0n, prescale 1:4, Datasheet pag 131
  PR2       = 49;

  //Mandatorily as output
  TRISC.RC2 = 0;

}
void main() {
 PWMInit();

 while(1); //Lock the program

}