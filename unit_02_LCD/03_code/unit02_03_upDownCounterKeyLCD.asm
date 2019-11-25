
_main:

;unit02_03_upDownCounterKeyLCD.c,107 :: 		void main(){
;unit02_03_upDownCounterKeyLCD.c,108 :: 		signed int counter = 0 ;
	CLRF        main_counter_L0+0 
	CLRF        main_counter_L0+1 
;unit02_03_upDownCounterKeyLCD.c,114 :: 		ADCON1 |= 0X0F;                // Config all ADC's pins as digital
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit02_03_upDownCounterKeyLCD.c,117 :: 		TRISB.RB0 = 1;                      // Up key ON PORTB.RB0
	BSF         TRISB+0, 0 
;unit02_03_upDownCounterKeyLCD.c,118 :: 		PORTB.RB0 = 1;
	BSF         PORTB+0, 0 
;unit02_03_upDownCounterKeyLCD.c,120 :: 		TRISB.RB1 = 1;                      // Down key ON PORTB.RB3
	BSF         TRISB+0, 1 
;unit02_03_upDownCounterKeyLCD.c,121 :: 		PORTB.RB1 = 1;
	BSF         PORTB+0, 1 
;unit02_03_upDownCounterKeyLCD.c,123 :: 		Lcd_Init();                         // Initialize LCD
	CALL        _Lcd_Init+0, 0
;unit02_03_upDownCounterKeyLCD.c,125 :: 		Lcd_Cmd(_LCD_CLEAR);                // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_03_upDownCounterKeyLCD.c,126 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);           // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_03_upDownCounterKeyLCD.c,128 :: 		Lcd_Out(1, 1, "Value:");            // Write heading text in the first line
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_unit02_03_upDownCounterKeyLCD+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_unit02_03_upDownCounterKeyLCD+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_03_upDownCounterKeyLCD.c,130 :: 		while(TRUE)
L_main0:
;unit02_03_upDownCounterKeyLCD.c,132 :: 		if ( UP_KEY == 0 )
	BTFSC       PORTB+0, 0 
	GOTO        L_main2
;unit02_03_upDownCounterKeyLCD.c,134 :: 		counter++;
	INFSNZ      main_counter_L0+0, 1 
	INCF        main_counter_L0+1, 1 
;unit02_03_upDownCounterKeyLCD.c,135 :: 		WordToStr(counter, txt);
	MOVF        main_counter_L0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        main_counter_L0+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;unit02_03_upDownCounterKeyLCD.c,136 :: 		Lcd_Out(1,7, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_03_upDownCounterKeyLCD.c,137 :: 		Delay_ms(300);      // debouncing
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
;unit02_03_upDownCounterKeyLCD.c,138 :: 		}
L_main2:
;unit02_03_upDownCounterKeyLCD.c,140 :: 		if ( DOWN_KEY == 0 )
	BTFSC       PORTB+0, 1 
	GOTO        L_main4
;unit02_03_upDownCounterKeyLCD.c,142 :: 		counter--;
	MOVLW       1
	SUBWF       main_counter_L0+0, 1 
	MOVLW       0
	SUBWFB      main_counter_L0+1, 1 
;unit02_03_upDownCounterKeyLCD.c,143 :: 		WordToStr(counter, txt);
	MOVF        main_counter_L0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        main_counter_L0+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;unit02_03_upDownCounterKeyLCD.c,144 :: 		Lcd_Out(1,7, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_03_upDownCounterKeyLCD.c,145 :: 		Delay_ms(300);     // debouncing
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
	NOP
	NOP
;unit02_03_upDownCounterKeyLCD.c,146 :: 		}
L_main4:
;unit02_03_upDownCounterKeyLCD.c,148 :: 		}
	GOTO        L_main0
;unit02_03_upDownCounterKeyLCD.c,150 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
