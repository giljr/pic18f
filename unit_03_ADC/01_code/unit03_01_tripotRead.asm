
_main:

;unit03_01_tripotRead.c,101 :: 		void main() {
;unit03_01_tripotRead.c,113 :: 		PORTA.RA0 = 1;                   // tripot at AN0
	BSF         PORTA+0, 0 
;unit03_01_tripotRead.c,114 :: 		TRISA.RA0 = 1;                   // optional
	BSF         TRISA+0, 0 
;unit03_01_tripotRead.c,116 :: 		ADCON0 = 0B00000001;             // ADC Configurations bits - ADC on
	MOVLW       1
	MOVWF       ADCON0+0 
;unit03_01_tripotRead.c,117 :: 		ADCON1 = 0B00001110;             // AN0 as AD, Internal REF V
	MOVLW       14
	MOVWF       ADCON1+0 
;unit03_01_tripotRead.c,118 :: 		ADCON2 = 0B10101010;             // Right justify, FOSC/32, 12 TAD
	MOVLW       170
	MOVWF       ADCON2+0 
;unit03_01_tripotRead.c,120 :: 		Lcd_Init();                      // Init LCD, 4-bit Mode
	CALL        _Lcd_Init+0, 0
;unit03_01_tripotRead.c,121 :: 		Lcd_Cmd(_LCD_CLEAR);             // Clear LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit03_01_tripotRead.c,122 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);        // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit03_01_tripotRead.c,123 :: 		Lcd_Out(1, 1, "ADC: ");          // line x Column
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_unit03_01_tripotRead+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_unit03_01_tripotRead+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit03_01_tripotRead.c,125 :: 		while (TRUE)
L_main0:
;unit03_01_tripotRead.c,127 :: 		ADCON0.GO_DONE = 1;        // Init ADC
	BSF         ADCON0+0, 1 
;unit03_01_tripotRead.c,129 :: 		while(ADCON0.GO_DONE == 1);
L_main2:
	BTFSS       ADCON0+0, 1 
	GOTO        L_main3
	GOTO        L_main2
L_main3:
;unit03_01_tripotRead.c,130 :: 		ADC_read = ((ADRESH << 8)| (int)ADRESL);
	MOVF        ADRESH+0, 0 
	MOVWF       FARG_WordToStr_input+1 
	CLRF        FARG_WordToStr_input+0 
	MOVF        ADRESL+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R0, 0 
	IORWF       FARG_WordToStr_input+0, 1 
	MOVF        R1, 0 
	IORWF       FARG_WordToStr_input+1, 1 
;unit03_01_tripotRead.c,131 :: 		WordToStr(ADC_read, txt);
	MOVLW       main_txt_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;unit03_01_tripotRead.c,132 :: 		LCD_Out(1, 8, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit03_01_tripotRead.c,133 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	NOP
	NOP
;unit03_01_tripotRead.c,134 :: 		}
	GOTO        L_main0
;unit03_01_tripotRead.c,136 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
