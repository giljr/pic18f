
_main:

;unit_01_06_DoubleChasing_LED.c,42 :: 		void main() {
;unit_01_06_DoubleChasing_LED.c,43 :: 		unsigned char j = 0b10000000 ;   // Initialize j as char (0b notation)
	MOVLW       128
	MOVWF       main_j_L0+0 
	MOVLW       1
	MOVWF       main_l_L0+0 
;unit_01_06_DoubleChasing_LED.c,49 :: 		ADCON1 |= 0X0F;               // Config all ADC's pins as digital on PIC18F4520
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit_01_06_DoubleChasing_LED.c,52 :: 		TRISB = 0;                        // Config PORTB as output
	CLRF        TRISB+0 
;unit_01_06_DoubleChasing_LED.c,53 :: 		PORTB = 0;                        // Optional, the MCU do it automatically ;)
	CLRF        PORTB+0 
;unit_01_06_DoubleChasing_LED.c,56 :: 		for(;;)                              // Endless loop
L_main0:
;unit_01_06_DoubleChasing_LED.c,58 :: 		PORTB = (j|l);
	MOVF        main_l_L0+0, 0 
	IORWF       main_j_L0+0, 0 
	MOVWF       PORTB+0 
;unit_01_06_DoubleChasing_LED.c,59 :: 		j>>=1;                       // Cycle j bits
	MOVF        main_j_L0+0, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	MOVWF       main_j_L0+0 
;unit_01_06_DoubleChasing_LED.c,60 :: 		l<<=1;                       // Cycle l bits
	RLCF        main_l_L0+0, 1 
	BCF         main_l_L0+0, 0 
;unit_01_06_DoubleChasing_LED.c,61 :: 		if(j==0) j = 0b10000000;     // Reset j if zero
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
	MOVLW       128
	MOVWF       main_j_L0+0 
L_main3:
;unit_01_06_DoubleChasing_LED.c,62 :: 		if(l==0) l = 0b00000001;     // Reset l if zero
	MOVF        main_l_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
	MOVLW       1
	MOVWF       main_l_L0+0 
L_main4:
;unit_01_06_DoubleChasing_LED.c,63 :: 		Delay_ms(100);               // Delay .1 s
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
	NOP
;unit_01_06_DoubleChasing_LED.c,64 :: 		}
	GOTO        L_main0
;unit_01_06_DoubleChasing_LED.c,65 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
