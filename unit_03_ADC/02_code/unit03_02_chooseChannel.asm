
_ADCRead:

;unit03_02_ChooseChannel.c,110 :: 		unsigned int ADCRead(unsigned char channel)
;unit03_02_ChooseChannel.c,112 :: 		switch(channel)
	GOTO        L_ADCRead0
;unit03_02_ChooseChannel.c,115 :: 		case 0: {
L_ADCRead2:
;unit03_02_ChooseChannel.c,117 :: 		TRISA.RA0 = 1;             // Input using AN0
	BSF         TRISA+0, 0 
;unit03_02_ChooseChannel.c,118 :: 		PORTA.RA0 = 1;             // optional
	BSF         PORTA+0, 0 
;unit03_02_ChooseChannel.c,120 :: 		ADCON0 =  0B00000001;      // AN0 - > AD on
	MOVLW       1
	MOVWF       ADCON0+0 
;unit03_02_ChooseChannel.c,121 :: 		ADCON1 =  0B00001110;      // AN0/RA0 config as AD, ref internal v
	MOVLW       14
	MOVWF       ADCON1+0 
;unit03_02_ChooseChannel.c,125 :: 		break;
	GOTO        L_ADCRead1
;unit03_02_ChooseChannel.c,128 :: 		case 1: {
L_ADCRead3:
;unit03_02_ChooseChannel.c,130 :: 		TRISA.RA1 = 1;             // Input using AN0
	BSF         TRISA+0, 1 
;unit03_02_ChooseChannel.c,131 :: 		PORTA.RA1 = 1;             // Optional
	BSF         PORTA+0, 1 
;unit03_02_ChooseChannel.c,133 :: 		ADCON0 =  0B00000101;      // AN0 - > AD LIGADO
	MOVLW       5
	MOVWF       ADCON0+0 
;unit03_02_ChooseChannel.c,135 :: 		ADCON1 =  0B00001101;     // please config ADCON1=0B00001101
	MOVLW       13
	MOVWF       ADCON1+0 
;unit03_02_ChooseChannel.c,142 :: 		break;
	GOTO        L_ADCRead1
;unit03_02_ChooseChannel.c,145 :: 		}
L_ADCRead0:
	MOVF        FARG_ADCRead_channel+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_ADCRead2
	MOVF        FARG_ADCRead_channel+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_ADCRead3
L_ADCRead1:
;unit03_02_ChooseChannel.c,146 :: 		ADCON2 =  0B10101010;         // justify right, fosc/32, TAD = 12
	MOVLW       170
	MOVWF       ADCON2+0 
;unit03_02_ChooseChannel.c,147 :: 		delay_us(40);                 // Aquisition time de 7.45us; mode RC osc give it a time:)
	MOVLW       26
	MOVWF       R13, 0
L_ADCRead4:
	DECFSZ      R13, 1, 1
	BRA         L_ADCRead4
	NOP
;unit03_02_ChooseChannel.c,149 :: 		ADCON0.GO_DONE = 1;           // START convertion ADC
	BSF         ADCON0+0, 1 
;unit03_02_ChooseChannel.c,151 :: 		while(ADCON0.GO_DONE == 1); // wait ADC end
L_ADCRead5:
	BTFSS       ADCON0+0, 1 
	GOTO        L_ADCRead6
	GOTO        L_ADCRead5
L_ADCRead6:
;unit03_02_ChooseChannel.c,152 :: 		return ((ADRESH << 8) | (int)ADRESL);
	MOVF        ADRESH+0, 0 
	MOVWF       R3 
	CLRF        R2 
	MOVF        ADRESL+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
	IORWF       R0, 1 
	MOVF        R3, 0 
	IORWF       R1, 1 
;unit03_02_ChooseChannel.c,153 :: 		}
L_end_ADCRead:
	RETURN      0
; end of _ADCRead

_main:

;unit03_02_ChooseChannel.c,155 :: 		void main() {
;unit03_02_ChooseChannel.c,162 :: 		TRISA.RA0 = 1;                       // Input AN0
	BSF         TRISA+0, 0 
;unit03_02_ChooseChannel.c,163 :: 		PORTA.RA0 = 1;                       // Optional
	BSF         PORTA+0, 0 
;unit03_02_ChooseChannel.c,165 :: 		ADCON0 =  0B00000001;                // AN0 - > AD ON
	MOVLW       1
	MOVWF       ADCON0+0 
;unit03_02_ChooseChannel.c,166 :: 		ADCON1 =  0B00001110;                // AN0/RA0 config as AD, ref internal V
	MOVLW       14
	MOVWF       ADCON1+0 
;unit03_02_ChooseChannel.c,168 :: 		ADCON2 =  0B10101010;                // justify right, fosc/32, TAD = 12
	MOVLW       170
	MOVWF       ADCON2+0 
;unit03_02_ChooseChannel.c,170 :: 		Lcd_Init();                      // Init LCD, 4-bit Mode
	CALL        _Lcd_Init+0, 0
;unit03_02_ChooseChannel.c,171 :: 		Lcd_Cmd(_LCD_CLEAR);             // Cursor clear
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit03_02_ChooseChannel.c,172 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);        // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit03_02_ChooseChannel.c,173 :: 		Lcd_Out(1, 1, "ADC: ");          // Line x Colunm
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_unit03_02_ChooseChannel+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_unit03_02_ChooseChannel+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit03_02_ChooseChannel.c,176 :: 		while(TRUE)
L_main7:
;unit03_02_ChooseChannel.c,178 :: 		Reading_ADC = ADCRead(1);        // Read channel AN0 = 0 ; change to AN1 = 1
	MOVLW       1
	MOVWF       FARG_ADCRead_channel+0 
	CALL        _ADCRead+0, 0
;unit03_02_ChooseChannel.c,179 :: 		WordToStr(Reading_ADC, txt);
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;unit03_02_ChooseChannel.c,180 :: 		LCD_Out (1,1, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit03_02_ChooseChannel.c,181 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main9:
	DECFSZ      R13, 1, 1
	BRA         L_main9
	DECFSZ      R12, 1, 1
	BRA         L_main9
	NOP
	NOP
;unit03_02_ChooseChannel.c,182 :: 		}
	GOTO        L_main7
;unit03_02_ChooseChannel.c,183 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
