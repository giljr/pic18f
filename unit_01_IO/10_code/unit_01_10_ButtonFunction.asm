
_main:

;unit_01_10_ButtonFunction.c,45 :: 		void main() {
;unit_01_10_ButtonFunction.c,53 :: 		INTCON2.RBPU = 0;             // All PORTB pull-ups resistors are unable as zero (RBPU is negated:)
	BCF         INTCON2+0, 7 
;unit_01_10_ButtonFunction.c,54 :: 		ADCON1 |= 0X0F;               // Config all ADC's pins as digital on PIC18F4520
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit_01_10_ButtonFunction.c,57 :: 		TRISB.RB0 = 1;                    // BUTTON: Config PORTB.RB0 as input
	BSF         TRISB+0, 0 
;unit_01_10_ButtonFunction.c,58 :: 		PORTB.RB0 = 1;                    // Optional, the MCU do it automatically ;)
	BSF         PORTB+0, 0 
;unit_01_10_ButtonFunction.c,61 :: 		TRISD = 0;                        // LEDs: Config PORTB.RB0 as output
	CLRF        TRISD+0 
;unit_01_10_ButtonFunction.c,62 :: 		PORTD = 0;                        // Optional, the MCU do it automatically ;)
	CLRF        PORTD+0 
;unit_01_10_ButtonFunction.c,65 :: 		while(TRUE)                      // Endless loop
L_main0:
;unit_01_10_ButtonFunction.c,67 :: 		if(Button(&PORTB, 0, 100, 0))
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	CLRF        FARG_Button_pin+0 
	MOVLW       100
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main2
;unit_01_10_ButtonFunction.c,69 :: 		PORTD.RD0 ^= 1;        // Toggle the LED
	BTG         PORTD+0, 0 
;unit_01_10_ButtonFunction.c,71 :: 		}
L_main2:
;unit_01_10_ButtonFunction.c,72 :: 		}
	GOTO        L_main0
;unit_01_10_ButtonFunction.c,73 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
