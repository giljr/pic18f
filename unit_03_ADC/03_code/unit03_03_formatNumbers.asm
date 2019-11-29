
_ConfigMCU:

;unit03_03_formatNumbers.c,109 :: 		void ConfigMCU()                     // Config MCU's PORTS
;unit03_03_formatNumbers.c,116 :: 		ADCON1 |= 0B00001101;              // AN0 e AN1 see datasheet
	MOVLW       13
	IORWF       ADCON1+0, 1 
;unit03_03_formatNumbers.c,119 :: 		TRISA.RA0 = 1;
	BSF         TRISA+0, 0 
;unit03_03_formatNumbers.c,120 :: 		PORTA.RA0 = 1;
	BSF         PORTA+0, 0 
;unit03_03_formatNumbers.c,122 :: 		TRISA.RA1 = 1;
	BSF         TRISA+0, 1 
;unit03_03_formatNumbers.c,123 :: 		PORTA.RA1 = 1;
	BSF         PORTA+0, 1 
;unit03_03_formatNumbers.c,125 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_main:

;unit03_03_formatNumbers.c,126 :: 		void main(){
;unit03_03_formatNumbers.c,130 :: 		ConfigMCU();                       // Init MCU
	CALL        _ConfigMCU+0, 0
;unit03_03_formatNumbers.c,132 :: 		Lcd_Init();                        // Init display Mode 4 bits
	CALL        _Lcd_Init+0, 0
;unit03_03_formatNumbers.c,133 :: 		Lcd_Cmd(_LCD_CLEAR);               // Display clear
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit03_03_formatNumbers.c,134 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit03_03_formatNumbers.c,135 :: 		Lcd_Out(1,1,"S1:");                // Line x Column
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_unit03_03_formatNumbers+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_unit03_03_formatNumbers+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit03_03_formatNumbers.c,136 :: 		Lcd_Out(2,1,"S2:");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_unit03_03_formatNumbers+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_unit03_03_formatNumbers+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit03_03_formatNumbers.c,138 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;unit03_03_formatNumbers.c,140 :: 		while(TRUE)
L_main0:
;unit03_03_formatNumbers.c,143 :: 		read_ADC = ADC_Read(0);           // S1 -> AN0
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
;unit03_03_formatNumbers.c,145 :: 		read_ADC = (int)read_ADC * (100./1023.);
	CALL        _int2double+0, 0
	MOVLW       13
	MOVWF       R4 
	MOVLW       50
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       123
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2word+0, 0
;unit03_03_formatNumbers.c,146 :: 		WordToStr(read_ADC, txt);        // 65535 + 0 = 6 positions
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;unit03_03_formatNumbers.c,147 :: 		LCD_Out(1,4, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit03_03_formatNumbers.c,148 :: 		LCD_Chr_Cp('%');
	MOVLW       37
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;unit03_03_formatNumbers.c,149 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	NOP
	NOP
;unit03_03_formatNumbers.c,152 :: 		read_ADC = ADC_Read(1);           // S1 -> AN0
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
;unit03_03_formatNumbers.c,154 :: 		read_ADC = (int)read_ADC * (255./1023.);
	CALL        _int2double+0, 0
	MOVLW       208
	MOVWF       R4 
	MOVLW       63
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       124
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2word+0, 0
;unit03_03_formatNumbers.c,155 :: 		WordToStr(read_ADC, txt);         // 65535 + 0 = 6 positions
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;unit03_03_formatNumbers.c,156 :: 		LCD_Out(2,4, txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit03_03_formatNumbers.c,157 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	NOP
	NOP
;unit03_03_formatNumbers.c,158 :: 		}
	GOTO        L_main0
;unit03_03_formatNumbers.c,159 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
