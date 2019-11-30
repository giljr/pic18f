
_INTERRUPTION_ADC_HIGH:

;unit05_03_adcInterruption.c,145 :: 		void INTERRUPTION_ADC_HIGH() iv 0x0008 ics ICS_AUTO {
;unit05_03_adcInterruption.c,148 :: 		if (PIR1.ADIF == 1 && PIE1.ADIE == 1)
	BTFSS       PIR1+0, 6 
	GOTO        L_INTERRUPTION_ADC_HIGH2
	BTFSS       PIE1+0, 6 
	GOTO        L_INTERRUPTION_ADC_HIGH2
L__INTERRUPTION_ADC_HIGH12:
;unit05_03_adcInterruption.c,150 :: 		PIR1.ADIF = 0;                      // Clear flag
	BCF         PIR1+0, 6 
;unit05_03_adcInterruption.c,151 :: 		TWO.BYTE[0] = ADRESL;
	MOVF        ADRESL+0, 0 
	MOVWF       _TWO+0 
;unit05_03_adcInterruption.c,152 :: 		TWO.BYTE[1] = ADRESH;               // Read .BYTE(chars) e store at int(INTEGER)
	MOVF        ADRESH+0, 0 
	MOVWF       _TWO+1 
;unit05_03_adcInterruption.c,153 :: 		if(_i < N_SAMPLING){
	MOVLW       20
	SUBWF       INTERRUPTION_ADC_HIGH__i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_INTERRUPTION_ADC_HIGH3
;unit05_03_adcInterruption.c,154 :: 		BufferADC[_i] = TWO.INTEGER;       // leio o int do meu union
	MOVF        INTERRUPTION_ADC_HIGH__i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _BufferADC+0
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_BufferADC+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVF        _TWO+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        _TWO+1, 0 
	MOVWF       POSTINC1+0 
;unit05_03_adcInterruption.c,155 :: 		++_i;
	MOVF        INTERRUPTION_ADC_HIGH__i_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       INTERRUPTION_ADC_HIGH__i_L0+0 
;unit05_03_adcInterruption.c,158 :: 		}
	GOTO        L_INTERRUPTION_ADC_HIGH4
L_INTERRUPTION_ADC_HIGH3:
;unit05_03_adcInterruption.c,161 :: 		PIE1.ADIE = 0;                      // Turn off interruption to calculate number
	BCF         PIE1+0, 6 
;unit05_03_adcInterruption.c,163 :: 		averageResult = 0 ;                 // Init long variable, add int by int
	CLRF        _averageResult+0 
	CLRF        _averageResult+1 
	CLRF        _averageResult+2 
	CLRF        _averageResult+3 
;unit05_03_adcInterruption.c,164 :: 		for(_i = 0; _i < N_SAMPLING; ++ _i)
	CLRF        INTERRUPTION_ADC_HIGH__i_L0+0 
L_INTERRUPTION_ADC_HIGH5:
	MOVLW       20
	SUBWF       INTERRUPTION_ADC_HIGH__i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_INTERRUPTION_ADC_HIGH6
;unit05_03_adcInterruption.c,166 :: 		averageResult += BufferADC[_i];  //  max 20460 - int will serve but here's long;)
	MOVF        INTERRUPTION_ADC_HIGH__i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _BufferADC+0
	ADDWF       R0, 0 
	MOVWF       FSR2L+0 
	MOVLW       hi_addr(_BufferADC+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       _averageResult+0, 1 
	MOVF        R1, 0 
	ADDWFC      _averageResult+1, 1 
	MOVLW       0
	ADDWFC      _averageResult+2, 1 
	ADDWFC      _averageResult+3, 1 
;unit05_03_adcInterruption.c,164 :: 		for(_i = 0; _i < N_SAMPLING; ++ _i)
	MOVF        INTERRUPTION_ADC_HIGH__i_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       INTERRUPTION_ADC_HIGH__i_L0+0 
;unit05_03_adcInterruption.c,167 :: 		}
	GOTO        L_INTERRUPTION_ADC_HIGH5
L_INTERRUPTION_ADC_HIGH6:
;unit05_03_adcInterruption.c,168 :: 		averageResult /= N_SAMPLING;        // Aritmethic calc
	MOVLW       20
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        _averageResult+0, 0 
	MOVWF       R0 
	MOVF        _averageResult+1, 0 
	MOVWF       R1 
	MOVF        _averageResult+2, 0 
	MOVWF       R2 
	MOVF        _averageResult+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       _averageResult+0 
	MOVF        R1, 0 
	MOVWF       _averageResult+1 
	MOVF        R2, 0 
	MOVWF       _averageResult+2 
	MOVF        R3, 0 
	MOVWF       _averageResult+3 
;unit05_03_adcInterruption.c,169 :: 		_i = 0;                             // Next sampling
	CLRF        INTERRUPTION_ADC_HIGH__i_L0+0 
;unit05_03_adcInterruption.c,170 :: 		}
L_INTERRUPTION_ADC_HIGH4:
;unit05_03_adcInterruption.c,171 :: 		}
L_INTERRUPTION_ADC_HIGH2:
;unit05_03_adcInterruption.c,172 :: 		}
L_end_INTERRUPTION_ADC_HIGH:
L__INTERRUPTION_ADC_HIGH14:
	RETFIE      1
; end of _INTERRUPTION_ADC_HIGH

_configGlobalInterruption:

;unit05_03_adcInterruption.c,175 :: 		void configGlobalInterruption()
;unit05_03_adcInterruption.c,177 :: 		INTCON.GIEH = 1;
	BSF         INTCON+0, 7 
