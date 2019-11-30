
_INTERRUPTION_HIGH:

;unit05_02_highLowPrioritiesInterruptions.c,135 :: 		void INTERRUPTION_HIGH() iv 0x0008 ics ICS_AUTO
;unit05_02_highLowPrioritiesInterruptions.c,138 :: 		if(INTCON.TMR0IF == 1)
	BTFSS       INTCON+0, 2 
	GOTO        L_INTERRUPTION_HIGH0
;unit05_02_highLowPrioritiesInterruptions.c,140 :: 		PORTD.RD0 = ~LATD.RD0;          // Toggle LED bit 0
	BTFSC       LATD+0, 0 
	GOTO        L__INTERRUPTION_HIGH8
	BSF         PORTD+0, 0 
	GOTO        L__INTERRUPTION_HIGH9
L__INTERRUPTION_HIGH8:
	BCF         PORTD+0, 0 
L__INTERRUPTION_HIGH9:
;unit05_02_highLowPrioritiesInterruptions.c,143 :: 		TMR0H = 0XCF;                   // Recharge acumulator
	MOVLW       207
	MOVWF       TMR0H+0 
;unit05_02_highLowPrioritiesInterruptions.c,144 :: 		TMR0L = 0X2C;
	MOVLW       44
	MOVWF       TMR0L+0 
;unit05_02_highLowPrioritiesInterruptions.c,146 :: 		INTCON.TMR0IF = 0;              // Clear flag & reset interruption cycle
	BCF         INTCON+0, 2 
;unit05_02_highLowPrioritiesInterruptions.c,148 :: 		}
L_INTERRUPTION_HIGH0:
;unit05_02_highLowPrioritiesInterruptions.c,149 :: 		}
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

;unit05_02_highLowPrioritiesInterruptions.c,151 :: 		void INTERRUPTION_LOW() iv 0x0018 ics ICS_AUTO {
;unit05_02_highLowPrioritiesInterruptions.c,154 :: 		if(PIR1.TMR1IF == 1)
	BTFSS       PIR1+0, 0 
	GOTO        L_INTERRUPTION_LOW1
;unit05_02_highLowPrioritiesInterruptions.c,156 :: 		counter++;                     // By using counter you can make this
	MOVF        R1, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R1 
;unit05_02_highLowPrioritiesInterruptions.c,158 :: 		if(counter == 4)              // Overflow at 250ms x 4 = 1000ms
	MOVF        R1, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_INTERRUPTION_LOW2
;unit05_02_highLowPrioritiesInterruptions.c,160 :: 		PORTD.RD4 ^= 1;           // Toggle LED bit 2
	BTG         PORTD+0, 4 
;unit05_02_highLowPrioritiesInterruptions.c,161 :: 		counter = 0;
	CLRF        R1 
;unit05_02_highLowPrioritiesInterruptions.c,162 :: 		}
L_INTERRUPTION_LOW2:
;unit05_02_highLowPrioritiesInterruptions.c,164 :: 		TMR1H = 0X0B;                   // Recharge acumulator
	MOVLW       11
	MOVWF       TMR1H+0 
;unit05_02_highLowPrioritiesInterruptions.c,165 :: 		TMR1L = 0XDC;
	MOVLW       220
	MOVWF       TMR1L+0 
;unit05_02_highLowPrioritiesInterruptions.c,167 :: 		PIR1.TMR1IF = 0;                // Clear Flag
	BCF         PIR1+0, 0 
;unit05_02_highLowPrioritiesInterruptions.c,169 :: 		}
L_INTERRUPTION_LOW1:
;unit05_02_highLowPrioritiesInterruptions.c,170 :: 		}
L_end_INTERRUPTION_LOW:
L__INTERRUPTION_LOW11:
	MOVF        ___Low_saveBSR+0, 0 
	MOVWF       BSR+0 
	MOVF        ___Low_saveSTATUS+0, 0 
	MOVWF       STATUS+0 
	SWAPF       ___Low_saveWREG+0, 1 
	SWAPF       ___Low_saveWREG+0, 0 
	RETFIE      0
