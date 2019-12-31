
_PWMduty:

;unid_08_04_pwm_my_fuctions.c,8 :: 		void PWMduty(unsigned char Duty)
;unid_08_04_pwm_my_fuctions.c,10 :: 		int VarAux = 0;
;unid_08_04_pwm_my_fuctions.c,11 :: 		VarAux = 1 * 4 * (PR2+1);              //Com base no PR2 já carregado, encontra valor máximo de contagem
	MOVF        PR2+0, 0 
	ADDLW       1
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	ADDWFC      R2, 1 
	MOVF        R1, 0 
	MOVWF       FLOC__PWMduty+4 
	MOVF        R2, 0 
	MOVWF       FLOC__PWMduty+5 
	RLCF        FLOC__PWMduty+4, 1 
	BCF         FLOC__PWMduty+4, 0 
	RLCF        FLOC__PWMduty+5, 1 
	RLCF        FLOC__PWMduty+4, 1 
	BCF         FLOC__PWMduty+4, 0 
	RLCF        FLOC__PWMduty+5, 1 
;unid_08_04_pwm_my_fuctions.c,13 :: 		VarAux =  (VarAux * (Duty/100.));      //Regra de 3x simples, no qual converte o valor máximo encontrado
	MOVF        FARG_PWMduty_Duty+0, 0 
	MOVWF       R0 
	CALL        _byte2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__PWMduty+0 
	MOVF        R1, 0 
	MOVWF       FLOC__PWMduty+1 
	MOVF        R2, 0 
	MOVWF       FLOC__PWMduty+2 
	MOVF        R3, 0 
	MOVWF       FLOC__PWMduty+3 
	MOVF        FLOC__PWMduty+4, 0 
	MOVWF       R0 
	MOVF        FLOC__PWMduty+5, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        FLOC__PWMduty+0, 0 
	MOVWF       R4 
	MOVF        FLOC__PWMduty+1, 0 
	MOVWF       R5 
	MOVF        FLOC__PWMduty+2, 0 
	MOVWF       R6 
	MOVF        FLOC__PWMduty+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2int+0, 0
;unid_08_04_pwm_my_fuctions.c,20 :: 		CCP1CON.B4 = ((VarAux & 0x01) == 0x01); //Mascara para setar/Resetar somente CCP1CON.B4
	MOVLW       1
	ANDWF       R0, 0 
	MOVWF       R3 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVLW       0
	ANDWF       R4, 1 
	MOVLW       0
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__PWMduty11
	MOVLW       1
	XORWF       R3, 0 
L__PWMduty11:
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R2 
	BTFSC       R2, 0 
	GOTO        L__PWMduty12
	BCF         CCP1CON+0, 4 
	GOTO        L__PWMduty13
L__PWMduty12:
	BSF         CCP1CON+0, 4 
L__PWMduty13:
;unid_08_04_pwm_my_fuctions.c,21 :: 		CCP1CON.B5 = ((VarAux & 0x02) == 0x02); //idem para B5
	MOVLW       2
	ANDWF       R0, 0 
	MOVWF       R3 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVLW       0
	ANDWF       R4, 1 
	MOVLW       0
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__PWMduty14
	MOVLW       2
	XORWF       R3, 0 
L__PWMduty14:
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R2 
	BTFSC       R2, 0 
	GOTO        L__PWMduty15
	BCF         CCP1CON+0, 5 
	GOTO        L__PWMduty16
L__PWMduty15:
	BSF         CCP1CON+0, 5 
L__PWMduty16:
;unid_08_04_pwm_my_fuctions.c,23 :: 		VarAux = VarAux >>2;  //Desloca para a direita o valor do Duty para carregar em CCPR1L
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
;unid_08_04_pwm_my_fuctions.c,25 :: 		CCPR1L = VarAux;      //Salva Duty em CCPR1L
	MOVF        R2, 0 
	MOVWF       CCPR1L+0 
;unid_08_04_pwm_my_fuctions.c,30 :: 		}
L_end_PWMduty:
	RETURN      0
; end of _PWMduty

_PWMInit:

;unid_08_04_pwm_my_fuctions.c,42 :: 		void PWMInit(unsigned int Freq)
;unid_08_04_pwm_my_fuctions.c,50 :: 		Aux = 1./Freq;                        //Encontra o período com base na frequência carregada no parâmentro
	MOVF        FARG_PWMInit_Freq+0, 0 
	MOVWF       R0 
	MOVF        FARG_PWMInit_Freq+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       127
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
;unid_08_04_pwm_my_fuctions.c,51 :: 		PR2 = ceil((Aux/(4 * Tosc * 4)) - 1); //Encontra o valor de PR2.
	MOVLW       57
	MOVWF       R4 
	MOVLW       142
	MOVWF       R5 
	MOVLW       99
	MOVWF       R6 
	MOVLW       118
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ceil_x+0 
	MOVF        R1, 0 
	MOVWF       FARG_ceil_x+1 
	MOVF        R2, 0 
	MOVWF       FARG_ceil_x+2 
	MOVF        R3, 0 
	MOVWF       FARG_ceil_x+3 
	CALL        _ceil+0, 0
	CALL        _double2byte+0, 0
	MOVF        R0, 0 
	MOVWF       PR2+0 
