
_PWMInit:

;unid_08_01_pwm_4khz_50_.c,51 :: 		void PWMInit()
;unid_08_01_pwm_4khz_50_.c,53 :: 		CCP1CON   = 0B00001100; // PWM Mode
	MOVLW       12
	MOVWF       CCP1CON+0 
;unid_08_01_pwm_4khz_50_.c,56 :: 		CCP1CON.B4  = 0;
	BCF         CCP1CON+0, 4 
;unid_08_01_pwm_4khz_50_.c,57 :: 		CCP1CON.B5  = 1;
	BSF         CCP1CON+0, 5 
;unid_08_01_pwm_4khz_50_.c,58 :: 		CCPR1L = 0B00111110;
	MOVLW       62
	MOVWF       CCPR1L+0 
;unid_08_01_pwm_4khz_50_.c,61 :: 		T2CON     = 0B00000101; // TMR2 0n, prescale 1:4, Datasheet pag 131
	MOVLW       5
	MOVWF       T2CON+0 
;unid_08_01_pwm_4khz_50_.c,62 :: 		PR2       = 124;
	MOVLW       124
	MOVWF       PR2+0 
;unid_08_01_pwm_4khz_50_.c,65 :: 		TRISC.RC2 = 0;
	BCF         TRISC+0, 2 
;unid_08_01_pwm_4khz_50_.c,67 :: 		}
L_end_PWMInit:
	RETURN      0
; end of _PWMInit

_main:

;unid_08_01_pwm_4khz_50_.c,68 :: 		void main() {
;unid_08_01_pwm_4khz_50_.c,69 :: 		PWMInit();
	CALL        _PWMInit+0, 0
;unid_08_01_pwm_4khz_50_.c,71 :: 		while(1); //Lock the program
L_main0:
	GOTO        L_main0
;unid_08_01_pwm_4khz_50_.c,73 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
