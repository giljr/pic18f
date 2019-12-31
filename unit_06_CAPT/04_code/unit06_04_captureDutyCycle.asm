
_INTERRUPTION_HIGH:

;unit06_04_captureDutyCycle.c,117 :: 		void INTERRUPTION_HIGH() iv 0x0008 ics ICS_AUTO {
;unit06_04_captureDutyCycle.c,118 :: 		if(PIR1.CCP1IF)// == 1 && PIR1.CCP1IE == 1)
	BTFSS       PIR1+0, 2 
	GOTO        L_INTERRUPTION_HIGH0
;unit06_04_captureDutyCycle.c,120 :: 		switch(m_state) {
	GOTO        L_INTERRUPTION_HIGH1
;unit06_04_captureDutyCycle.c,122 :: 		case(turn1):{
L_INTERRUPTION_HIGH3:
;unit06_04_captureDutyCycle.c,123 :: 		ONE.BYTE[0] = CCPR1L;
	MOVF        CCPR1L+0, 0 
	MOVWF       _ONE+0 
;unit06_04_captureDutyCycle.c,124 :: 		ONE.BYTE[1] = CCPR1H;
	MOVF        CCPR1H+0, 0 
	MOVWF       _ONE+1 
;unit06_04_captureDutyCycle.c,125 :: 		t1 = ONE.INTEGER;
	MOVF        _ONE+0, 0 
	MOVWF       _t1+0 
	MOVF        _ONE+1, 0 
	MOVWF       _t1+1 
;unit06_04_captureDutyCycle.c,126 :: 		CCP1CON = 0;          //necessário para evitar falsa interrupção
	CLRF        CCP1CON+0 
;unit06_04_captureDutyCycle.c,127 :: 		CCP1CON = 0B00000100; //every a cada descida
	MOVLW       4
	MOVWF       CCP1CON+0 
;unit06_04_captureDutyCycle.c,128 :: 		m_state = t2;
	MOVF        _t2+0, 0 
	MOVWF       unit06_04_captureDutyCycle_m_state+0 
;unit06_04_captureDutyCycle.c,129 :: 		break;
	GOTO        L_INTERRUPTION_HIGH2
;unit06_04_captureDutyCycle.c,132 :: 		case(turn2):{
L_INTERRUPTION_HIGH4:
;unit06_04_captureDutyCycle.c,133 :: 		ONE.BYTE[0] = CCPR1L;
	MOVF        CCPR1L+0, 0 
	MOVWF       _ONE+0 
;unit06_04_captureDutyCycle.c,134 :: 		ONE.BYTE[1] = CCPR1H;
	MOVF        CCPR1H+0, 0 
	MOVWF       _ONE+1 
;unit06_04_captureDutyCycle.c,135 :: 		t2 = ONE.INTEGER;
	MOVF        _ONE+0, 0 
	MOVWF       _t2+0 
	MOVF        _ONE+1, 0 
	MOVWF       _t2+1 
;unit06_04_captureDutyCycle.c,136 :: 		CCP1CON = 0;          //necessário para evitar falsa interrupção
	CLRF        CCP1CON+0 
;unit06_04_captureDutyCycle.c,137 :: 		CCP1CON = 0B00000101; //every a cada subida
	MOVLW       5
	MOVWF       CCP1CON+0 
;unit06_04_captureDutyCycle.c,138 :: 		m_state = t3;
	MOVF        _t3+0, 0 
	MOVWF       unit06_04_captureDutyCycle_m_state+0 
;unit06_04_captureDutyCycle.c,139 :: 		break;
	GOTO        L_INTERRUPTION_HIGH2
;unit06_04_captureDutyCycle.c,142 :: 		case(turn3):{
L_INTERRUPTION_HIGH5:
;unit06_04_captureDutyCycle.c,143 :: 		ONE.BYTE[0] = CCPR1L;
	MOVF        CCPR1L+0, 0 
	MOVWF       _ONE+0 
;unit06_04_captureDutyCycle.c,144 :: 		ONE.BYTE[1] = CCPR1H;
	MOVF        CCPR1H+0, 0 
	MOVWF       _ONE+1 
;unit06_04_captureDutyCycle.c,145 :: 		t3 = ONE.INTEGER;  //Nesse ponto temos T, ou seja, O PERIODO COMPLETO
	MOVF        _ONE+0, 0 
	MOVWF       _t3+0 
	MOVF        _ONE+1, 0 
	MOVWF       _t3+1 
;unit06_04_captureDutyCycle.c,146 :: 		PIE1.CCP1IE = 0;
	BCF         PIE1+0, 2 
;unit06_04_captureDutyCycle.c,147 :: 		m_state = t1;
	MOVF        _t1+0, 0 
	MOVWF       unit06_04_captureDutyCycle_m_state+0 
;unit06_04_captureDutyCycle.c,148 :: 		break;
	GOTO        L_INTERRUPTION_HIGH2
;unit06_04_captureDutyCycle.c,150 :: 		}
L_INTERRUPTION_HIGH1:
	MOVF        unit06_04_captureDutyCycle_m_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_INTERRUPTION_HIGH3
	MOVF        unit06_04_captureDutyCycle_m_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_INTERRUPTION_HIGH4
	MOVF        unit06_04_captureDutyCycle_m_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_INTERRUPTION_HIGH5
L_INTERRUPTION_HIGH2:
;unit06_04_captureDutyCycle.c,151 :: 		PIR1.CCP1IF = 0;
	BCF         PIR1+0, 2 
;unit06_04_captureDutyCycle.c,152 :: 		}
L_INTERRUPTION_HIGH0:
;unit06_04_captureDutyCycle.c,153 :: 		}
L_end_INTERRUPTION_HIGH:
L__INTERRUPTION_HIGH11:
	RETFIE      1
; end of _INTERRUPTION_HIGH

_ConfigMCU:

;unit06_04_captureDutyCycle.c,155 :: 		void ConfigMCU()
;unit06_04_captureDutyCycle.c,161 :: 		ADCON1 |= 0X0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit06_04_captureDutyCycle.c,163 :: 		TRISB =0;
	CLRF        TRISB+0 
;unit06_04_captureDutyCycle.c,164 :: 		TRISC.RC2 = 1;
	BSF         TRISC+0, 2 
;unit06_04_captureDutyCycle.c,165 :: 		PORTC.RC2 = 1;
	BSF         PORTC+0, 2 
;unit06_04_captureDutyCycle.c,166 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_configGlobalInterruption:

;unit06_04_captureDutyCycle.c,168 :: 		void configGlobalInterruption()        // General glebal interruptions set up
;unit06_04_captureDutyCycle.c,170 :: 		INTCON.GIEH = 1;                     // Enable Interruptions High Priority
	BSF         INTCON+0, 7 
;unit06_04_captureDutyCycle.c,171 :: 		INTCON.GIEL = 1;                     // Enable Interruptions Low Priority
	BSF         INTCON+0, 6 
;unit06_04_captureDutyCycle.c,172 :: 		RCON.IPEN = 1;                       // Enable Priority
	BSF         RCON+0, 7 
;unit06_04_captureDutyCycle.c,173 :: 		}
L_end_configGlobalInterruption:
	RETURN      0
; end of _configGlobalInterruption

_configIndividualVctCAPT:

;unit06_04_captureDutyCycle.c,175 :: 		void configIndividualVctCAPT()         // Capture peripheral setup
;unit06_04_captureDutyCycle.c,177 :: 		CCP1CON = 0;                         // Reset Module: Microchip recommends:)
	CLRF        CCP1CON+0 
;unit06_04_captureDutyCycle.c,179 :: 		CCP1CON = 0B00000101;                // Capture 16 th mode: every rising edge
	MOVLW       5
	MOVWF       CCP1CON+0 
;unit06_04_captureDutyCycle.c,181 :: 		PIR1.CCP1IF = 0;                     // F for Flag's clear
	BCF         PIR1+0, 2 
;unit06_04_captureDutyCycle.c,182 :: 		IPR1.CCP1IP = 1;                     // P for Priority
	BSF         IPR1+0, 2 
;unit06_04_captureDutyCycle.c,183 :: 		PIE1.CCP1IE = 1;                     // E CCP enable
	BSF         PIE1+0, 2 
;unit06_04_captureDutyCycle.c,185 :: 		TRISC.RC2 = 1;                       // CCP as input
	BSF         TRISC+0, 2 
;unit06_04_captureDutyCycle.c,188 :: 		T1CON = 0B00010011;                  //16-bit mode, TMR1 osc, PS 1:2, clock source Fosc/4, stop TMR1
	MOVLW       19
	MOVWF       T1CON+0 
;unit06_04_captureDutyCycle.c,189 :: 		TMR1H = 0;
	CLRF        TMR1H+0 
;unit06_04_captureDutyCycle.c,190 :: 		TMR1L = 0;
	CLRF        TMR1L+0 
;unit06_04_captureDutyCycle.c,191 :: 		T1CON.TMR1ON = 1;                    // TMR1 on!
	BSF         T1CON+0, 0 
;unit06_04_captureDutyCycle.c,193 :: 		}
L_end_configIndividualVctCAPT:
	RETURN      0
