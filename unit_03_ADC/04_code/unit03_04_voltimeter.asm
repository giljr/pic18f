
_ConfigMCU:

;unit03_04_voltimeter.c,108 :: 		void ConfigMCU()                     // Config MCU's PORTS
;unit03_04_voltimeter.c,115 :: 		ADCON1 |= 0B00001101;              // AN0 e AN1 see datasheet
	MOVLW       13
	IORWF       ADCON1+0, 1 
;unit03_04_voltimeter.c,118 :: 		TRISA.RA0 = 1;
	BSF         TRISA+0, 0 
;unit03_04_voltimeter.c,119 :: 		PORTA.RA0 = 1;
	BSF         PORTA+0, 0 
;unit03_04_voltimeter.c,121 :: 		TRISA.RA1 = 1;
	BSF         TRISA+0, 1 
;unit03_04_voltimeter.c,122 :: 		PORTA.RA1 = 1;
	BSF         PORTA+0, 1 
;unit03_04_voltimeter.c,124 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_main:

;unit03_04_voltimeter.c,125 :: 		void main(){
;unit03_04_voltimeter.c,130 :: 		ConfigMCU();                       // Init MCU
	CALL        _ConfigMCU+0, 0
;unit03_04_voltimeter.c,132 :: 		Lcd_Init();                        // Init display Mode 4 bits
	CALL        _Lcd_Init+0, 0
;unit03_04_voltimeter.c,133 :: 		Lcd_Cmd(_LCD_CLEAR);               // Display clear
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit03_04_voltimeter.c,134 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit03_04_voltimeter.c,135 :: 		Lcd_Out(1,1,"Voltimeter v1");         // Line x Column
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_unit03_04_voltimeter+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_unit03_04_voltimeter+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit03_04_voltimeter.c,136 :: 		Delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
;unit03_04_voltimeter.c,138 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;unit03_04_voltimeter.c,140 :: 		while(TRUE)
L_main1:
;unit03_04_voltimeter.c,142 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit03_04_voltimeter.c,144 :: 		Vin = ADC_Read(1);                // S1 -> AN0
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_Vin_L0+0 
	MOVF        R1, 0 
	MOVWF       main_Vin_L0+1 
	MOVLW       0
	MOVWF       main_Vin_L0+2 
	MOVWF       main_Vin_L0+3 
;unit03_04_voltimeter.c,147 :: 		Lcd_Out(1,1,"mV = ");             // Display "mV = "
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_unit03_04_voltimeter+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_unit03_04_voltimeter+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit03_04_voltimeter.c,148 :: 		mV = (Vin * 5000) >> 10;          // mv = Vin x 5000/1024
	MOVF        main_Vin_L0+0, 0 
	MOVWF       R0 
	MOVF        main_Vin_L0+1, 0 
	MOVWF       R1 
	MOVF        main_Vin_L0+2, 0 
	MOVWF       R2 
	MOVF        main_Vin_L0+3, 0 
	MOVWF       R3 
	MOVLW       136
	MOVWF       R4 
	MOVLW       19
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVF        R0, 0 
	MOVWF       FARG_LongToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_LongToStr_input+1 
	MOVF        R2, 0 
	MOVWF       FARG_LongToStr_input+2 
	MOVF        R3, 0 
	MOVWF       FARG_LongToStr_input+3 
	MOVF        R4, 0 
L__main6:
	BZ          L__main7
	RRCF        FARG_LongToStr_input+3, 1 
	RRCF        FARG_LongToStr_input+2, 1 
	RRCF        FARG_LongToStr_input+1, 1 
	RRCF        FARG_LongToStr_input+0, 1 
	BCF         FARG_LongToStr_input+3, 7 
	ADDLW       255
	GOTO        L__main6
L__main7:
;unit03_04_voltimeter.c,149 :: 		LongToStr(mV,txt);                // Convert to string in "op"
	MOVLW       main_txt_L0+0
	MOVWF       FARG_LongToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_LongToStr_output+1 
	CALL        _LongToStr+0, 0
;unit03_04_voltimeter.c,150 :: 		str = Ltrim(txt);                 // Remove leading spaces
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;unit03_04_voltimeter.c,153 :: 		Lcd_Out(1,6,str);                 // Output to LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        R1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit03_04_voltimeter.c,154 :: 		Delay_ms(1000);                   // Wait 1 s
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
;unit03_04_voltimeter.c,155 :: 		}
	GOTO        L_main1
;unit03_04_voltimeter.c,156 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
