
_configMCU:

;unit_04_07_timer2.c,61 :: 		void configMCU()
;unit_04_07_timer2.c,67 :: 		ADCON1 |= 0X0F;                    // (PIC18F45220) Determine if anal/digital
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit_04_07_timer2.c,69 :: 		TRISB.RB0 = 1;                      // Key RB0 as input
	BSF         TRISB+0, 0 
;unit_04_07_timer2.c,70 :: 		TRISB.RB1 = 1;                      // Key RB1 as input
	BSF         TRISB+0, 1 
;unit_04_07_timer2.c,71 :: 		TRISD = 0;                          // LED  as output
	CLRF        TRISD+0 
;unit_04_07_timer2.c,72 :: 		PORTD = 0;                          // All LEDs are off
	CLRF        PORTD+0 
;unit_04_07_timer2.c,73 :: 		}
L_end_configMCU:
	RETURN      0
; end of _configMCU

_configTimer:

;unit_04_07_timer2.c,74 :: 		void configTimer()
;unit_04_07_timer2.c,79 :: 		T2CON = 0B01111011;                // Define TIMER2 OFF, prescaler 1:16, postscale 1:16
	MOVLW       123
	MOVWF       T2CON+0 
;unit_04_07_timer2.c,81 :: 		PR2 =  255;                        // Count for 32ms
	MOVLW       255
	MOVWF       PR2+0 
;unit_04_07_timer2.c,82 :: 		PIR1.TMR2IF = 0;                   // Clear TIMER2's flag
	BCF         PIR1+0, 1 
;unit_04_07_timer2.c,83 :: 		T2CON.TMR2ON = 1;                  // Timer2 on, everything is configure, right:D
	BSF         T2CON+0, 2 
;unit_04_07_timer2.c,84 :: 		}
L_end_configTimer:
	RETURN      0
; end of _configTimer

_main:

;unit_04_07_timer2.c,86 :: 		void main(){                          // Main routine
;unit_04_07_timer2.c,88 :: 		configMCU();
	CALL        _configMCU+0, 0
;unit_04_07_timer2.c,89 :: 		ConfigTimer();
	CALL        _configTimer+0, 0
;unit_04_07_timer2.c,91 :: 		while (TRUE){
L_main0:
;unit_04_07_timer2.c,93 :: 		if (PORTB.RB0 == 0) {             // If RB0's key pressed...
	BTFSC       PORTB+0, 0 
	GOTO        L_main2
;unit_04_07_timer2.c,94 :: 		T2CON.TMR2ON = 1;            // Timer2 on
	BSF         T2CON+0, 2 
;unit_04_07_timer2.c,95 :: 		}
L_main2:
;unit_04_07_timer2.c,97 :: 		if (PORTB.RB1 == 0){              // If R10's key pressed...
	BTFSC       PORTB+0, 1 
	GOTO        L_main3
;unit_04_07_timer2.c,98 :: 		T2CON.TMR2ON = 0;            // Timer2 off
	BCF         T2CON+0, 2 
;unit_04_07_timer2.c,99 :: 		}
L_main3:
;unit_04_07_timer2.c,101 :: 		if (PIR1.TMR2IF == 1) {           // If TMR2 overflow...
	BTFSS       PIR1+0, 1 
	GOTO        L_main4
;unit_04_07_timer2.c,102 :: 		PORTD.RD4 = ~LATD.RD4;       // toggle LED
	BTFSC       LATD+0, 4 
	GOTO        L__main8
	BSF         PORTD+0, 4 
	GOTO        L__main9
L__main8:
	BCF         PORTD+0, 4 
L__main9:
;unit_04_07_timer2.c,103 :: 		PIR1.TMR2IF = 0;             // Clear TMR2's overflow flag
	BCF         PIR1+0, 1 
;unit_04_07_timer2.c,104 :: 		}
L_main4:
;unit_04_07_timer2.c,105 :: 		}
	GOTO        L_main0
;unit_04_07_timer2.c,106 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
