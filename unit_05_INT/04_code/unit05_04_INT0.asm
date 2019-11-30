
_INTERRUPCAO_HIGH:

;unit05_04_INT0.c,57 :: 		void INTERRUPCAO_HIGH() iv 0x0008 ics ICS_AUTO {
;unit05_04_INT0.c,58 :: 		if(INTCON.INT0IF == 1)
	BTFSS       INTCON+0, 1 
	GOTO        L_INTERRUPCAO_HIGH0
;unit05_04_INT0.c,60 :: 		PORTD.RD4 ^= 1;                   // toggle pin RBO
	BTG         PORTD+0, 4 
;unit05_04_INT0.c,61 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;unit05_04_INT0.c,62 :: 		}
L_INTERRUPCAO_HIGH0:
;unit05_04_INT0.c,63 :: 		}
L_end_INTERRUPCAO_HIGH:
L__INTERRUPCAO_HIGH4:
	RETFIE      1
; end of _INTERRUPCAO_HIGH

_ConfigMCU:

;unit05_04_INT0.c,65 :: 		void ConfigMCU()
;unit05_04_INT0.c,76 :: 		ADCON1 |= 0X0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit05_04_INT0.c,77 :: 		INTCON2.RBPU = 0;
	BCF         INTCON2+0, 7 
;unit05_04_INT0.c,80 :: 		TRISD = 0;
	CLRF        TRISD+0 
;unit05_04_INT0.c,81 :: 		PORTD = 0;
	CLRF        PORTD+0 
;unit05_04_INT0.c,83 :: 		TRISB.RB0 = 1;                        // RB0/INT0 pin as input
	BSF         TRISB+0, 0 
;unit05_04_INT0.c,85 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_configGlobalInterruption:

;unit05_04_INT0.c,87 :: 		void configGlobalInterruption()
;unit05_04_INT0.c,89 :: 		INTCON.GIEH = 1;
	BSF         INTCON+0, 7 
;unit05_04_INT0.c,90 :: 		INTCON.GIEL = 1;
	BSF         INTCON+0, 6 
;unit05_04_INT0.c,91 :: 		RCON.IPEN = 1;
	BSF         RCON+0, 7 
;unit05_04_INT0.c,92 :: 		}
L_end_configGlobalInterruption:
	RETURN      0
; end of _configGlobalInterruption

_configIndividualVctINT0:

;unit05_04_INT0.c,94 :: 		void configIndividualVctINT0()
;unit05_04_INT0.c,96 :: 		INTCON.INT0IF = 0;                   // Overflow's Flag; this sets on/off interruptions;
	BCF         INTCON+0, 1 
;unit05_04_INT0.c,99 :: 		INTCON.INT0IE = 1;                   // Besides IF, IP & IF, there is EDGE Configuration, too!
	BSF         INTCON+0, 4 
;unit05_04_INT0.c,102 :: 		INTCON2.INTEDG0 = 1;                 // 1 - > rising edge
	BSF         INTCON2+0, 6 
;unit05_04_INT0.c,104 :: 		}
L_end_configIndividualVctINT0:
	RETURN      0
; end of _configIndividualVctINT0

_main:

;unit05_04_INT0.c,106 :: 		void main() {
;unit05_04_INT0.c,107 :: 		configMCU();
	CALL        _ConfigMCU+0, 0
;unit05_04_INT0.c,108 :: 		configGlobalInterruption();
	CALL        _configGlobalInterruption+0, 0
;unit05_04_INT0.c,109 :: 		configIndividualVctINT0();
	CALL        _configIndividualVctINT0+0, 0
;unit05_04_INT0.c,111 :: 		while(1);                              // I stopped processing!
L_main1:
	GOTO        L_main1
;unit05_04_INT0.c,113 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
