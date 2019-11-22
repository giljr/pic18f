
_main:

;unit_01_08_RandomFlashing_LED.c,35 :: 		void main()
;unit_01_08_RandomFlashing_LED.c,42 :: 		ADCON1 |= 0X0F;               // Config all ADC's pins as digital on PIC18F4520
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit_01_08_RandomFlashing_LED.c,45 :: 		TRISB = 0;                        // Config PORTB as output
	CLRF        TRISB+0 
;unit_01_08_RandomFlashing_LED.c,46 :: 		PORTB = 0;                        // Optional, the MCU do it automatically ;)
	CLRF        PORTB+0 
;unit_01_08_RandomFlashing_LED.c,48 :: 		srand(10);                       // Inialize random number seed
	MOVLW       10
	MOVWF       FARG_srand_x+0 
	MOVLW       0
	MOVWF       FARG_srand_x+1 
	CALL        _srand+0, 0
;unit_01_08_RandomFlashing_LED.c,50 :: 		for(;;)                          // Endless loop
L_main0:
;unit_01_08_RandomFlashing_LED.c,52 :: 		p = rand();                // Generate a random number
	CALL        _rand+0, 0
;unit_01_08_RandomFlashing_LED.c,53 :: 		p = p / 128;               // Number between 1 and 255
	MOVLW       7
	MOVWF       R4 
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__main5:
	BZ          L__main6
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	ADDLW       255
	GOTO        L__main5
L__main6:
;unit_01_08_RandomFlashing_LED.c,54 :: 		PORTB = p;                 // Send to PORTC
	MOVF        R2, 0 
	MOVWF       PORTB+0 
;unit_01_08_RandomFlashing_LED.c,55 :: 		Delay_ms(1000);            // 1 s delay
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
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
;unit_01_08_RandomFlashing_LED.c,56 :: 		}
	GOTO        L_main0
;unit_01_08_RandomFlashing_LED.c,57 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
