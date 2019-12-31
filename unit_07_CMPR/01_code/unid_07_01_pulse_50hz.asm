
_ConfigMCU:

;unid_07_01_pulse_50hz.c,33 :: 		void ConfigMCU ()
;unid_07_01_pulse_50hz.c,39 :: 		ADCON1 |= 0X0F;                    // Others uC
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unid_07_01_pulse_50hz.c,42 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_ConfigInterrupcao_Global:

;unid_07_01_pulse_50hz.c,45 :: 		void ConfigInterrupcao_Global()
;unid_07_01_pulse_50hz.c,48 :: 		INTCON.GIEH = 1;                  // General config enable interruptions
	BSF         INTCON+0, 7 
;unid_07_01_pulse_50hz.c,49 :: 		INTCON.GIEL = 1;                  // Enable low priorities, this is not general key
	BSF         INTCON+0, 6 
;unid_07_01_pulse_50hz.c,50 :: 		RCON.IPEN =  1;                   // default family heritage 16F, just one level of priority
	BSF         RCON+0, 7 
;unid_07_01_pulse_50hz.c,53 :: 		}
L_end_ConfigInterrupcao_Global:
	RETURN      0
; end of _ConfigInterrupcao_Global

_Configuracao_TMR1:

;unid_07_01_pulse_50hz.c,56 :: 		void  Configuracao_TMR1()
;unid_07_01_pulse_50hz.c,65 :: 		T1CON = 0B10010001;
	MOVLW       145
	MOVWF       T1CON+0 
;unid_07_01_pulse_50hz.c,69 :: 		TMR1H = 0;
	CLRF        TMR1H+0 
;unid_07_01_pulse_50hz.c,70 :: 		TMR1L = 0;
	CLRF        TMR1L+0 
;unid_07_01_pulse_50hz.c,72 :: 		T1CON.TMR1ON = 1;
	BSF         T1CON+0, 0 
;unid_07_01_pulse_50hz.c,75 :: 		}
L_end_Configuracao_TMR1:
	RETURN      0
; end of _Configuracao_TMR1

_ConfigInterrucao_CCP_Compare:

;unid_07_01_pulse_50hz.c,78 :: 		void ConfigInterrucao_CCP_Compare()
;unid_07_01_pulse_50hz.c,81 :: 		CCP1CON = 0;                        // Microchip recommendations, Avoid interruptions not asked
	CLRF        CCP1CON+0 
;unid_07_01_pulse_50hz.c,83 :: 		CCP1CON = 0B00000010;               // The firsts 4 bits pg 141
	MOVLW       2
	MOVWF       CCP1CON+0 
;unid_07_01_pulse_50hz.c,85 :: 		CCPR1H = 0X27;
	MOVLW       39
	MOVWF       CCPR1H+0 
;unid_07_01_pulse_50hz.c,86 :: 		CCPR1L = 0X10;
	MOVLW       16
	MOVWF       CCPR1L+0 
;unid_07_01_pulse_50hz.c,92 :: 		TRISC.RC2 = 0;                      // pin CCP as saida
	BCF         TRISC+0, 2 
;unid_07_01_pulse_50hz.c,93 :: 		TRISB.RB0 = 0;
	BCF         TRISB+0, 0 
;unid_07_01_pulse_50hz.c,94 :: 		PORTB = 0;
	CLRF        PORTB+0 
;unid_07_01_pulse_50hz.c,96 :: 		}
L_end_ConfigInterrucao_CCP_Compare:
	RETURN      0
; end of _ConfigInterrucao_CCP_Compare

_main:

;unid_07_01_pulse_50hz.c,99 :: 		void main() {
;unid_07_01_pulse_50hz.c,100 :: 		unsigned int Periodo = 0;
;unid_07_01_pulse_50hz.c,103 :: 		ConfigMcu();
	CALL        _ConfigMCU+0, 0
;unid_07_01_pulse_50hz.c,104 :: 		ConfigInterrupcao_Global();
	CALL        _ConfigInterrupcao_Global+0, 0
;unid_07_01_pulse_50hz.c,105 :: 		Configuracao_TMR1();
	CALL        _Configuracao_TMR1+0, 0
;unid_07_01_pulse_50hz.c,106 :: 		ConfigInterrucao_CCP_Compare();
	CALL        _ConfigInterrucao_CCP_Compare+0, 0
;unid_07_01_pulse_50hz.c,109 :: 		while (TRUE)
L_main0:
;unid_07_01_pulse_50hz.c,112 :: 		if(PIR1.CCP1IE == 1)            // monitore the FLAG'a comparation
	BTFSS       PIR1+0, 2 
	GOTO        L_main2
;unid_07_01_pulse_50hz.c,114 :: 		TMR1H = 0;
	CLRF        TMR1H+0 
;unid_07_01_pulse_50hz.c,115 :: 		TMR1L = 0;
	CLRF        TMR1L+0 
;unid_07_01_pulse_50hz.c,116 :: 		PIR1.CCP1IF = 0;             // Clears the flag for comparations loop
	BCF         PIR1+0, 2 
;unid_07_01_pulse_50hz.c,117 :: 		}
L_main2:
;unid_07_01_pulse_50hz.c,118 :: 		}
	GOTO        L_main0
;unid_07_01_pulse_50hz.c,121 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
