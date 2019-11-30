
_ConfigMCU:

;unit04_04_timer1.c,70 :: 		void ConfigMCU()
;unit04_04_timer1.c,75 :: 		ADCON1 |= 0X0F;                    // (PIC18F45220) Determine if anal/digital pins
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit04_04_timer1.c,77 :: 		TRISB = 0;                         // LED is attached to PORTD.RD0
	CLRF        TRISB+0 
;unit04_04_timer1.c,78 :: 		PORTB = 0;
	CLRF        PORTB+0 
;unit04_04_timer1.c,79 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_ConfigTimer:

;unit04_04_timer1.c,81 :: 		void ConfigTimer()
;unit04_04_timer1.c,86 :: 		T1CON = 0B10110000;                // Timer1 off, Prescale 1:8, Mode 16-BITS
	MOVLW       176
	MOVWF       T1CON+0 
;unit04_04_timer1.c,88 :: 		TMR1H = 0;                          // Initial values for accumulator registers
	CLRF        TMR1H+0 
;unit04_04_timer1.c,89 :: 		TMR1L = 0;
	CLRF        TMR1L+0 
;unit04_04_timer1.c,91 :: 		PIR1.TMR1IF = 0;                    // Flag cleared
	BCF         PIR1+0, 0 
;unit04_04_timer1.c,92 :: 		T1CON.TMR1ON = 1;                   // Timer1 on, everything is configured, right?
	BSF         T1CON+0, 0 
;unit04_04_timer1.c,93 :: 		}
L_end_ConfigTimer:
	RETURN      0
; end of _ConfigTimer

_main:

;unit04_04_timer1.c,95 :: 		void main() {
;unit04_04_timer1.c,96 :: 		ConfigMCU();
	CALL        _ConfigMCU+0, 0
;unit04_04_timer1.c,97 :: 		ConfigTimer();
	CALL        _ConfigTimer+0, 0
;unit04_04_timer1.c,99 :: 		while (TRUE)                         // Do forever
L_main0:
;unit04_04_timer1.c,101 :: 		if(PIR1.TMR1IF == 1)
	BTFSS       PIR1+0, 0 
	GOTO        L_main2
;unit04_04_timer1.c,103 :: 		PORTB.RB0 = ~LATB.RB0;          // toggle LED
	BTFSC       LATB+0, 0 
	GOTO        L__main6
	BSF         PORTB+0, 0 
	GOTO        L__main7
L__main6:
	BCF         PORTB+0, 0 
L__main7:
;unit04_04_timer1.c,105 :: 		TMR1H = 0;                      // Recharge default values
	CLRF        TMR1H+0 
;unit04_04_timer1.c,106 :: 		TMR1L = 0;
	CLRF        TMR1L+0 
;unit04_04_timer1.c,107 :: 		PIR1.TMR1IF = 0;                // Clear Timer1's overflow Flag
	BCF         PIR1+0, 0 
;unit04_04_timer1.c,108 :: 		}
L_main2:
;unit04_04_timer1.c,109 :: 		}
	GOTO        L_main0
;unit04_04_timer1.c,110 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
