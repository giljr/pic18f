
_main:

;unit_01_03_pushAndBlinkAndDebounce.c,56 :: 		void main() {
;unit_01_03_pushAndBlinkAndDebounce.c,57 :: 		unsigned char flag = 0;              // Auxiliary flag to button's seal-in;
	CLRF        main_flag_L0+0 
;unit_01_03_pushAndBlinkAndDebounce.c,65 :: 		ADCON1 |= 0X0F;               // Config all ADC's pins as digital on PIC18F4520
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit_01_03_pushAndBlinkAndDebounce.c,70 :: 		TRISB.RB0 = 1;                     // Config RB0 as Input (1=I:)
	BSF         TRISB+0, 0 
;unit_01_03_pushAndBlinkAndDebounce.c,71 :: 		PORTB.RB0 = 1;                     // Optional, the MCU do it automatically ;)
	BSF         PORTB+0, 0 
;unit_01_03_pushAndBlinkAndDebounce.c,74 :: 		TRISD = 0;                         // Config all PORTD's pins as Output (0=0:)
	CLRF        TRISD+0 
;unit_01_03_pushAndBlinkAndDebounce.c,75 :: 		PORTD = 0;                         // Config all PORTD's pins as LOW,
	CLRF        PORTD+0 
;unit_01_03_pushAndBlinkAndDebounce.c,83 :: 		while(1)
L_main0:
;unit_01_03_pushAndBlinkAndDebounce.c,88 :: 		if(PORTB.RB0 == 0 && flag == 0 )
	BTFSC       PORTB+0, 0 
	GOTO        L_main4
	MOVF        main_flag_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
L__main11:
;unit_01_03_pushAndBlinkAndDebounce.c,91 :: 		PORTD.RD0 = ~ LATD.RD0;
	BTFSC       LATD+0, 0 
	GOTO        L__main13
	BSF         PORTD+0, 0 
	GOTO        L__main14
L__main13:
	BCF         PORTD+0, 0 
L__main14:
;unit_01_03_pushAndBlinkAndDebounce.c,92 :: 		flag = 1;                // force breaking this loop when the user are still pressing the button (the MC works in nonoseconds;)
	MOVLW       1
	MOVWF       main_flag_L0+0 
;unit_01_03_pushAndBlinkAndDebounce.c,93 :: 		Delay_ms(40);            // treat debounce
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	NOP
;unit_01_03_pushAndBlinkAndDebounce.c,94 :: 		}
L_main4:
;unit_01_03_pushAndBlinkAndDebounce.c,96 :: 		if(PORTB.RB0 == 1 && flag == 1 )
	BTFSS       PORTB+0, 0 
	GOTO        L_main8
	MOVF        main_flag_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main8
L__main10:
;unit_01_03_pushAndBlinkAndDebounce.c,98 :: 		flag = 0;                // Resetting the flag just when the user release the button; ready for the first loop; init cycle again:)
	CLRF        main_flag_L0+0 
;unit_01_03_pushAndBlinkAndDebounce.c,99 :: 		Delay_ms(40);            // treat debounce
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main9:
	DECFSZ      R13, 1, 1
	BRA         L_main9
	DECFSZ      R12, 1, 1
	BRA         L_main9
	NOP
;unit_01_03_pushAndBlinkAndDebounce.c,100 :: 		}
L_main8:
;unit_01_03_pushAndBlinkAndDebounce.c,102 :: 		}
	GOTO        L_main0
;unit_01_03_pushAndBlinkAndDebounce.c,103 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
