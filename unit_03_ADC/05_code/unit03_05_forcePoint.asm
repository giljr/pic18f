
_main:

;unit03_05_forcePoint.c,70 :: 		void main(){
;unit03_05_forcePoint.c,71 :: 		unsigned int Valor_ADC = 0;
;unit03_05_forcePoint.c,79 :: 		TRISA.RA0 = 1;
	BSF         TRISA+0, 0 
;unit03_05_forcePoint.c,80 :: 		ADCON1 = 0B00001101;                       //Configure RA0/AN0 and RA1/AN1 as ADC
	MOVLW       13
	MOVWF       ADCON1+0 
;unit03_05_forcePoint.c,83 :: 		Lcd_Init();                                // Initialize Lcd
	CALL        _Lcd_Init+0, 0
;unit03_05_forcePoint.c,84 :: 		Lcd_Cmd(_LCD_CLEAR);                       // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit03_05_forcePoint.c,85 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                  // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit03_05_forcePoint.c,86 :: 		Lcd_Out(1,1,"ADC1:");                      // Write line x Colunm to LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_unit03_05_forcePoint+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_unit03_05_forcePoint+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit03_05_forcePoint.c,88 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;unit03_05_forcePoint.c,90 :: 		while(TRUE)
L_main0:
;unit03_05_forcePoint.c,92 :: 		Valor_ADC = ADC_Read(1);
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
;unit03_05_forcePoint.c,93 :: 		Valor_ADC = Valor_ADC * (1023/1023.);    //0 to 1023 -> 0 to 1234
	CALL        _word2double+0, 0
	CALL        _double2word+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
;unit03_05_forcePoint.c,94 :: 		Tensao[0] = (Valor_ADC/1000) + '0';      // 6 + '0'  = '6'
	MOVLW       48
	ADDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       main_Tensao_L0+0 
;unit03_05_forcePoint.c,95 :: 		Tensao[1] = (Valor_ADC/100)%10 + '0';    //'6' - '0' = 6
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       main_Tensao_L0+1 
;unit03_05_forcePoint.c,96 :: 		Tensao[2] = '.';
	MOVLW       46
	MOVWF       main_Tensao_L0+2 
;unit03_05_forcePoint.c,97 :: 		Tensao[3] = (Valor_ADC/10)%10 + '0';
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       main_Tensao_L0+3 
;unit03_05_forcePoint.c,98 :: 		Tensao[4] = (Valor_ADC/1)%10 + '0';
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       main_Tensao_L0+4 
;unit03_05_forcePoint.c,99 :: 		Tensao[5] = 0;                           // terminator NULL
	CLRF        main_Tensao_L0+5 
;unit03_05_forcePoint.c,100 :: 		Lcd_Out(1,6,Tensao);                     // Show numbers at display
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_Tensao_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_Tensao_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit03_05_forcePoint.c,101 :: 		}
	GOTO        L_main0
;unit03_05_forcePoint.c,102 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
