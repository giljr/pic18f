
_INTERRUPCAO_HIGH:

;unit05_06_IOC.c,71 :: 		void INTERRUPCAO_HIGH() iv 0x0008 ics ICS_AUTO {
;unit05_06_IOC.c,72 :: 		if(INTCON.INT0IF == 1)
	BTFSS       INTCON+0, 1 
	GOTO        L_INTERRUPCAO_HIGH0
;unit05_06_IOC.c,74 :: 		if(INTCON.RBIF == 1)
	BTFSS       INTCON+0, 0 
	GOTO        L_INTERRUPCAO_HIGH1
;unit05_06_IOC.c,76 :: 		PORTD.RD6 ^= 1;                 // Toggle LED on PORTD's 1º bit
	BTG         PORTD+0, 6 
;unit05_06_IOC.c,79 :: 		temp = PORTB;                // Reads PORTB value to redeem PORTB real state value
	MOVF        PORTB+0, 0 
	MOVWF       _temp+0 
;unit05_06_IOC.c,80 :: 		PORTB = temp;                // Write the value again to load it into the LATB as it is by the value
	MOVF        _temp+0, 0 
	MOVWF       PORTB+0 
;unit05_06_IOC.c,86 :: 		INTCON.RBIF = 0;             // Flag's cleared
	BCF         INTCON+0, 0 
;unit05_06_IOC.c,87 :: 		}
L_INTERRUPCAO_HIGH1:
;unit05_06_IOC.c,88 :: 		}
L_INTERRUPCAO_HIGH0:
;unit05_06_IOC.c,89 :: 		}
L_end_INTERRUPCAO_HIGH:
L__INTERRUPCAO_HIGH6:
	RETFIE      1
; end of _INTERRUPCAO_HIGH

_ConfigMCU:

;unit05_06_IOC.c,91 :: 		void ConfigMCU()
;unit05_06_IOC.c,103 :: 		ADCON1 |= 0X0F;                       // 0B11110000 config PORTB<7:4> as input
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit05_06_IOC.c,104 :: 		INTCON2.RBPU = 0;
	BCF         INTCON2+0, 7 
;unit05_06_IOC.c,107 :: 		TRISD = 0;
	CLRF        TRISD+0 
;unit05_06_IOC.c,108 :: 		PORTD = 0;
	CLRF        PORTD+0 
;unit05_06_IOC.c,110 :: 		TRISB.RB0 = 1;                        // RB0/INT0 pin as input
	BSF         TRISB+0, 0 
;unit05_06_IOC.c,112 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_configGlobalInterruption:

;unit05_06_IOC.c,114 :: 		void configGlobalInterruption()
;unit05_06_IOC.c,116 :: 		INTCON.GIEH = 1;
	BSF         INTCON+0, 7 
;unit05_06_IOC.c,117 :: 		INTCON.GIEL = 1;
	BSF         INTCON+0, 6 
;unit05_06_IOC.c,118 :: 		RCON.IPEN = 1;
	BSF         RCON+0, 7 
;unit05_06_IOC.c,119 :: 		}
L_end_configGlobalInterruption:
	RETURN      0
; end of _configGlobalInterruption

_configIndividualVctIOC:

;unit05_06_IOC.c,121 :: 		void configIndividualVctIOC()
;unit05_06_IOC.c,127 :: 		INTCON.RBIF = 0;                     // Overflow's Flag; this sets on/off interruptions;
	BCF         INTCON+0, 0 
;unit05_06_IOC.c,128 :: 		INTCON2.RBIP = 1;                    // High-priority interrupt source;
	BSF         INTCON2+0, 0 
;unit05_06_IOC.c,129 :: 		INTCON.RBIE = 1;                     // IF, IP & IF is enough:)
	BSF         INTCON+0, 3 
;unit05_06_IOC.c,130 :: 		}
L_end_configIndividualVctIOC:
	RETURN      0
; end of _configIndividualVctIOC

_main:

;unit05_06_IOC.c,132 :: 		void main() {
;unit05_06_IOC.c,133 :: 		configMCU();
	CALL        _ConfigMCU+0, 0
;unit05_06_IOC.c,134 :: 		configGlobalInterruption();
	CALL        _configGlobalInterruption+0, 0
;unit05_06_IOC.c,135 :: 		configIndividualVctIOC();
	CALL        _configIndividualVctIOC+0, 0
;unit05_06_IOC.c,138 :: 		while(TRUE)
L_main2:
;unit05_06_IOC.c,140 :: 		Delay_ms(300);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
	NOP
;unit05_06_IOC.c,141 :: 		PORTD.RD5 ^= 1;
	BTG         PORTD+0, 5 
;unit05_06_IOC.c,142 :: 		}
	GOTO        L_main2
;unit05_06_IOC.c,143 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
