
_main:

;unit_01_02_pushAndBlinkAnLED.c,39 :: 		void main() {
;unit_01_02_pushAndBlinkAnLED.c,46 :: 		ADCON1 |= 0X0F; // Config all ADC's pins as digital on PIC18F4520
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit_01_02_pushAndBlinkAnLED.c,51 :: 		TRISB.RB0 = 1;       // Config RB0 as Input (1=I:)
	BSF         TRISB+0, 0 
;unit_01_02_pushAndBlinkAnLED.c,52 :: 		PORTB.RB0 = 1;       // Optional, the MCU do it automatically ;)
	BSF         PORTB+0, 0 
;unit_01_02_pushAndBlinkAnLED.c,55 :: 		TRISD = 0;           // Config all PORTD's pins as Output (0=0:)
	CLRF        TRISD+0 
;unit_01_02_pushAndBlinkAnLED.c,56 :: 		PORTD = 0;           // Config all PORTD's pins as LOW,
	CLRF        PORTD+0 
;unit_01_02_pushAndBlinkAnLED.c,64 :: 		while(1)
L_main0:
;unit_01_02_pushAndBlinkAnLED.c,68 :: 		if(PORTB.RB0 == 0 )
	BTFSC       PORTB+0, 0 
	GOTO        L_main2
;unit_01_02_pushAndBlinkAnLED.c,74 :: 		PORTD.RD0 = ~ LATD.RD0;
	BTFSC       LATD+0, 0 
	GOTO        L__main5
	BSF         PORTD+0, 0 
	GOTO        L__main6
L__main5:
	BCF         PORTD+0, 0 
L__main6:
;unit_01_02_pushAndBlinkAnLED.c,75 :: 		Delay_ms(300);
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
;unit_01_02_pushAndBlinkAnLED.c,76 :: 		}
L_main2:
;unit_01_02_pushAndBlinkAnLED.c,78 :: 		}
	GOTO        L_main0
;unit_01_02_pushAndBlinkAnLED.c,79 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
