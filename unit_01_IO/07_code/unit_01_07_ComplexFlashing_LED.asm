
_main:

;unit_01_07_ComplexFlashing_LED.c,36 :: 		void main()
;unit_01_07_ComplexFlashing_LED.c,42 :: 		ADCON1 |= 0X0F;               // Config all ADC's pins as digital on PIC18F4520
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit_01_07_ComplexFlashing_LED.c,45 :: 		TRISB = 0;                        // Config PORTB as output
	CLRF        TRISB+0 
;unit_01_07_ComplexFlashing_LED.c,46 :: 		PORTB = 0;                        // Optional, the MCU do it automatically ;)
	CLRF        PORTB+0 
;unit_01_07_ComplexFlashing_LED.c,49 :: 		for(;;)                            // Endless loop
L_main0:
;unit_01_07_ComplexFlashing_LED.c,51 :: 		for(i = 0; i < 3; i++)         // Do 3 times
	CLRF        R1 
L_main3:
	MOVLW       3
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main4
;unit_01_07_ComplexFlashing_LED.c,53 :: 		PORTB.RB0 = 1;           // LED ON
	BSF         PORTB+0, 0 
;unit_01_07_ComplexFlashing_LED.c,54 :: 		Delay_ms(200);           // 200 ms delay
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	NOP
;unit_01_07_ComplexFlashing_LED.c,55 :: 		PORTB.RB0 = 0;           // LED OFF
	BCF         PORTB+0, 0 
;unit_01_07_ComplexFlashing_LED.c,56 :: 		Delay_ms(200);           // 200 ms delay
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	NOP
;unit_01_07_ComplexFlashing_LED.c,51 :: 		for(i = 0; i < 3; i++)         // Do 3 times
	INCF        R1, 1 
;unit_01_07_ComplexFlashing_LED.c,57 :: 		}
	GOTO        L_main3
L_main4:
;unit_01_07_ComplexFlashing_LED.c,58 :: 		Delay_ms(2000);            // 2 s delay
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
	DECFSZ      R12, 1, 1
	BRA         L_main8
	DECFSZ      R11, 1, 1
	BRA         L_main8
	NOP
	NOP
;unit_01_07_ComplexFlashing_LED.c,59 :: 		}
	GOTO        L_main0
;unit_01_07_ComplexFlashing_LED.c,60 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
