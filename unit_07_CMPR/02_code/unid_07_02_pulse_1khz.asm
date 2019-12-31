
_INTERRUPCAO_COMPARE_HIGH:

;unid_07_02_pulse_1khz.c,29 :: 		void INTERRUPCAO_COMPARE_HIGH() iv 0x0008 ics ICS_AUTO {
;unid_07_02_pulse_1khz.c,31 :: 		if(CCP1IF_bit == 1 && CCP1IE_bit == 1)
	BTFSS       CCP1IF_bit+0, BitPos(CCP1IF_bit+0) 
	GOTO        L_INTERRUPCAO_COMPARE_HIGH2
	BTFSS       CCP1IE_bit+0, BitPos(CCP1IE_bit+0) 
	GOTO        L_INTERRUPCAO_COMPARE_HIGH2
L__INTERRUPCAO_COMPARE_HIGH5:
;unid_07_02_pulse_1khz.c,33 :: 		TMR1H = 0;
	CLRF        TMR1H+0 
;unid_07_02_pulse_1khz.c,34 :: 		TMR1L = 0;
	CLRF        TMR1L+0 
;unid_07_02_pulse_1khz.c,35 :: 		CCP1IF_bit = 0;                // Clean flag for comparator
	BCF         CCP1IF_bit+0, BitPos(CCP1IF_bit+0) 
;unid_07_02_pulse_1khz.c,39 :: 		}
L_INTERRUPCAO_COMPARE_HIGH2:
;unid_07_02_pulse_1khz.c,40 :: 		}
L_end_INTERRUPCAO_COMPARE_HIGH:
L__INTERRUPCAO_COMPARE_HIGH7:
	RETFIE      1
; end of _INTERRUPCAO_COMPARE_HIGH

_ConfigMCU:

;unid_07_02_pulse_1khz.c,43 :: 		void ConfigMCU ()
;unid_07_02_pulse_1khz.c,49 :: 		ADCON1 |= 0X0F;                 // Others uC
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unid_07_02_pulse_1khz.c,52 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_ConfigInterrupcao_Global:

;unid_07_02_pulse_1khz.c,55 :: 		void ConfigInterrupcao_Global()
;unid_07_02_pulse_1khz.c,58 :: 		INTCON.GIEH = 1;               // Enable high priority
	BSF         INTCON+0, 7 
;unid_07_02_pulse_1khz.c,59 :: 		INTCON.GIEL = 1;               // Enable low priority
	BSF         INTCON+0, 6 
;unid_07_02_pulse_1khz.c,60 :: 		RCON.IPEN =  1;                // default heratage 16F, there one level
	BSF         RCON+0, 7 
;unid_07_02_pulse_1khz.c,63 :: 		}
L_end_ConfigInterrupcao_Global:
	RETURN      0
; end of _ConfigInterrupcao_Global

_Configuracao_Timer1:

;unid_07_02_pulse_1khz.c,66 :: 		void  Configuracao_Timer1()
;unid_07_02_pulse_1khz.c,76 :: 		T1CON= 0B10010001;               // 16 bits,ext osc, PS 1:2, Fosc/4, Mod on
	MOVLW       145
	MOVWF       T1CON+0 
;unid_07_02_pulse_1khz.c,79 :: 		TMR1H = 0;
	CLRF        TMR1H+0 
;unid_07_02_pulse_1khz.c,80 :: 		TMR1L = 0;
	CLRF        TMR1L+0 
;unid_07_02_pulse_1khz.c,82 :: 		T1CON.TMR1ON = 1;
	BSF         T1CON+0, 0 
;unid_07_02_pulse_1khz.c,85 :: 		}
L_end_Configuracao_Timer1:
	RETURN      0
; end of _Configuracao_Timer1

_ConfigInterrucao_Compare:

;unid_07_02_pulse_1khz.c,88 :: 		void ConfigInterrucao_Compare()
;unid_07_02_pulse_1khz.c,93 :: 		PIR1.CCP1IF = 0;
	BCF         PIR1+0, 2 
;unid_07_02_pulse_1khz.c,94 :: 		IPR1.CCP1IP = 1;
	BSF         IPR1+0, 2 
;unid_07_02_pulse_1khz.c,95 :: 		PIE1.CCP1IE = 1;
	BSF         PIE1+0, 2 
;unid_07_02_pulse_1khz.c,97 :: 		CCP1CON = 0;                     // Microchip recommendations - avoid unwanted interruptions:)
	CLRF        CCP1CON+0 
;unid_07_02_pulse_1khz.c,102 :: 		CCP1CON = 0B0000010;             // Compare mode, toggle output on match pg 141
	MOVLW       2
	MOVWF       CCP1CON+0 
;unid_07_02_pulse_1khz.c,105 :: 		CCPR1H = 0X01;
	MOVLW       1
	MOVWF       CCPR1H+0 
;unid_07_02_pulse_1khz.c,106 :: 		CCPR1L = 0XF4;
	MOVLW       244
	MOVWF       CCPR1L+0 
;unid_07_02_pulse_1khz.c,108 :: 		TRISC.RC2 = 0;                   // pin CCP as output
	BCF         TRISC+0, 2 
;unid_07_02_pulse_1khz.c,109 :: 		}
L_end_ConfigInterrucao_Compare:
	RETURN      0
; end of _ConfigInterrucao_Compare

_main:

;unid_07_02_pulse_1khz.c,112 :: 		void main() {
;unid_07_02_pulse_1khz.c,114 :: 		ConfigMcu();
	CALL        _ConfigMCU+0, 0
;unid_07_02_pulse_1khz.c,115 :: 		ConfigInterrupcao_Global();
	CALL        _ConfigInterrupcao_Global+0, 0
;unid_07_02_pulse_1khz.c,116 :: 		Configuracao_Timer1();
	CALL        _Configuracao_Timer1+0, 0
;unid_07_02_pulse_1khz.c,117 :: 		ConfigInterrucao_Compare();
	CALL        _ConfigInterrucao_Compare+0, 0
;unid_07_02_pulse_1khz.c,120 :: 		while (TRUE);                    // loop no outuput
L_main3:
	GOTO        L_main3
;unid_07_02_pulse_1khz.c,131 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
