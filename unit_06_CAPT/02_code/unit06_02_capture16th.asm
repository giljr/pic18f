
_INTERRUPTION_HIGH:

;unit06_02_capture16th.c,110 :: 		void INTERRUPTION_HIGH() iv 0x0008 ics ICS_AUTO {
;unit06_02_capture16th.c,111 :: 		if(PIR1.CCP1IF == 1)
	BTFSS       PIR1+0, 2 
	GOTO        L_INTERRUPTION_HIGH0
;unit06_02_capture16th.c,113 :: 		if(_state == T1)
	MOVF        __state+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_INTERRUPTION_HIGH1
;unit06_02_capture16th.c,117 :: 		ONE.BYTE[0] = CCPR1L;        // using union struct
	MOVF        CCPR1L+0, 0 
	MOVWF       _ONE+0 
;unit06_02_capture16th.c,118 :: 		ONE.BYTE[1]= CCPR1H;         // easy, right?
	MOVF        CCPR1H+0, 0 
	MOVWF       _ONE+1 
;unit06_02_capture16th.c,119 :: 		t1 = ONE.INTEGER/16;         // t1: first sampling
	MOVF        _ONE+0, 0 
	MOVWF       R0 
	MOVF        _ONE+1, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	MOVF        R0, 0 
	MOVWF       _t1+0 
	MOVF        R1, 0 
	MOVWF       _t1+1 
;unit06_02_capture16th.c,120 :: 		_state = T2;                 // jump to the next state T2
	MOVLW       1
	MOVWF       __state+0 
;unit06_02_capture16th.c,121 :: 		}
	GOTO        L_INTERRUPTION_HIGH2
L_INTERRUPTION_HIGH1:
;unit06_02_capture16th.c,122 :: 		else if(_state == T2)
	MOVF        __state+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_INTERRUPTION_HIGH3
;unit06_02_capture16th.c,125 :: 		ONE.BYTE[0] = CCPR1L;
	MOVF        CCPR1L+0, 0 
	MOVWF       _ONE+0 
;unit06_02_capture16th.c,126 :: 		ONE.BYTE[1]= CCPR1H;
	MOVF        CCPR1H+0, 0 
	MOVWF       _ONE+1 
;unit06_02_capture16th.c,127 :: 		t2 = ONE.INTEGER/16;         // T2: second sampling
	MOVF        _ONE+0, 0 
	MOVWF       R0 
	MOVF        _ONE+1, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	MOVF        R0, 0 
	MOVWF       _t2+0 
	MOVF        R1, 0 
	MOVWF       _t2+1 
;unit06_02_capture16th.c,128 :: 		_state = T1;                 // jump to the previews state T1
	CLRF        __state+0 
;unit06_02_capture16th.c,130 :: 		PIE1.CCP1IE = 0;
	BCF         PIE1+0, 2 
;unit06_02_capture16th.c,131 :: 		}
L_INTERRUPTION_HIGH3:
L_INTERRUPTION_HIGH2:
;unit06_02_capture16th.c,133 :: 		PIR1.CCP1IF = 0;                  // Flag is cleared
	BCF         PIR1+0, 2 
;unit06_02_capture16th.c,134 :: 		}
L_INTERRUPTION_HIGH0:
;unit06_02_capture16th.c,135 :: 		}
L_end_INTERRUPTION_HIGH:
L__INTERRUPTION_HIGH9:
	RETFIE      1
; end of _INTERRUPTION_HIGH

_ConfigMCU:

;unit06_02_capture16th.c,137 :: 		void ConfigMCU()
;unit06_02_capture16th.c,143 :: 		ADCON1 |= 0X0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit06_02_capture16th.c,145 :: 		TRISB =0;
	CLRF        TRISB+0 
;unit06_02_capture16th.c,146 :: 		TRISC.RC2 = 1;                        // Input sygnal goes here!
	BSF         TRISC+0, 2 
;unit06_02_capture16th.c,147 :: 		PORTC.RC2 = 1;
	BSF         PORTC+0, 2 
;unit06_02_capture16th.c,148 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_configGlobalInterruption:

;unit06_02_capture16th.c,150 :: 		void configGlobalInterruption()        // General glebal interruptions set up
;unit06_02_capture16th.c,152 :: 		INTCON.GIEH = 1;                     // Enable Interruptions High Priority
	BSF         INTCON+0, 7 
;unit06_02_capture16th.c,153 :: 		INTCON.GIEL = 1;                     // Enable Interruptions Low Priority
	BSF         INTCON+0, 6 