;unid_08_04_pwm_my_fuctions.c,55 :: 		T2CON = 0b00000001;                   //Desliga TIMER2 e carrega prescaler 1:4
	MOVLW       1
	MOVWF       T2CON+0 
;unid_08_04_pwm_my_fuctions.c,56 :: 		CCP1CON = 0b00001100;                 //Configura CCP no modo PWM. Apartir desse momento o PWM já está ligado.
	MOVLW       12
	MOVWF       CCP1CON+0 
;unid_08_04_pwm_my_fuctions.c,57 :: 		}
L_end_PWMInit:
	RETURN      0
; end of _PWMInit

_PWMStart:

;unid_08_04_pwm_my_fuctions.c,60 :: 		void PWMStart()
;unid_08_04_pwm_my_fuctions.c,62 :: 		T2CON.TMR2ON = 1;  //Liga TIMER e inicia a PWM
	BSF         T2CON+0, 2 
;unid_08_04_pwm_my_fuctions.c,63 :: 		}
L_end_PWMStart:
	RETURN      0
; end of _PWMStart

_PWMStop:

;unid_08_04_pwm_my_fuctions.c,66 :: 		void PWMStop()
;unid_08_04_pwm_my_fuctions.c,68 :: 		T2CON.TMR2ON = 0;  //desliga TIMER e inicia a P
	BCF         T2CON+0, 2 
;unid_08_04_pwm_my_fuctions.c,69 :: 		}
L_end_PWMStop:
	RETURN      0
; end of _PWMStop

_main:

;unid_08_04_pwm_my_fuctions.c,71 :: 		void main() {
;unid_08_04_pwm_my_fuctions.c,74 :: 		TRISC.RC2 = 0 ;    //Configura pino CCP1/RC2 como saida
	BCF         TRISC+0, 2 
;unid_08_04_pwm_my_fuctions.c,75 :: 		PORTC.RC2 = 0 ;
	BCF         PORTC+0, 2 
;unid_08_04_pwm_my_fuctions.c,77 :: 		PWMInit(5000);     //Inicia PWM a 5KHz - unidade Hz
	MOVLW       136
	MOVWF       FARG_PWMInit_Freq+0 
	MOVLW       19
	MOVWF       FARG_PWMInit_Freq+1 
	CALL        _PWMInit+0, 0
;unid_08_04_pwm_my_fuctions.c,78 :: 		PWMduty(1);       //% Duty Cycle -variar de 0% a 100%
	MOVLW       1
	MOVWF       FARG_PWMduty_Duty+0 
	CALL        _PWMduty+0, 0
;unid_08_04_pwm_my_fuctions.c,79 :: 		PWMStart();        //Start PWM
	CALL        _PWMStart+0, 0
;unid_08_04_pwm_my_fuctions.c,82 :: 		while(1)
L_main0:
;unid_08_04_pwm_my_fuctions.c,84 :: 		for(dc = 0 ; dc < 100 ; dc++)
	CLRF        main_dc_L0+0 
L_main2:
	MOVLW       100
	SUBWF       main_dc_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
;unid_08_04_pwm_my_fuctions.c,86 :: 		PWMduty(dc);     //Altera Duty Cycle do 0% ao 100%
	MOVF        main_dc_L0+0, 0 
	MOVWF       FARG_PWMduty_Duty+0 
	CALL        _PWMduty+0, 0
;unid_08_04_pwm_my_fuctions.c,87 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	NOP
	NOP
;unid_08_04_pwm_my_fuctions.c,84 :: 		for(dc = 0 ; dc < 100 ; dc++)
	INCF        main_dc_L0+0, 1 
;unid_08_04_pwm_my_fuctions.c,88 :: 		}
	GOTO        L_main2
L_main3:
;unid_08_04_pwm_my_fuctions.c,90 :: 		for(dc = 100 ; dc > 0 ; dc--)
	MOVLW       100
	MOVWF       main_dc_L0+0 
L_main6:
	MOVF        main_dc_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main7
;unid_08_04_pwm_my_fuctions.c,92 :: 		PWMduty(dc);
	MOVF        main_dc_L0+0, 0 
	MOVWF       FARG_PWMduty_Duty+0 
	CALL        _PWMduty+0, 0
;unid_08_04_pwm_my_fuctions.c,93 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main9:
	DECFSZ      R13, 1, 1
	BRA         L_main9
	DECFSZ      R12, 1, 1
	BRA         L_main9
	NOP
	NOP
;unid_08_04_pwm_my_fuctions.c,90 :: 		for(dc = 100 ; dc > 0 ; dc--)
	DECF        main_dc_L0+0, 1 
;unid_08_04_pwm_my_fuctions.c,94 :: 		}
	GOTO        L_main6
L_main7:
;unid_08_04_pwm_my_fuctions.c,96 :: 		}
	GOTO        L_main0
;unid_08_04_pwm_my_fuctions.c,98 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
