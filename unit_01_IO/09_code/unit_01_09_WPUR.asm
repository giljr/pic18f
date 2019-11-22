
_main:

;unit_01_09_WPUR.c,47 :: 		void main() {
;unit_01_09_WPUR.c,55 :: 		INTCON2.RBPU = 0;             // All PORTB pull-ups resistors are unable as zero (RBPU is negated:)
	BCF         INTCON2+0, 7 
;unit_01_09_WPUR.c,56 :: 		ADCON1 |= 0X0F;               // Config all ADC's pins as digital on PIC18F4520
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit_01_09_WPUR.c,59 :: 		TRISB.RB0 = 1;                    // BUTTON: Config PORTB.RB0 as input
	BSF         TRISB+0, 0 
;unit_01_09_WPUR.c,60 :: 		PORTB.RB0 = 1;                    // Optional, the MCU do it automatically ;)
	BSF         PORTB+0, 0 
;unit_01_09_WPUR.c,63 :: 		TRISD = 0;                        // LEDs: Config PORTD as output
	CLRF        TRISD+0 
;unit_01_09_WPUR.c,64 :: 		PORTD = 0;                        // Optional, the MCU do it automatically ;)
	CLRF        PORTD+0 
;unit_01_09_WPUR.c,67 :: 		while(TRUE)                        // Endless loop
L_main0:
;unit_01_09_WPUR.c,69 :: 		if(PORTB.RB0 == 0)
	BTFSC       PORTB+0, 0 
	GOTO        L_main2
;unit_01_09_WPUR.c,71 :: 		PORTD.RD0 =~LATD.RD0;   // Toggle the LED
	BTFSC       LATD+0, 0 
	GOTO        L__main5
	BSF         PORTD+0, 0 
	GOTO        L__main6
L__main5:
	BCF         PORTD+0, 0 
L__main6:
;unit_01_09_WPUR.c,72 :: 		Delay_ms(300);           // Delay .3 s
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;unit_01_09_WPUR.c,73 :: 		}
L_main2:
;unit_01_09_WPUR.c,74 :: 		}
	GOTO        L_main0
;unit_01_09_WPUR.c,75 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
