
_main:

;unit02_05_temp_LM35.c,103 :: 		void main(){
;unit02_05_temp_LM35.c,111 :: 		ADCON1 |= 0X0F;                     // Config all ADC's pins as digital
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit02_05_temp_LM35.c,114 :: 		Lcd_Init();                              // Initialize LCD
	CALL        _Lcd_Init+0, 0
;unit02_05_temp_LM35.c,116 :: 		Lcd_Cmd(_LCD_CLEAR);                     // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_05_temp_LM35.c,117 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_05_temp_LM35.c,120 :: 		for(;;)
L_main0:
;unit02_05_temp_LM35.c,122 :: 		temp = ADc_Read(2);                 // Read from channel 2
	MOVLW       2
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
;unit02_05_temp_LM35.c,123 :: 		mV = temp * 5000.0/1024.0;          // Convert to mV
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       64
	MOVWF       R5 
	MOVLW       28
	MOVWF       R6 
	MOVLW       139
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       137
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
;unit02_05_temp_LM35.c,124 :: 		mV = mV/10.0;                       // mV is now the Degrees C
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
;unit02_05_temp_LM35.c,125 :: 		floatToStr(mV, txt);                // Convert to string
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;unit02_05_temp_LM35.c,126 :: 		Lcd_cmd(_LCD_CLEAR);                // Clear LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_05_temp_LM35.c,127 :: 		Lcd_out(1,1,"Temperature");         // Display heading
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_unit02_05_temp_LM35+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_unit02_05_temp_LM35+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_05_temp_LM35.c,128 :: 		Lcd_Out(2,1,Txt);                   // Display temperature
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_05_temp_LM35.c,129 :: 		Delay_ms(1000);                     // Wait 1 s and repeat}
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
;unit02_05_temp_LM35.c,130 :: 		}
	GOTO        L_main0
;unit02_05_temp_LM35.c,131 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