; end of _INTERRUPTION_LOW

_configMCU:

;unit05_02_highLowPrioritiesInterruptions.c,172 :: 		void configMCU()                  // Timer0 Port & Directions
;unit05_02_highLowPrioritiesInterruptions.c,177 :: 		ADCON1 |= 0X0F;                    // Analog pinouts
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit05_02_highLowPrioritiesInterruptions.c,180 :: 		TRISD = 0;
	CLRF        TRISD+0 
;unit05_02_highLowPrioritiesInterruptions.c,181 :: 		PORTD = 0;                        // LEDs' control pins
	CLRF        PORTD+0 
;unit05_02_highLowPrioritiesInterruptions.c,182 :: 		}
L_end_configMCU:
	RETURN      0
; end of _configMCU

_configTMR0:

;unit05_02_highLowPrioritiesInterruptions.c,183 :: 		void configTMR0()                   // TIMER0 em 200ms
;unit05_02_highLowPrioritiesInterruptions.c,188 :: 		T0CON = 0B00000100;                // Timer OFF, Mod 16-bits, Mode Timer, Prescale 1:32
	MOVLW       4
	MOVWF       T0CON+0 
;unit05_02_highLowPrioritiesInterruptions.c,190 :: 		TMR0H = 0XCF;
	MOVLW       207
	MOVWF       TMR0H+0 
;unit05_02_highLowPrioritiesInterruptions.c,191 :: 		TMR0L = 0X2C;
	MOVLW       44
	MOVWF       TMR0L+0 
;unit05_02_highLowPrioritiesInterruptions.c,193 :: 		INTCON.TMR0IF = 0;                // Clear Flag
	BCF         INTCON+0, 2 
;unit05_02_highLowPrioritiesInterruptions.c,194 :: 		T0CON.TMR0ON = 1;                 // Timer0 on!
	BSF         T0CON+0, 7 
;unit05_02_highLowPrioritiesInterruptions.c,195 :: 		}
L_end_configTMR0:
	RETURN      0
; end of _configTMR0

_configTMR1:

;unit05_02_highLowPrioritiesInterruptions.c,196 :: 		void configTMR1()                   // TIMER1 em 1000ms
;unit05_02_highLowPrioritiesInterruptions.c,201 :: 		T1CON = 0B10110000;                // Timer1 OFF, Mod 16-bits, Mode Timer, Prescale 1:8
	MOVLW       176
	MOVWF       T1CON+0 
;unit05_02_highLowPrioritiesInterruptions.c,203 :: 		TMR1H = 0X0B;
	MOVLW       11
	MOVWF       TMR1H+0 
;unit05_02_highLowPrioritiesInterruptions.c,204 :: 		TMR1L = 0XDC;
	MOVLW       220
	MOVWF       TMR1L+0 
;unit05_02_highLowPrioritiesInterruptions.c,206 :: 		PIR1.TMR1IF = 0;                  // Clear Flag
	BCF         PIR1+0, 0 
;unit05_02_highLowPrioritiesInterruptions.c,207 :: 		T1CON.TMR1ON = 1;                 // Timer1 on!
	BSF         T1CON+0, 0 
;unit05_02_highLowPrioritiesInterruptions.c,208 :: 		}
L_end_configTMR1:
	RETURN      0
; end of _configTMR1

_configGlobalInterruption:

;unit05_02_highLowPrioritiesInterruptions.c,209 :: 		void configGlobalInterruption()     // Interruptions's master keys
;unit05_02_highLowPrioritiesInterruptions.c,211 :: 		INTCON.GIEH = 1;                  // High priority enabled
	BSF         INTCON+0, 7 
;unit05_02_highLowPrioritiesInterruptions.c,212 :: 		INTCON.GIEL = 1;                  // Low prioritY enabled
	BSF         INTCON+0, 6 
;unit05_02_highLowPrioritiesInterruptions.c,213 :: 		RCON.IPEN =   1;                  // Compatibility family 16F (just one level)
	BSF         RCON+0, 7 
