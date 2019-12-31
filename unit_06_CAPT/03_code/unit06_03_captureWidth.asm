
_INTERRUPTION_HIGH:

;unit06_03_captureWidth.c,110 :: 		void INTERRUPTION_HIGH() iv 0x0008 ics ICS_AUTO {
;unit06_03_captureWidth.c,111 :: 		if(PIR1.CCP1IF == 1)
	BTFSS       PIR1+0, 2 
	GOTO        L_INTERRUPTION_HIGH0
;unit06_03_captureWidth.c,113 :: 		if(_state == T1)
	MOVF        __state+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_INTERRUPTION_HIGH1
;unit06_03_captureWidth.c,117 :: 		ONE.BYTE[0] = CCPR1L;        // using union struct
	MOVF        CCPR1L+0, 0 
	MOVWF       _ONE+0 
;unit06_03_captureWidth.c,118 :: 		ONE.BYTE[1]= CCPR1H;         // easy, right?
	MOVF        CCPR1H+0, 0 
	MOVWF       _ONE+1 
;unit06_03_captureWidth.c,119 :: 		t1 = ONE.INTEGER;            // t1: first sampling
	MOVF        _ONE+0, 0 
	MOVWF       _t1+0 
	MOVF        _ONE+1, 0 
	MOVWF       _t1+1 
;unit06_03_captureWidth.c,120 :: 		CCP1CON = 0;                 // Microchip's Recomendation: reset before CCP module's manipulation
	CLRF        CCP1CON+0 
;unit06_03_captureWidth.c,122 :: 		CCP1CON = 0B00000100;        // Falling edge capture
	MOVLW       4
	MOVWF       CCP1CON+0 
;unit06_03_captureWidth.c,123 :: 		_state = T2;                 // jump to the next state T2
	MOVLW       1
	MOVWF       __state+0 
;unit06_03_captureWidth.c,124 :: 		}
	GOTO        L_INTERRUPTION_HIGH2
L_INTERRUPTION_HIGH1:
;unit06_03_captureWidth.c,125 :: 		else if(_state == T2)
	MOVF        __state+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_INTERRUPTION_HIGH3
;unit06_03_captureWidth.c,128 :: 		ONE.BYTE[0] = CCPR1L;
	MOVF        CCPR1L+0, 0 
	MOVWF       _ONE+0 
;unit06_03_captureWidth.c,129 :: 		ONE.BYTE[1]= CCPR1H;
	MOVF        CCPR1H+0, 0 
	MOVWF       _ONE+1 
;unit06_03_captureWidth.c,130 :: 		t2 = ONE.INTEGER;            // T2: second sampling
	MOVF        _ONE+0, 0 
	MOVWF       _t2+0 
	MOVF        _ONE+1, 0 
	MOVWF       _t2+1 
;unit06_03_captureWidth.c,131 :: 		CCP1CON = 0;                 // Microchip's Recomendation: reset before CCP module's manipulation
	CLRF        CCP1CON+0 
;unit06_03_captureWidth.c,133 :: 		CCP1CON = 0B00000101;        // Rising edge capture
	MOVLW       5
	MOVWF       CCP1CON+0 
;unit06_03_captureWidth.c,134 :: 		_state = T1;                 // jump to the previews state T1
	CLRF        __state+0 
;unit06_03_captureWidth.c,135 :: 		PIE1.CCP1IE = 0;             // To write to LCD, turn interruption off!
	BCF         PIE1+0, 2 
;unit06_03_captureWidth.c,136 :: 		}
L_INTERRUPTION_HIGH3:
L_INTERRUPTION_HIGH2:
;unit06_03_captureWidth.c,138 :: 		PIR1.CCP1IF = 0;                  // Flag is cleared
	BCF         PIR1+0, 2 
;unit06_03_captureWidth.c,139 :: 		}
L_INTERRUPTION_HIGH0:
;unit06_03_captureWidth.c,140 :: 		}
L_end_INTERRUPTION_HIGH:
L__INTERRUPTION_HIGH9:
	RETFIE      1
; end of _INTERRUPTION_HIGH

_ConfigMCU:

;unit06_03_captureWidth.c,142 :: 		void ConfigMCU()
;unit06_03_captureWidth.c,148 :: 		ADCON1 |= 0X0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit06_03_captureWidth.c,150 :: 		TRISB =0;
	CLRF        TRISB+0 
;unit06_03_captureWidth.c,151 :: 		TRISC.RC2 = 1;
	BSF         TRISC+0, 2 
;unit06_03_captureWidth.c,152 :: 		PORTC.RC2 = 1;
	BSF         PORTC+0, 2 
;unit06_03_captureWidth.c,153 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_configGlobalInterruption:

;unit06_03_captureWidth.c,155 :: 		void configGlobalInterruption()        // General glebal interruptions set up
;unit06_03_captureWidth.c,157 :: 		INTCON.GIEH = 1;                     // Enable Interruptions High Priority
	BSF         INTCON+0, 7 
