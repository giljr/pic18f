
_main:

;unit_01_05_Chasing_LED.c,40 :: 		void main() {
;unit_01_05_Chasing_LED.c,41 :: 		unsigned char j = 1 ;
	MOVLW       1
	MOVWF       main_j_L0+0 
;unit_01_05_Chasing_LED.c,47 :: 		ADCON1 |= 0X0F;               // Config all ADC's pins as digital on PIC18F4520
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit_01_05_Chasing_LED.c,50 :: 		TRISB = 0;                        // Config PORTB as output
	CLRF        TRISB+0 
;unit_01_05_Chasing_LED.c,51 :: 		PORTB = 0;                        // Optional, the MCU do it automatically ;)
	CLRF        PORTB+0 
;unit_01_05_Chasing_LED.c,54 :: 		for(;;)                              // Endless loop
L_main0:
;unit_01_05_Chasing_LED.c,56 :: 		PORTB = j;                   // Send j to PORTB
	MOVF        main_j_L0+0, 0 
	MOVWF       PORTB+0 
;unit_01_05_Chasing_LED.c,57 :: 		Delay_ms(100);               // Delay 1 s
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
;unit_01_05_Chasing_LED.c,58 :: 		j = j << 1;                  // Shift left j
	MOVF        main_j_L0+0, 0 
	MOVWF       R1 
	RLCF        R1, 1 
	BCF         R1, 0 
	MOVF        R1, 0 
	MOVWF       main_j_L0+0 
;unit_01_05_Chasing_LED.c,59 :: 		if(j == 0) j = 1;            // If last LED, move to first one
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
	MOVLW       1
	MOVWF       main_j_L0+0 
L_main4:
;unit_01_05_Chasing_LED.c,61 :: 		}
	GOTO        L_main0
;unit_01_05_Chasing_LED.c,62 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
