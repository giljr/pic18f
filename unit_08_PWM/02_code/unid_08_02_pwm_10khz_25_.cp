#line 1 "C:/Users/giljr/Documents/pic/unid_8_PWM/02_code/unid_08_02_pwm_10khz_25_.c"
#line 61 "C:/Users/giljr/Documents/pic/unid_8_PWM/02_code/unid_08_02_pwm_10khz_25_.c"
void PWMInit()
{
 CCP1CON = 0;
 CCP1CON = 0B00001100;


 CCP1CON.B4 = 0;
 CCP1CON.B5 = 1;
 CCPR1L = 0B00001100;


 T2CON = 0B00000101;
 PR2 = 49;


 TRISC.RC2 = 0;

}
void main() {
 PWMInit();

 while(1);

}
