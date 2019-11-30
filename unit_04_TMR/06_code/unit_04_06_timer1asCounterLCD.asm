
_ConfigMCU:

;unit_04_06_timer1asCounterLCD.c,112 :: 		void ConfigMCU()
;unit_04_06_timer1asCounterLCD.c,118 :: 		ADCON1 |= 0X0F;                    // (PIC18F45220) Determine if anal/digital pins
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit_04_06_timer1asCounterLCD.c,120 :: 		TRISC.RC0 = 1;                     // Simulate pulses PORTC.RC0 (T13CKI pin)
	BSF         TRISC+0, 0 
;unit_04_06_timer1asCounterLCD.c,121 :: 		PORTC.RC0 = 1;
	BSF         PORTC+0, 0 
;unit_04_06_timer1asCounterLCD.c,122 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_ConfigTimer:

;unit_04_06_timer1asCounterLCD.c,124 :: 		void ConfigTimer()
;unit_04_06_timer1asCounterLCD.c,129 :: 		T1CON = 0B10000010;                // Timer1 off, Prescale 1:1 , Mode 16-BITS, edge low/high
	MOVLW       130
	MOVWF       T1CON+0 
;unit_04_06_timer1asCounterLCD.c,131 :: 		TMR1H = 0;                          // Initial values for accumulator registers
	CLRF        TMR1H+0 
;unit_04_06_timer1asCounterLCD.c,132 :: 		TMR1L = 0;                          // One more pulse, Timer1 overflow!
	CLRF        TMR1L+0 
;unit_04_06_timer1asCounterLCD.c,134 :: 		PIR1.TMR1IF = 0;                    // Flag clearhigh/low
	BCF         PIR1+0, 0 
;unit_04_06_timer1asCounterLCD.c,135 :: 		T1CON.TMR1ON = 1;                   // Timer1 on, everything is configure, right:D
	BSF         T1CON+0, 0 
;unit_04_06_timer1asCounterLCD.c,136 :: 		}
L_end_ConfigTimer:
	RETURN      0
; end of _ConfigTimer

_main:

;unit_04_06_timer1asCounterLCD.c,138 :: 		void main() {
;unit_04_06_timer1asCounterLCD.c,139 :: 		ConfigMCU();
	CALL        _ConfigMCU+0, 0
;unit_04_06_timer1asCounterLCD.c,140 :: 		ConfigTimer();
	CALL        _ConfigTimer+0, 0
;unit_04_06_timer1asCounterLCD.c,142 :: 		Lcd_Init();                         // Initialize LCD
	CALL        _Lcd_Init+0, 0
;unit_04_06_timer1asCounterLCD.c,144 :: 		Lcd_Cmd(_LCD_CLEAR);                // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit_04_06_timer1asCounterLCD.c,145 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);           // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit_04_06_timer1asCounterLCD.c,147 :: 		Lcd_Out(1,1,"Value:");              // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_unit_04_06_timer1asCounterLCD+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_unit_04_06_timer1asCounterLCD+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit_04_06_timer1asCounterLCD.c,149 :: 		while (TRUE)                         // Do forever
L_main0:
;unit_04_06_timer1asCounterLCD.c,151 :: 		TWO.BYTE[1] = TMR1H;              // Please, in this order!
	MOVF        TMR1H+0, 0 
	MOVWF       _TWO+1 
;unit_04_06_timer1asCounterLCD.c,152 :: 		TWO.BYTE[0] = TMR1L;              // Read PIC18(L)F2X/4XK22 datasheet @ 12.7 Timer1/3/5 Gate
	MOVF        TMR1L+0, 0 
	MOVWF       _TWO+0 
;unit_04_06_timer1asCounterLCD.c,154 :: 		WordToStr(TWO.INTEGER, txt);      // Convert number to txt[10]
	MOVF        _TWO+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _TWO+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;unit_04_06_timer1asCounterLCD.c,155 :: 		LCD_Out(1, 7, txt);               // Show at LCD's first line
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit_04_06_timer1asCounterLCD.c,156 :: 		Delay_ms(20);
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
;unit_04_06_timer1asCounterLCD.c,158 :: 		if(PIR1.TMR1IF == 1)              // Timer1 will overflow at 65536 pulses:/
	BTFSS       PIR1+0, 0 
	GOTO        L_main3
;unit_04_06_timer1asCounterLCD.c,160 :: 		TMR1H = 0;                   // Recharge default values
	CLRF        TMR1H+0 
;unit_04_06_timer1asCounterLCD.c,161 :: 		TMR1L = 0;
	CLRF        TMR1L+0 
;unit_04_06_timer1asCounterLCD.c,162 :: 		PIR1.TMR1IF = 0;             // Clear Timer1's overflow Flag
	BCF         PIR1+0, 0 
;unit_04_06_timer1asCounterLCD.c,163 :: 		}
L_main3:
;unit_04_06_timer1asCounterLCD.c,165 :: 		}
	GOTO        L_main0
;unit_04_06_timer1asCounterLCD.c,166 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
