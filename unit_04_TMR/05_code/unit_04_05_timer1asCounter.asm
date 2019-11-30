
_ConfigMCU:

;unit_04_05_timer1asCounter.c,70 :: 		void ConfigMCU()
;unit_04_05_timer1asCounter.c,76 :: 		ADCON1 |= 0X0F;                    // (PIC18F45220) Determine if anal/digital pins
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit_04_05_timer1asCounter.c,78 :: 		TRISD = 0;                         // LED is attached to PORTD.R0
	CLRF        TRISD+0 
;unit_04_05_timer1asCounter.c,79 :: 		PORTD = 0;
	CLRF        PORTD+0 
;unit_04_05_timer1asCounter.c,80 :: 		TRISC.RC0 = 1;                     // Simulate pulses PORTC.RC0 (T13CKI pin)
	BSF         TRISC+0, 0 
;unit_04_05_timer1asCounter.c,81 :: 		PORTC.RC0 = 1;
	BSF         PORTC+0, 0 
;unit_04_05_timer1asCounter.c,82 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_ConfigTimer:

;unit_04_05_timer1asCounter.c,84 :: 		void ConfigTimer()
;unit_04_05_timer1asCounter.c,89 :: 		T1CON = 0B10000010;                // Timer1 off, Prescale 1:1 , Mode 16-BITS, edge low/high
	MOVLW       130
	MOVWF       T1CON+0 
;unit_04_05_timer1asCounter.c,91 :: 		TMR1H = 0XFF;                       // Initial values for accumulator registers
	MOVLW       255
	MOVWF       TMR1H+0 
;unit_04_05_timer1asCounter.c,92 :: 		TMR1L = 0XFF;                       // One more pulse, Timer1 overflow!
	MOVLW       255
	MOVWF       TMR1L+0 
;unit_04_05_timer1asCounter.c,94 :: 		PIR1.TMR1IF = 0;                    // Flag clearhigh/low
	BCF         PIR1+0, 0 
;unit_04_05_timer1asCounter.c,95 :: 		T1CON.TMR1ON = 1;                   // Timer1 on, everything is configurhigh/low, rightD
	BSF         T1CON+0, 0 
;unit_04_05_timer1asCounter.c,96 :: 		}
L_end_ConfigTimer:
	RETURN      0
; end of _ConfigTimer

_main:

;unit_04_05_timer1asCounter.c,98 :: 		void main() {
;unit_04_05_timer1asCounter.c,99 :: 		ConfigMCU();
	CALL        _ConfigMCU+0, 0
;unit_04_05_timer1asCounter.c,100 :: 		ConfigTimer();
	CALL        _ConfigTimer+0, 0
;unit_04_05_timer1asCounter.c,102 :: 		while (TRUE)                         // Do forever
L_main0:
;unit_04_05_timer1asCounter.c,104 :: 		if(PIR1.TMR1IF == 1)
	BTFSS       PIR1+0, 0 
	GOTO        L_main2
;unit_04_05_timer1asCounter.c,106 :: 		PORTD.RD0 = ~LATD.RD0;          // toggle LED high/low
	BTFSC       LATD+0, 0 
	GOTO        L__main6
	BSF         PORTD+0, 0 
	GOTO        L__main7
L__main6:
	BCF         PORTD+0, 0 
L__main7:
;unit_04_05_timer1asCounter.c,108 :: 		TMR1H = 0XFF;                   // Recharge default values
	MOVLW       255
	MOVWF       TMR1H+0 
;unit_04_05_timer1asCounter.c,109 :: 		TMR1L = 0XFF;
	MOVLW       255
	MOVWF       TMR1L+0 
;unit_04_05_timer1asCounter.c,110 :: 		PIR1.TMR1IF = 0;                // Clear Timer1's overflow Flag
	BCF         PIR1+0, 0 
;unit_04_05_timer1asCounter.c,111 :: 		}
L_main2:
;unit_04_05_timer1asCounter.c,112 :: 		}
	GOTO        L_main0
;unit_04_05_timer1asCounter.c,113 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