;unit05_03_adcInterruption.c,178 :: 		INTCON.GIEL = 1;                   // High priority
	BSF         INTCON+0, 6 
;unit05_03_adcInterruption.c,179 :: 		RCON.IPEN =  1;
	BSF         RCON+0, 7 
;unit05_03_adcInterruption.c,180 :: 		}
L_end_configGlobalInterruption:
	RETURN      0
; end of _configGlobalInterruption

_configIndividualVctADC:

;unit05_03_adcInterruption.c,183 :: 		void configIndividualVctADC()
;unit05_03_adcInterruption.c,185 :: 		PIR1.ADIF = 0;                       // Flag signalize end ADC's conversions
	BCF         PIR1+0, 6 
;unit05_03_adcInterruption.c,186 :: 		IPR1.ADIP = 1;                       // High priority
	BSF         IPR1+0, 6 
;unit05_03_adcInterruption.c,187 :: 		PIE1.ADIE = 1;                       // Interruption enable
	BSF         PIE1+0, 6 
;unit05_03_adcInterruption.c,190 :: 		}
L_end_configIndividualVctADC:
	RETURN      0
; end of _configIndividualVctADC

_configMCU:

;unit05_03_adcInterruption.c,191 :: 		void configMCU()                      // Timer0 Port & Directions
;unit05_03_adcInterruption.c,199 :: 		ADCON1 |= 0B00001110;                // AN1 analogic  pg 226 Datasheet
	MOVLW       14
	IORWF       ADCON1+0, 1 
;unit05_03_adcInterruption.c,202 :: 		TRISA.RA0 = 1;                       // Input signal ADC
	BSF         TRISA+0, 0 
;unit05_03_adcInterruption.c,203 :: 		PORTA.RA0 = 1;                       // optional
	BSF         PORTA+0, 0 
;unit05_03_adcInterruption.c,205 :: 		TRISD = 0;
	CLRF        TRISD+0 
;unit05_03_adcInterruption.c,206 :: 		PORTD = 0;
	CLRF        PORTD+0 
;unit05_03_adcInterruption.c,207 :: 		}
L_end_configMCU:
	RETURN      0
; end of _configMCU

_configADC1:

;unit05_03_adcInterruption.c,208 :: 		void configADC1()
;unit05_03_adcInterruption.c,210 :: 		ADCON0 =  0B00000101;                // AN1 - > AD on
	MOVLW       5
	MOVWF       ADCON0+0 
;unit05_03_adcInterruption.c,211 :: 		ADCON1 =  0B00001110;                // AN0/RA0 config as AD, ref internal V
	MOVLW       14
	MOVWF       ADCON1+0 
;unit05_03_adcInterruption.c,213 :: 		ADCON2 =  0B10101010;                // justify right, fosc/32, TAD = 12
	MOVLW       170
	MOVWF       ADCON2+0 
;unit05_03_adcInterruption.c,214 :: 		}
L_end_configADC1:
	RETURN      0
; end of _configADC1

_main:

;unit05_03_adcInterruption.c,216 :: 		void main() {
;unit05_03_adcInterruption.c,217 :: 		configMCU();
	CALL        _configMCU+0, 0
;unit05_03_adcInterruption.c,218 :: 		configADC1();
	CALL        _configADC1+0, 0
;unit05_03_adcInterruption.c,219 :: 		configGlobalInterruption();          // config general ints
	CALL        _configGlobalInterruption+0, 0
;unit05_03_adcInterruption.c,220 :: 		configIndividualVctADC();
	CALL        _configIndividualVctADC+0, 0
;unit05_03_adcInterruption.c,222 :: 		Lcd_Init();                          // Init LCD, 4-bit Mode
	CALL        _Lcd_Init+0, 0
;unit05_03_adcInterruption.c,223 :: 		Lcd_Cmd(_LCD_CLEAR);                 // Screen clear
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit05_03_adcInterruption.c,224 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);            // Clear cursor
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit05_03_adcInterruption.c,225 :: 		Lcd_Out(1, 1, "ADC: ");              // Line x Colunm
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_unit05_03_adcInterruption+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_unit05_03_adcInterruption+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit05_03_adcInterruption.c,227 :: 		while(TRUE)
L_main8:
;unit05_03_adcInterruption.c,229 :: 		ADCON0.GO_DONE = 1;         // START ADC's conversion
	BSF         ADCON0+0, 1 
;unit05_03_adcInterruption.c,232 :: 		if(PIE1.ADIE == 0) {        // Interruption disabled?
	BTFSC       PIE1+0, 6 
	GOTO        L_main10
;unit05_03_adcInterruption.c,233 :: 		wordToStr((int)averageResult, txt);
	MOVF        _averageResult+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _averageResult+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;unit05_03_adcInterruption.c,234 :: 		LCD_Out (1,5, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit05_03_adcInterruption.c,235 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main11:
	DECFSZ      R13, 1, 1
	BRA         L_main11
	DECFSZ      R12, 1, 1
	BRA         L_main11
	NOP
	NOP
;unit05_03_adcInterruption.c,237 :: 		PIE1.ADIE = 1;          // After writing LCD enable interruption again
	BSF         PIE1+0, 6 
;unit05_03_adcInterruption.c,241 :: 		}
L_main10:
;unit05_03_adcInterruption.c,242 :: 		}
	GOTO        L_main8
;unit05_03_adcInterruption.c,243 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