; end of _configIndividualVctCAPT

_main:

;unit06_04_captureDutyCycle.c,195 :: 		void main() {
;unit06_04_captureDutyCycle.c,198 :: 		unsigned int p = 0;                  // p = t2 - t1 (period time)
	CLRF        main_p_L0+0 
	CLRF        main_p_L0+1 
;unit06_04_captureDutyCycle.c,201 :: 		configMcu();                         // call all subroutine above
	CALL        _ConfigMCU+0, 0
;unit06_04_captureDutyCycle.c,202 :: 		configGlobalInterruption();
	CALL        _configGlobalInterruption+0, 0
;unit06_04_captureDutyCycle.c,203 :: 		configIndividualVctCAPT();
	CALL        _configIndividualVctCAPT+0, 0
;unit06_04_captureDutyCycle.c,205 :: 		Lcd_Init();                          // Init LCD, 4-bit Mode
	CALL        _Lcd_Init+0, 0
;unit06_04_captureDutyCycle.c,206 :: 		Lcd_Cmd(_LCD_CLEAR);                 // Screen clear
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit06_04_captureDutyCycle.c,207 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);            // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit06_04_captureDutyCycle.c,208 :: 		Lcd_Out(1,1,"D:");                   // Duty Cycle
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_unit06_04_captureDutyCycle+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_unit06_04_captureDutyCycle+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit06_04_captureDutyCycle.c,209 :: 		Lcd_Out(1,9,"W:");                   // Width
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_unit06_04_captureDutyCycle+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_unit06_04_captureDutyCycle+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit06_04_captureDutyCycle.c,210 :: 		Lcd_Out(2,9,"P:");                   // Period
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_unit06_04_captureDutyCycle+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_unit06_04_captureDutyCycle+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit06_04_captureDutyCycle.c,212 :: 		while (TRUE)
L_main6:
;unit06_04_captureDutyCycle.c,214 :: 		if(PIE1.CCP1IE == 0)
	BTFSC       PIE1+0, 2 
	GOTO        L_main8
