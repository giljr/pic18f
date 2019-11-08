
_main:

;unit_01_01_blinkingAnLED.c,40 :: 		void main() {
;unit_01_01_blinkingAnLED.c,47 :: 		ADCON1 |= 0X0F;     // Config all ADC's pins as digital
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit_01_01_blinkingAnLED.c,52 :: 		TRISB.RB0 = 1;           // Config RB0 as Input (1=I:)
	BSF         TRISB+0, 0 
;unit_01_01_blinkingAnLED.c,53 :: 		PORTB.RB0 = 1;           // Optional, the MCU do it automatically ;)
	BSF         PORTB+0, 0 
;unit_01_01_blinkingAnLED.c,56 :: 		TRISD = 0;               // Config all PORTD's pins as Output (0=0:)
	CLRF        TRISD+0 
;unit_01_01_blinkingAnLED.c,57 :: 		PORTD = 0;               // Config all PORTD's pins as LOW,
	CLRF        PORTD+0 
;unit_01_01_blinkingAnLED.c,65 :: 		while(1)
L_main0:
;unit_01_01_blinkingAnLED.c,67 :: 		PORTD.RD0 = 1;     // Turn LED on
	BSF         PORTD+0, 0 
;unit_01_01_blinkingAnLED.c,68 :: 		Delay_ms(300);     // delay 300 ms
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
	NOP
;unit_01_01_blinkingAnLED.c,69 :: 		PORTD.RD0 = 0;     // Turn LED off
	BCF         PORTD+0, 0 
;unit_01_01_blinkingAnLED.c,70 :: 		Delay_ms(300);     // delay 300 ms
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
;unit_01_01_blinkingAnLED.c,71 :: 		}
	GOTO        L_main0
;unit_01_01_blinkingAnLED.c,72 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
