
_configMCU:

;unit_01_11_UpDownCounter.c,30 :: 		void configMCU()
;unit_01_11_UpDownCounter.c,35 :: 		ADCON1 |= 0X0F;               // Config all ADC's pins as digital on PIC18F4520
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit_01_11_UpDownCounter.c,38 :: 		TRISB.RB0 = 1;                   // Config PORTB.RB0 as input (UP key)
	BSF         TRISB+0, 0 
;unit_01_11_UpDownCounter.c,39 :: 		PORTB.RB0 = 1;                   // Optional, the MCU do it automatically ;)
	BSF         PORTB+0, 0 
;unit_01_11_UpDownCounter.c,41 :: 		TRISB.RB1 = 1;                   // Config PORTB.RB1 as input (DOWN key)
	BSF         TRISB+0, 1 
;unit_01_11_UpDownCounter.c,42 :: 		PORTB.RB1 = 1;                   // Optional, the MCU do it automatically ;)
	BSF         PORTB+0, 1 
;unit_01_11_UpDownCounter.c,44 :: 		TRISD = 0;                       // Config PORTD as output
	CLRF        TRISD+0 
;unit_01_11_UpDownCounter.c,45 :: 		PORTD = 0;                       // Turn off all the LEDs on PORTD
	CLRF        PORTD+0 
;unit_01_11_UpDownCounter.c,46 :: 		}
L_end_configMCU:
	RETURN      0
; end of _configMCU

_main:

;unit_01_11_UpDownCounter.c,47 :: 		void main()
;unit_01_11_UpDownCounter.c,49 :: 		unsigned char flag1 = 0;        // auxiliary flag to manipulate key's pulses
	CLRF        main_flag1_L0+0 
	CLRF        main_flag2_L0+0 
;unit_01_11_UpDownCounter.c,52 :: 		configMCU();                    // Config all the MCU
	CALL        _configMCU+0, 0
;unit_01_11_UpDownCounter.c,54 :: 		while(TRUE)                      // Endless loop
L_main0:
;unit_01_11_UpDownCounter.c,56 :: 		if(BTN_UP == 0 && flag1 == 0 && LEDS < 255)
	BTFSC       PORTB+0, 0 
	GOTO        L_main4
	MOVF        main_flag1_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
	MOVLW       255
	SUBWF       PORTD+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main4
L__main21:
;unit_01_11_UpDownCounter.c,58 :: 		if (LEDS == 0) {LEDS = 0b00000001;}
	MOVF        PORTD+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
	MOVLW       1
	MOVWF       PORTD+0 
	GOTO        L_main6
L_main5:
;unit_01_11_UpDownCounter.c,60 :: 		LEDS = (LEDS << 1)| LEDS;
	MOVF        PORTD+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	IORWF       PORTD+0, 1 
L_main6:
;unit_01_11_UpDownCounter.c,61 :: 		flag1 = 1;
	MOVLW       1
	MOVWF       main_flag1_L0+0 
;unit_01_11_UpDownCounter.c,62 :: 		}
L_main4:
;unit_01_11_UpDownCounter.c,63 :: 		if(BTN_UP == 1 && flag1 == 1)
	BTFSS       PORTB+0, 0 
	GOTO        L_main9
	MOVF        main_flag1_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
L__main20:
;unit_01_11_UpDownCounter.c,65 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main10:
	DECFSZ      R13, 1, 1
	BRA         L_main10
	DECFSZ      R12, 1, 1
	BRA         L_main10
	NOP
	NOP
;unit_01_11_UpDownCounter.c,66 :: 		flag1 = 0;
	CLRF        main_flag1_L0+0 
;unit_01_11_UpDownCounter.c,67 :: 		}
L_main9:
;unit_01_11_UpDownCounter.c,68 :: 		if(BTN_DOWN == 0 && flag2 == 0 && LEDS > 0)
	BTFSC       PORTB+0, 1 
	GOTO        L_main13
	MOVF        main_flag2_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main13
	MOVF        PORTD+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main13
L__main19:
;unit_01_11_UpDownCounter.c,70 :: 		LEDS = (LEDS/2);
	MOVF        PORTD+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	MOVWF       PORTD+0 
;unit_01_11_UpDownCounter.c,71 :: 		flag2 = 1;
	MOVLW       1
	MOVWF       main_flag2_L0+0 
;unit_01_11_UpDownCounter.c,72 :: 		}
L_main13:
;unit_01_11_UpDownCounter.c,73 :: 		if(BTN_DOWN == 1 && flag2 == 1)
	BTFSS       PORTB+0, 1 
	GOTO        L_main16
	MOVF        main_flag2_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main16
L__main18:
;unit_01_11_UpDownCounter.c,75 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main17:
	DECFSZ      R13, 1, 1
	BRA         L_main17
	DECFSZ      R12, 1, 1
	BRA         L_main17
	NOP
	NOP
;unit_01_11_UpDownCounter.c,76 :: 		flag2 = 0;
	CLRF        main_flag2_L0+0 
;unit_01_11_UpDownCounter.c,77 :: 		}
L_main16:
;unit_01_11_UpDownCounter.c,78 :: 		}
	GOTO        L_main0
;unit_01_11_UpDownCounter.c,79 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
