#line 1 "C:/Users/giljr/Documents/pic/unid_8_PWM/01_code/unid_08_01_pwm_4khz_50_.c"
#line 51 "C:/Users/giljr/Documents/pic/unid_8_PWM/01_code/unid_08_01_pwm_4khz_50_.c"
void PWMInit()
{
 CCP1CON = 0B00001100;


 CCP1CON.B4 = 0;
 CCP1CON.B5 = 1;
 CCPR1L = 0B00111110;


 T2CON = 0B00000101;
 PR2 = 124;


 TRISC.RC2 = 0;

}
void main() {
 PWMInit();

 while(1);

}