;unit06_03_captureWidth.c,158 :: 		INTCON.GIEL = 1;                     // Enable Interruptions Low Priority
	BSF         INTCON+0, 6 
;unit06_03_captureWidth.c,159 :: 		RCON.IPEN = 1;                       // Enable Priority
	BSF         RCON+0, 7 
;unit06_03_captureWidth.c,160 :: 		}
L_end_configGlobalInterruption:
	RETURN      0
; end of _configGlobalInterruption

_configIndividualVctCAPT:

;unit06_03_captureWidth.c,162 :: 		void configIndividualVctCAPT()         // Capture peripheral setup
;unit06_03_captureWidth.c,164 :: 		CCP1CON = 0;                         // Reset the module: Microchip recommends:)
	CLRF        CCP1CON+0 
;unit06_03_captureWidth.c,166 :: 		CCP1CON = 0B00000111;                // Capture 16 th mode: every rising edge
	MOVLW       7
	MOVWF       CCP1CON+0 
;unit06_03_captureWidth.c,168 :: 		PIR1.CCP1IF = 0;                     // F for Flag's clear
	BCF         PIR1+0, 2 
;unit06_03_captureWidth.c,169 :: 		IPR1.CCP1IP = 1;                     // P for Priority
	BSF         IPR1+0, 2 
;unit06_03_captureWidth.c,170 :: 		PIE1.CCP1IE = 1;                     // E CCP enable
	BSF         PIE1+0, 2 
;unit06_03_captureWidth.c,172 :: 		TRISC.RC2 = 1;                       // CCP as input
	BSF         TRISC+0, 2 
;unit06_03_captureWidth.c,175 :: 		T1CON = 0B11010000;                  //16-bit mode, TMR1 osc, PS 1:2, clock source Fosc/4, stop TMR1
	MOVLW       208
	MOVWF       T1CON+0 
;unit06_03_captureWidth.c,176 :: 		TMR1H = 0;
	CLRF        TMR1H+0 
;unit06_03_captureWidth.c,177 :: 		TMR1L = 0;
	CLRF        TMR1L+0 
;unit06_03_captureWidth.c,178 :: 		T1CON.TMR1ON = 1;                    // TMR1 on!
	BSF         T1CON+0, 0 
;unit06_03_captureWidth.c,180 :: 		}
L_end_configIndividualVctCAPT:
	RETURN      0
; end of _configIndividualVctCAPT

_main:

;unit06_03_captureWidth.c,182 :: 		void main() {
;unit06_03_captureWidth.c,183 :: 		unsigned int p = 0;                  // p = t2 - t1 (period time)
;unit06_03_captureWidth.c,186 :: 		configMcu();                         // call all subroutine above
	CALL        _ConfigMCU+0, 0
;unit06_03_captureWidth.c,187 :: 		configGlobalInterruption();
	CALL        _configGlobalInterruption+0, 0
;unit06_03_captureWidth.c,188 :: 		configIndividualVctCAPT();
	CALL        _configIndividualVctCAPT+0, 0
;unit06_03_captureWidth.c,190 :: 		Lcd_Init();                          // Init LCD, 4-bit Mode
	CALL        _Lcd_Init+0, 0
;unit06_03_captureWidth.c,191 :: 		Lcd_Cmd(_LCD_CLEAR);                 // Screen clear
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit06_03_captureWidth.c,192 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);            // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit06_03_captureWidth.c,193 :: 		Lcd_Out(1, 1, "Period: ");           // Line x Colunm
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_unit06_03_captureWidth+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_unit06_03_captureWidth+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit06_03_captureWidth.c,195 :: 		while (TRUE)
L_main4:
;unit06_03_captureWidth.c,197 :: 		if(PIE1.CCP1IE == 0)             // Turn off interruptions to write to LCD (ISR force stop)
	BTFSC       PIE1+0, 2 
	GOTO        L_main6
;unit06_03_captureWidth.c,199 :: 		p = t2 - t1;                 // p: period; t2: second time sampling; t1: first time sampling
	MOVF        _t1+0, 0 
	SUBWF       _t2+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _t1+1, 0 
	SUBWFB      _t2+1, 0 
	MOVWF       FARG_WordToStr_input+1 
;unit06_03_captureWidth.c,200 :: 		WordToStr (p, txt);
	MOVLW       main_txt_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;unit06_03_captureWidth.c,201 :: 		Lcd_Out (1,10, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit06_03_captureWidth.c,203 :: 		Delay_ms(20);
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
;unit06_03_captureWidth.c,204 :: 		PIE1.CCP1IE = 1;             // Again, turn interruption on! (see ISR)
	BSF         PIE1+0, 2 
;unit06_03_captureWidth.c,205 :: 		}
L_main6:
;unit06_03_captureWidth.c,206 :: 		}
	GOTO        L_main4
;unit06_03_captureWidth.c,207 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