;unit06_02_capture16th.c,154 :: 		RCON.IPEN = 1;                       // Enable Priority
	BSF         RCON+0, 7 
;unit06_02_capture16th.c,155 :: 		}
L_end_configGlobalInterruption:
	RETURN      0
; end of _configGlobalInterruption

_configIndividualVctCAPT:

;unit06_02_capture16th.c,157 :: 		void configIndividualVctCAPT()         // Capture peripheral setup
;unit06_02_capture16th.c,159 :: 		CCP1CON = 0;                         // Resetting the Module: Microchip recommendation
	CLRF        CCP1CON+0 
;unit06_02_capture16th.c,161 :: 		CCP1CON = 0B00000111;                // Capture 16 th mode: every rising edge
	MOVLW       7
	MOVWF       CCP1CON+0 
;unit06_02_capture16th.c,163 :: 		PIR1.CCP1IF = 0;                     // F for Flag's clear
	BCF         PIR1+0, 2 
;unit06_02_capture16th.c,164 :: 		IPR1.CCP1IP = 1;                     // P for Priority
	BSF         IPR1+0, 2 
;unit06_02_capture16th.c,165 :: 		PIE1.CCP1IE = 1;                     // E CCP enable
	BSF         PIE1+0, 2 
;unit06_02_capture16th.c,167 :: 		TRISC.RC2 = 1;                       // CCP as input
	BSF         TRISC+0, 2 
;unit06_02_capture16th.c,170 :: 		T1CON = 0B11010000;                  //16-bit mode, TMR1 osc, PS 1:2, clock source Fosc/4, stop TMR1
	MOVLW       208
	MOVWF       T1CON+0 
;unit06_02_capture16th.c,171 :: 		TMR1H = 0;
	CLRF        TMR1H+0 
;unit06_02_capture16th.c,172 :: 		TMR1L = 0;
	CLRF        TMR1L+0 
;unit06_02_capture16th.c,173 :: 		T1CON.TMR1ON = 1;                    // TMR1 on!
	BSF         T1CON+0, 0 
;unit06_02_capture16th.c,175 :: 		}
L_end_configIndividualVctCAPT:
	RETURN      0
; end of _configIndividualVctCAPT

_main:

;unit06_02_capture16th.c,177 :: 		void main() {
;unit06_02_capture16th.c,178 :: 		unsigned int p = 0;                  // p = t2 - t1 (period time)
;unit06_02_capture16th.c,181 :: 		configMcu();                         // call all subroutine above
	CALL        _ConfigMCU+0, 0
;unit06_02_capture16th.c,182 :: 		configGlobalInterruption();
	CALL        _configGlobalInterruption+0, 0
;unit06_02_capture16th.c,183 :: 		configIndividualVctCAPT();
	CALL        _configIndividualVctCAPT+0, 0
;unit06_02_capture16th.c,185 :: 		Lcd_Init();                          // Init LCD, 4-bit Mode
	CALL        _Lcd_Init+0, 0
;unit06_02_capture16th.c,186 :: 		Lcd_Cmd(_LCD_CLEAR);                 // Screen clear
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit06_02_capture16th.c,187 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);            // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit06_02_capture16th.c,188 :: 		Lcd_Out(1, 1, "Period: ");           // Line x Colunm
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_unit06_02_capture16th+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_unit06_02_capture16th+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit06_02_capture16th.c,190 :: 		while (TRUE)
L_main4:
;unit06_02_capture16th.c,192 :: 		if(PIE1.CCP1IE == 0)             // Turn off interruptions to write to LCD (ISR force stop)
	BTFSC       PIE1+0, 2 
	GOTO        L_main6
;unit06_02_capture16th.c,194 :: 		p = t2 - t1;                 // p: period; t2: second time sampling; t1: first time sampling
	MOVF        _t1+0, 0 
	SUBWF       _t2+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _t1+1, 0 
	SUBWFB      _t2+1, 0 
	MOVWF       FARG_WordToStr_input+1 
;unit06_02_capture16th.c,195 :: 		WordToStr (p, txt);
	MOVLW       main_txt_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;unit06_02_capture16th.c,196 :: 		Lcd_Out (1,10, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit06_02_capture16th.c,198 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	NOP
	NOP
;unit06_02_capture16th.c,199 :: 		PIE1.CCP1IE = 1;             // Again, turn interruption on! (see ISR)
	BSF         PIE1+0, 2 
;unit06_02_capture16th.c,200 :: 		}
L_main6:
;unit06_02_capture16th.c,201 :: 		}
	GOTO        L_main4
;unit06_02_capture16th.c,202 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
