#line 1 "C:/Users/giljr/Documents/pic/unid_8_PWM/04_code/unid_08_04_pwm_my_fuctions.c"

void PWMInit(unsigned int Freq);
void PWMduty(unsigned char Duty);
void PWMStart();
void PWMStop();


void PWMduty(unsigned char Duty)
{
 int VarAux = 0;
 VarAux = 1 * 4 * (PR2+1);

 VarAux = (VarAux * (Duty/100.));






 CCP1CON.B4 = ((VarAux & 0x01) == 0x01);
 CCP1CON.B5 = ((VarAux & 0x02) == 0x02);

 VarAux = VarAux >>2;

 CCPR1L = VarAux;




}
#line 42 "C:/Users/giljr/Documents/pic/unid_8_PWM/04_code/unid_08_04_pwm_my_fuctions.c"
void PWMInit(unsigned int Freq)
{
 float Aux, Tosc;
 Tosc = (1./(Clock_kHz()*1000));




 Aux = 1./Freq;
 PR2 = ceil((Aux/(4 * Tosc * 4)) - 1);



 T2CON = 0b00000001;
 CCP1CON = 0b00001100;
}


void PWMStart()
{
 T2CON.TMR2ON = 1;
}


void PWMStop()
{
 T2CON.TMR2ON = 0;
}

void main() {
 unsigned char dc;

 TRISC.RC2 = 0 ;
 PORTC.RC2 = 0 ;

 PWMInit(5000);
 PWMduty(1);
 PWMStart();


 while(1)
 {
 for(dc = 0 ; dc < 100 ; dc++)
 {
 PWMduty(dc);
 Delay_ms(20);
 }

 for(dc = 100 ; dc > 0 ; dc--)
 {
 PWMduty(dc);
 Delay_ms(20);
 }

 }

}
