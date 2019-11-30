
_INTERRUPTION_HIGH:

;unit05_05_INT0_INT1_INT2.c,83 :: 		void INTERRUPTION_HIGH() iv 0x0008 ics ICS_AUTO {
;unit05_05_INT0_INT1_INT2.c,84 :: 		if(INTCON.INT0IF == 1)
	BTFSS       INTCON+0, 1 
	GOTO        L_INTERRUPTION_HIGH0
;unit05_05_INT0_INT1_INT2.c,86 :: 		PORTD.RD4 ^= 1;                   // toggle pin RBO
	BTG         PORTD+0, 4 
;unit05_05_INT0_INT1_INT2.c,87 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;unit05_05_INT0_INT1_INT2.c,88 :: 		} else
	GOTO        L_INTERRUPTION_HIGH1
L_INTERRUPTION_HIGH0:
;unit05_05_INT0_INT1_INT2.c,89 :: 		if(INTCON3.INT1IF = 1)
	BSF         INTCON3+0, 0 
	BTFSS       INTCON3+0, 0 
	GOTO        L_INTERRUPTION_HIGH2
;unit05_05_INT0_INT1_INT2.c,91 :: 		PORTD.RD5 ^= 1;                 // toggle pin RB2
	BTG         PORTD+0, 5 
;unit05_05_INT0_INT1_INT2.c,92 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;unit05_05_INT0_INT1_INT2.c,93 :: 		}
L_INTERRUPTION_HIGH2:
L_INTERRUPTION_HIGH1:
;unit05_05_INT0_INT1_INT2.c,95 :: 		}
L_end_INTERRUPTION_HIGH:
L__INTERRUPTION_HIGH7:
	RETFIE      1
; end of _INTERRUPTION_HIGH

_INTERRUPTION_LOW:
	MOVWF       ___Low_saveWREG+0 
	MOVF        STATUS+0, 0 
	MOVWF       ___Low_saveSTATUS+0 
	MOVF        BSR+0, 0 
	MOVWF       ___Low_saveBSR+0 

;unit05_05_INT0_INT1_INT2.c,96 :: 		void INTERRUPTION_LOW() iv 0x0018 ics ICS_AUTO {
;unit05_05_INT0_INT1_INT2.c,97 :: 		if(INTCON3.INT2IF = 1)
	BSF         INTCON3+0, 1 
	BTFSS       INTCON3+0, 1 
	GOTO        L_INTERRUPTION_LOW3
;unit05_05_INT0_INT1_INT2.c,99 :: 		PORTD.RD6 ^= 1;                  // toggle pin RB1
	BTG         PORTD+0, 6 
;unit05_05_INT0_INT1_INT2.c,100 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;unit05_05_INT0_INT1_INT2.c,101 :: 		}
L_INTERRUPTION_LOW3:
;unit05_05_INT0_INT1_INT2.c,102 :: 		}
L_end_INTERRUPTION_LOW:
L__INTERRUPTION_LOW9:
	MOVF        ___Low_saveBSR+0, 0 
	MOVWF       BSR+0 
	MOVF        ___Low_saveSTATUS+0, 0 
	MOVWF       STATUS+0 
	SWAPF       ___Low_saveWREG+0, 1 
	SWAPF       ___Low_saveWREG+0, 0 
	RETFIE      0
; end of _INTERRUPTION_LOW

_ConfigMCU:

;unit05_05_INT0_INT1_INT2.c,104 :: 		void ConfigMCU()
;unit05_05_INT0_INT1_INT2.c,117 :: 		ADCON1 |= 0X0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit05_05_INT0_INT1_INT2.c,118 :: 		INTCON2.RBPU = 0;
	BCF         INTCON2+0, 7 
;unit05_05_INT0_INT1_INT2.c,121 :: 		TRISD = 0;
	CLRF        TRISD+0 
;unit05_05_INT0_INT1_INT2.c,122 :: 		PORTD = 0;
	CLRF        PORTD+0 
;unit05_05_INT0_INT1_INT2.c,124 :: 		TRISB.RB0 = 1;                        // RB0/INT0 pin as input
	BSF         TRISB+0, 0 
;unit05_05_INT0_INT1_INT2.c,125 :: 		TRISB.RB1 = 1;                        // RB1/INT0 pin as input
	BSF         TRISB+0, 1 
;unit05_05_INT0_INT1_INT2.c,126 :: 		TRISB.RB2 = 1;                        // RB2/INT0 pin as input
	BSF         TRISB+0, 2 
;unit05_05_INT0_INT1_INT2.c,128 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_configGlobalInterruption:

;unit05_05_INT0_INT1_INT2.c,130 :: 		void configGlobalInterruption()
;unit05_05_INT0_INT1_INT2.c,132 :: 		INTCON.GIEH = 1;
	BSF         INTCON+0, 7 