;unit06_04_captureDutyCycle.c,216 :: 		w = t2 - t1;
	MOVF        _t1+0, 0 
	SUBWF       _t2+0, 0 
	MOVWF       R0 
	MOVF        _t1+1, 0 
	SUBWFB      _t2+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       main_w_L0+0 
	MOVF        R1, 0 
	MOVWF       main_w_L0+1 
;unit06_04_captureDutyCycle.c,217 :: 		p = t3 - t1;
	MOVF        _t1+0, 0 
	SUBWF       _t3+0, 0 
	MOVWF       FLOC__main+4 
	MOVF        _t1+1, 0 
	SUBWFB      _t3+1, 0 
	MOVWF       FLOC__main+5 
	MOVF        FLOC__main+4, 0 
	MOVWF       main_p_L0+0 
	MOVF        FLOC__main+5, 0 
	MOVWF       main_p_L0+1 
;unit06_04_captureDutyCycle.c,218 :: 		duty = 100*((float)w/(float)p);
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	MOVF        R2, 0 
	MOVWF       FLOC__main+2 
	MOVF        R3, 0 
	MOVWF       FLOC__main+3 
	MOVF        FLOC__main+4, 0 
	MOVWF       R0 
	MOVF        FLOC__main+5, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	MOVF        FLOC__main+2, 0 
	MOVWF       R2 
	MOVF        FLOC__main+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2word+0, 0
;unit06_04_captureDutyCycle.c,220 :: 		WordToStr(duty, txt);
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;unit06_04_captureDutyCycle.c,221 :: 		LCD_Out(1,3,txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit06_04_captureDutyCycle.c,224 :: 		WordToStr(w, txt);
	MOVF        main_w_L0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        main_w_L0+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;unit06_04_captureDutyCycle.c,225 :: 		LCD_Out(1,11,txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit06_04_captureDutyCycle.c,228 :: 		WordToStr(p, txt);
	MOVF        main_p_L0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        main_p_L0+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;unit06_04_captureDutyCycle.c,229 :: 		LCD_Out(2,11,txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit06_04_captureDutyCycle.c,232 :: 		Delay_ms(300);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main9:
	DECFSZ      R13, 1, 1
	BRA         L_main9
	DECFSZ      R12, 1, 1
	BRA         L_main9
	DECFSZ      R11, 1, 1
	BRA         L_main9
	NOP
	NOP
;unit06_04_captureDutyCycle.c,233 :: 		PIE1.CCP1IE = 1;
	BSF         PIE1+0, 2 
;unit06_04_captureDutyCycle.c,234 :: 		}
L_main8:
;unit06_04_captureDutyCycle.c,235 :: 		}
	GOTO        L_main6
;unit06_04_captureDutyCycle.c,236 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
