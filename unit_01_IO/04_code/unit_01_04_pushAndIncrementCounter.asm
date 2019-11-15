
_increment:

;unit_01_04_pushAndIncrementCounter.c,58 :: 		void increment (unsigned char counter)
;unit_01_04_pushAndIncrementCounter.c,60 :: 		switch (counter)
	GOTO        L_increment0
;unit_01_04_pushAndIncrementCounter.c,62 :: 		case 1:{PORTD.RD0 = 1; break;}
L_increment2:
	BSF         PORTD+0, 0 
	GOTO        L_increment1
;unit_01_04_pushAndIncrementCounter.c,63 :: 		case 2:{PORTD.RD1 = 1; break;}
L_increment3:
	BSF         PORTD+0, 1 
	GOTO        L_increment1
;unit_01_04_pushAndIncrementCounter.c,64 :: 		case 3:{PORTD.RD2 = 1; break;}
L_increment4:
	BSF         PORTD+0, 2 
	GOTO        L_increment1
;unit_01_04_pushAndIncrementCounter.c,65 :: 		case 4:{PORTD.RD3 = 1; break;}
L_increment5:
	BSF         PORTD+0, 3 
	GOTO        L_increment1
;unit_01_04_pushAndIncrementCounter.c,66 :: 		case 5:{PORTD.RD4 = 1; break;}
L_increment6:
	BSF         PORTD+0, 4 
	GOTO        L_increment1
;unit_01_04_pushAndIncrementCounter.c,67 :: 		case 6:{PORTD.RD5 = 1; break;}
L_increment7:
	BSF         PORTD+0, 5 
	GOTO        L_increment1
;unit_01_04_pushAndIncrementCounter.c,68 :: 		case 7:{PORTD.RD6 = 1; break;}
L_increment8:
	BSF         PORTD+0, 6 
	GOTO        L_increment1
;unit_01_04_pushAndIncrementCounter.c,69 :: 		case 8:{PORTD.RD7 = 1; break;}
L_increment9:
	BSF         PORTD+0, 7 
	GOTO        L_increment1
;unit_01_04_pushAndIncrementCounter.c,70 :: 		default: {PORTD = 0; MyCounter = 0; break;}
L_increment10:
	CLRF        PORTD+0 
	CLRF        _myCounter+0 
	GOTO        L_increment1
;unit_01_04_pushAndIncrementCounter.c,71 :: 		}
L_increment0:
	MOVF        FARG_increment_counter+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_increment2
	MOVF        FARG_increment_counter+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_increment3
	MOVF        FARG_increment_counter+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_increment4
	MOVF        FARG_increment_counter+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_increment5
	MOVF        FARG_increment_counter+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_increment6
	MOVF        FARG_increment_counter+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_increment7
	MOVF        FARG_increment_counter+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_increment8
	MOVF        FARG_increment_counter+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_increment9
	GOTO        L_increment10
L_increment1:
;unit_01_04_pushAndIncrementCounter.c,72 :: 		}
L_end_increment:
	RETURN      0
; end of _increment

_main:

;unit_01_04_pushAndIncrementCounter.c,74 :: 		void main() {
;unit_01_04_pushAndIncrementCounter.c,75 :: 		unsigned char flag = 0;              // Auxiliary flag to button's seal-in;
	CLRF        main_flag_L0+0 
;unit_01_04_pushAndIncrementCounter.c,83 :: 		ADCON1 |= 0X0F;               // Config all ADC's pins as digital on PIC18F4520
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit_01_04_pushAndIncrementCounter.c,88 :: 		TRISB.RB0 = 1;                     // Config RB0 as Input (1=I:)
	BSF         TRISB+0, 0 
;unit_01_04_pushAndIncrementCounter.c,89 :: 		PORTB.RB0 = 1;                     // Optional, the MCU do it automatically ;)
	BSF         PORTB+0, 0 
;unit_01_04_pushAndIncrementCounter.c,92 :: 		TRISD = 0;                         // Config all PORTD's pins as Output (0=0:)
	CLRF        TRISD+0 
;unit_01_04_pushAndIncrementCounter.c,93 :: 		PORTD = 0;                         // Config all PORTD's pins as LOW,
	CLRF        PORTD+0 
;unit_01_04_pushAndIncrementCounter.c,101 :: 		while(1)
L_main11:
;unit_01_04_pushAndIncrementCounter.c,106 :: 		if(PORTB.RB0 == 0 && flag == 0 )
	BTFSC       PORTB+0, 0 
	GOTO        L_main15
	MOVF        main_flag_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
L__main22:
;unit_01_04_pushAndIncrementCounter.c,110 :: 		increment(++myCounter);
	INCF        _myCounter+0, 1 
	MOVF        _myCounter+0, 0 
	MOVWF       FARG_increment_counter+0 
	CALL        _increment+0, 0
;unit_01_04_pushAndIncrementCounter.c,111 :: 		flag = 1;                // force breaking this loop when the user are still pressing the button (the MC works in nonoseconds;)
	MOVLW       1
	MOVWF       main_flag_L0+0 
;unit_01_04_pushAndIncrementCounter.c,112 :: 		Delay_ms(40);            // treat debounce
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main16:
	DECFSZ      R13, 1, 1
	BRA         L_main16
	DECFSZ      R12, 1, 1
	BRA         L_main16
	NOP
;unit_01_04_pushAndIncrementCounter.c,113 :: 		}
L_main15:
;unit_01_04_pushAndIncrementCounter.c,115 :: 		if(PORTB.RB0 == 1 && flag == 1 )
	BTFSS       PORTB+0, 0 
	GOTO        L_main19
	MOVF        main_flag_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main19
L__main21:
;unit_01_04_pushAndIncrementCounter.c,117 :: 		flag = 0;                // Resetting the flag just when the user release the button; ready for the first loop; init cycle loop again:)
	CLRF        main_flag_L0+0 
;unit_01_04_pushAndIncrementCounter.c,118 :: 		Delay_ms(40);            // treat debounce
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main20:
	DECFSZ      R13, 1, 1
	BRA         L_main20
	DECFSZ      R12, 1, 1
	BRA         L_main20
	NOP
;unit_01_04_pushAndIncrementCounter.c,119 :: 		}
L_main19:
;unit_01_04_pushAndIncrementCounter.c,121 :: 		}
	GOTO        L_main11
;unit_01_04_pushAndIncrementCounter.c,122 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
