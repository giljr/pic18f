
_PWMInit:

;unid_08_02_pwm_10khz_25_.c,61 :: 		void PWMInit()
;unid_08_02_pwm_10khz_25_.c,63 :: 		CCP1CON = 0;
	CLRF        CCP1CON+0 
;unid_08_02_pwm_10khz_25_.c,64 :: 		CCP1CON   = 0B00001100; // PWM Mode
	MOVLW       12
	MOVWF       CCP1CON+0 
;unid_08_02_pwm_10khz_25_.c,67 :: 		CCP1CON.B4  = 0;
	BCF         CCP1CON+0, 4 
;unid_08_02_pwm_10khz_25_.c,68 :: 		CCP1CON.B5  = 1;
	BSF         CCP1CON+0, 5 
;unid_08_02_pwm_10khz_25_.c,69 :: 		CCPR1L = 0B00001100;
	MOVLW       12
	MOVWF       CCPR1L+0 
;unid_08_02_pwm_10khz_25_.c,72 :: 		T2CON     = 0B00000101; // TMR2 0n, prescale 1:4, Datasheet pag 131
	MOVLW       5
	MOVWF       T2CON+0 
;unid_08_02_pwm_10khz_25_.c,73 :: 		PR2       = 49;
	MOVLW       49
	MOVWF       PR2+0 
;unid_08_02_pwm_10khz_25_.c,76 :: 		TRISC.RC2 = 0;
	BCF         TRISC+0, 2 
;unid_08_02_pwm_10khz_25_.c,78 :: 		}
L_end_PWMInit:
	RETURN      0
; end of _PWMInit

_main:

;unid_08_02_pwm_10khz_25_.c,79 :: 		void main() {
;unid_08_02_pwm_10khz_25_.c,80 :: 		PWMInit();
	CALL        _PWMInit+0, 0
;unid_08_02_pwm_10khz_25_.c,82 :: 		while(1); //Lock the program
L_main0:
	GOTO        L_main0
;unid_08_02_pwm_10khz_25_.c,84 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