;unit05_05_INT0_INT1_INT2.c,133 :: 		INTCON.GIEL = 1;
	BSF         INTCON+0, 6 
;unit05_05_INT0_INT1_INT2.c,134 :: 		RCON.IPEN = 1;
	BSF         RCON+0, 7 
;unit05_05_INT0_INT1_INT2.c,135 :: 		}
L_end_configGlobalInterruption:
	RETURN      0
; end of _configGlobalInterruption

_configIndividualVctINT0:

;unit05_05_INT0_INT1_INT2.c,137 :: 		void configIndividualVctINT0()
;unit05_05_INT0_INT1_INT2.c,139 :: 		INTCON.INT0IF = 0;                   // Overflow's Flag; this sets on/off interruptions;
	BCF         INTCON+0, 1 
;unit05_05_INT0_INT1_INT2.c,142 :: 		INTCON.INT0IE = 1;                   // Besides IF, IP & IF, there is EDGE Configuration, too!
	BSF         INTCON+0, 4 
;unit05_05_INT0_INT1_INT2.c,145 :: 		INTCON.INTEDG0 = 1;                 // 1 - > rising edge
	BSF         INTCON+0, 6 
;unit05_05_INT0_INT1_INT2.c,147 :: 		}
L_end_configIndividualVctINT0:
	RETURN      0
; end of _configIndividualVctINT0

_configIndividualVctINT1:

;unit05_05_INT0_INT1_INT2.c,149 :: 		void configIndividualVctINT1()
;unit05_05_INT0_INT1_INT2.c,151 :: 		INTCON3.INT1IF = 0;                  // Clear overflow Flag
	BCF         INTCON3+0, 0 
;unit05_05_INT0_INT1_INT2.c,152 :: 		INTCON3.INT1IP = 0;                  // Priority on INT1 LOW
	BCF         INTCON3+0, 6 
;unit05_05_INT0_INT1_INT2.c,153 :: 		INTCON3.INT1IE = 1;                  // Interruption on INT1 enable
	BSF         INTCON3+0, 3 
;unit05_05_INT0_INT1_INT2.c,154 :: 		INTCON3.INTEDG1 = 0;                 // 0 - > falling edge
	BCF         INTCON3+0, 5 
;unit05_05_INT0_INT1_INT2.c,156 :: 		}
L_end_configIndividualVctINT1:
	RETURN      0
; end of _configIndividualVctINT1

_configIndividualVctINT2:

;unit05_05_INT0_INT1_INT2.c,158 :: 		void configIndividualVctINT2()
;unit05_05_INT0_INT1_INT2.c,160 :: 		INTCON3.INT2IF = 0;                  // Clear overflow Flag
	BCF         INTCON3+0, 1 
;unit05_05_INT0_INT1_INT2.c,161 :: 		INTCON3.INT2IP = 1;                  // Priority on INT2 HIGH
	BSF         INTCON3+0, 7 
;unit05_05_INT0_INT1_INT2.c,162 :: 		INTCON3.INT2IE = 1;                  // Interruption on INT2 enable
	BSF         INTCON3+0, 4 
;unit05_05_INT0_INT1_INT2.c,163 :: 		INTCON2.INTEDG1 = 1;                 // 1 - > rising edge
	BSF         INTCON2+0, 5 
;unit05_05_INT0_INT1_INT2.c,164 :: 		}
L_end_configIndividualVctINT2:
	RETURN      0
; end of _configIndividualVctINT2

_main:

;unit05_05_INT0_INT1_INT2.c,166 :: 		void main() {
;unit05_05_INT0_INT1_INT2.c,167 :: 		configMCU();
	CALL        _ConfigMCU+0, 0
;unit05_05_INT0_INT1_INT2.c,168 :: 		configGlobalInterruption();
	CALL        _configGlobalInterruption+0, 0
;unit05_05_INT0_INT1_INT2.c,169 :: 		configIndividualVctINT0();           // Individual peripheral configs (INT0)
	CALL        _configIndividualVctINT0+0, 0
;unit05_05_INT0_INT1_INT2.c,170 :: 		configIndividualVctINT1();           // Individual peripheral configs (INT1)
	CALL        _configIndividualVctINT1+0, 0
;unit05_05_INT0_INT1_INT2.c,171 :: 		configIndividualVctINT2();           // Individual peripheral configs (INT2)
	CALL        _configIndividualVctINT2+0, 0
;unit05_05_INT0_INT1_INT2.c,173 :: 		while(1);                              // I stopped processing!
L_main4:
	GOTO        L_main4
;unit05_05_INT0_INT1_INT2.c,175 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