;unit05_02_highLowPrioritiesInterruptions.c,216 :: 		}
L_end_configGlobalInterruption:
	RETURN      0
; end of _configGlobalInterruption

_configIndividualVctTMR0:

;unit05_02_highLowPrioritiesInterruptions.c,217 :: 		void configIndividualVctTMR0()
;unit05_02_highLowPrioritiesInterruptions.c,220 :: 		INTCON.TMR0IF  = 0;               // Overflow flag; please init zero
	BCF         INTCON+0, 2 
;unit05_02_highLowPrioritiesInterruptions.c,221 :: 		INTCON2.TMR0IP = 1;               // Interruption priority vector: HIGH
	BSF         INTCON2+0, 2 
;unit05_02_highLowPrioritiesInterruptions.c,222 :: 		INTCON.TMR0IE  = 1;               // TIMER0's interruption enabled
	BSF         INTCON+0, 5 
;unit05_02_highLowPrioritiesInterruptions.c,223 :: 		}
L_end_configIndividualVctTMR0:
	RETURN      0
; end of _configIndividualVctTMR0

_configIndividualVctTMR1:

;unit05_02_highLowPrioritiesInterruptions.c,224 :: 		void configIndividualVctTMR1()
;unit05_02_highLowPrioritiesInterruptions.c,227 :: 		PIR1.TMR1IF  = 0;                 // Overflow flag; please init zero
	BCF         PIR1+0, 0 
;unit05_02_highLowPrioritiesInterruptions.c,228 :: 		IPR1.TMR1IP = 0;                  // Interruption priority vector: LOW
	BCF         IPR1+0, 0 
;unit05_02_highLowPrioritiesInterruptions.c,229 :: 		PIE1.TMR1IE  = 1;                 // TIMER0's interruption enabled
	BSF         PIE1+0, 0 
;unit05_02_highLowPrioritiesInterruptions.c,230 :: 		}
L_end_configIndividualVctTMR1:
	RETURN      0
; end of _configIndividualVctTMR1

_main:

;unit05_02_highLowPrioritiesInterruptions.c,231 :: 		void main() {
;unit05_02_highLowPrioritiesInterruptions.c,232 :: 		configMCU();                      // configure CHIP
	CALL        _configMCU+0, 0
;unit05_02_highLowPrioritiesInterruptions.c,233 :: 		configTMR0();                     // configure TMR0 master ints keys
	CALL        _configTMR0+0, 0
;unit05_02_highLowPrioritiesInterruptions.c,234 :: 		configTMR1();                     // configure TMR1 master ints keys
	CALL        _configTMR1+0, 0
;unit05_02_highLowPrioritiesInterruptions.c,235 :: 		configGlobalInterruption();       // Configure globals ints
	CALL        _configGlobalInterruption+0, 0
;unit05_02_highLowPrioritiesInterruptions.c,236 :: 		configIndividualVctTMR0();        // configure TMR0 indiviadual vectors for each time
	CALL        _configIndividualVctTMR0+0, 0
;unit05_02_highLowPrioritiesInterruptions.c,237 :: 		configIndividualVctTMR1();        // configure TMR1 indiviadual vectors for each time
	CALL        _configIndividualVctTMR1+0, 0
;unit05_02_highLowPrioritiesInterruptions.c,241 :: 		while(TRUE)
L_main3:
;unit05_02_highLowPrioritiesInterruptions.c,243 :: 		PORTD.RD5 = ~LATD.RD5;
	BTFSC       LATD+0, 5 
	GOTO        L__main19
	BSF         PORTD+0, 5 
	GOTO        L__main20
L__main19:
	BCF         PORTD+0, 5 
L__main20:
;unit05_02_highLowPrioritiesInterruptions.c,244 :: 		Delay_ms(1000);             // Killing processor here!
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
	NOP
	NOP
;unit05_02_highLowPrioritiesInterruptions.c,246 :: 		}
	GOTO        L_main3
;unit05_02_highLowPrioritiesInterruptions.c,247 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
