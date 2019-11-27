
_lcdr:

;unit02_07_keypad.c,85 :: 		void lcdr(char a[5])                  // Auxiliary Function - LCD Return (lcdr)
;unit02_07_keypad.c,87 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;unit02_07_keypad.c,88 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_07_keypad.c,89 :: 		LCD_out_cp(a);
	MOVF        FARG_lcdr_a+0, 0 
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVF        FARG_lcdr_a+1, 0 
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;unit02_07_keypad.c,90 :: 		TRISD = 0XFF;
	MOVLW       255
	MOVWF       TRISD+0 
;unit02_07_keypad.c,91 :: 		}
L_end_lcdr:
	RETURN      0
; end of _lcdr

_main:

;unit02_07_keypad.c,93 :: 		void main(){                          // KEYPAD 4X3 Matrix -> 4 LINE X 3 COLUMN
;unit02_07_keypad.c,101 :: 		ADCON1 |= 0X0F;                // Config all ADC's pins as digital
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit02_07_keypad.c,104 :: 		ADCON1 = 0x06;                      // Define AD's pin as general I/O
	MOVLW       6
	MOVWF       ADCON1+0 
;unit02_07_keypad.c,105 :: 		TRISE = 0;
	CLRF        TRISE+0 
;unit02_07_keypad.c,106 :: 		TRISD = 0;                          // Configure PORTA as output
	CLRF        TRISD+0 
;unit02_07_keypad.c,108 :: 		Lcd_Init();                         // Initialize LCD
	CALL        _Lcd_Init+0, 0
;unit02_07_keypad.c,110 :: 		Lcd_Cmd(_LCD_CLEAR);                // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_07_keypad.c,111 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);           // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_07_keypad.c,113 :: 		Lcd_Out(1,1,"Keypad V1");           // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_unit02_07_keypad+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_unit02_07_keypad+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_07_keypad.c,116 :: 		PORTB = 0XFF;                       // PORTB as FF
	MOVLW       255
	MOVWF       PORTB+0 
;unit02_07_keypad.c,117 :: 		TRISB = 0;                          // Configure PORTB as output
	CLRF        TRISB+0 
;unit02_07_keypad.c,119 :: 		TRISD = 0XFF;                       // TRISD as FF
	MOVLW       255
	MOVWF       TRISD+0 
;unit02_07_keypad.c,120 :: 		PORTD = 0XFF;                       // PORTD as FF
	MOVLW       255
	MOVWF       PORTD+0 
;unit02_07_keypad.c,121 :: 		TRISD = 0XFF;                       // Configure PORTD as input
	MOVLW       255
	MOVWF       TRISD+0 
;unit02_07_keypad.c,123 :: 		do                                  // Routine's init for keypad scanning
L_main0:
;unit02_07_keypad.c,126 :: 		PORTB.RB0 = 0;
	BCF         PORTB+0, 0 
;unit02_07_keypad.c,127 :: 		line = PORTD;
	MOVF        PORTD+0, 0 
	MOVWF       main_line_L0+0 
;unit02_07_keypad.c,128 :: 		if (line.RD0 == 0) lcdr("<--");
	BTFSC       main_line_L0+0, 0 
	GOTO        L_main3
	MOVLW       ?lstr2_unit02_07_keypad+0
	MOVWF       FARG_lcdr_a+0 
	MOVLW       hi_addr(?lstr2_unit02_07_keypad+0)
	MOVWF       FARG_lcdr_a+1 
	CALL        _lcdr+0, 0
	GOTO        L_main4
L_main3:
;unit02_07_keypad.c,129 :: 		else if (line.RD1 == 0) lcdr("7");
	BTFSC       main_line_L0+0, 1 
	GOTO        L_main5
	MOVLW       ?lstr3_unit02_07_keypad+0
	MOVWF       FARG_lcdr_a+0 
	MOVLW       hi_addr(?lstr3_unit02_07_keypad+0)
	MOVWF       FARG_lcdr_a+1 
	CALL        _lcdr+0, 0
	GOTO        L_main6
L_main5:
;unit02_07_keypad.c,130 :: 		else if (line.RD2 == 0) lcdr("4");
	BTFSC       main_line_L0+0, 2 
	GOTO        L_main7
	MOVLW       ?lstr4_unit02_07_keypad+0
	MOVWF       FARG_lcdr_a+0 
	MOVLW       hi_addr(?lstr4_unit02_07_keypad+0)
	MOVWF       FARG_lcdr_a+1 
	CALL        _lcdr+0, 0
	GOTO        L_main8
L_main7:
;unit02_07_keypad.c,131 :: 		else if (line.RD3 == 0) lcdr("1");
	BTFSC       main_line_L0+0, 3 
	GOTO        L_main9
	MOVLW       ?lstr5_unit02_07_keypad+0
	MOVWF       FARG_lcdr_a+0 
	MOVLW       hi_addr(?lstr5_unit02_07_keypad+0)
	MOVWF       FARG_lcdr_a+1 
	CALL        _lcdr+0, 0
L_main9:
L_main8:
L_main6:
L_main4:
;unit02_07_keypad.c,132 :: 		PORTB.RB0 = 1;                    // Disable keypad's first column
	BSF         PORTB+0, 0 
;unit02_07_keypad.c,135 :: 		PORTB.RB1 = 0;
	BCF         PORTB+0, 1 
;unit02_07_keypad.c,136 :: 		line = PORTD;
	MOVF        PORTD+0, 0 
	MOVWF       main_line_L0+0 
;unit02_07_keypad.c,137 :: 		if (line.RD0 == 0) lcdr("0");
	BTFSC       main_line_L0+0, 0 
	GOTO        L_main10
	MOVLW       ?lstr6_unit02_07_keypad+0
	MOVWF       FARG_lcdr_a+0 
	MOVLW       hi_addr(?lstr6_unit02_07_keypad+0)
	MOVWF       FARG_lcdr_a+1 
	CALL        _lcdr+0, 0
	GOTO        L_main11
L_main10:
;unit02_07_keypad.c,138 :: 		else if (line.RD1 == 0) lcdr("8");
	BTFSC       main_line_L0+0, 1 
	GOTO        L_main12
	MOVLW       ?lstr7_unit02_07_keypad+0
	MOVWF       FARG_lcdr_a+0 
	MOVLW       hi_addr(?lstr7_unit02_07_keypad+0)
	MOVWF       FARG_lcdr_a+1 
	CALL        _lcdr+0, 0
	GOTO        L_main13
L_main12:
;unit02_07_keypad.c,139 :: 		else if (line.RD2 == 0) lcdr("5");
	BTFSC       main_line_L0+0, 2 
	GOTO        L_main14
	MOVLW       ?lstr8_unit02_07_keypad+0
	MOVWF       FARG_lcdr_a+0 
	MOVLW       hi_addr(?lstr8_unit02_07_keypad+0)
	MOVWF       FARG_lcdr_a+1 
	CALL        _lcdr+0, 0
	GOTO        L_main15
L_main14:
;unit02_07_keypad.c,140 :: 		else if (line.RD3 == 0) lcdr("2");
	BTFSC       main_line_L0+0, 3 
	GOTO        L_main16
	MOVLW       ?lstr9_unit02_07_keypad+0
	MOVWF       FARG_lcdr_a+0 
	MOVLW       hi_addr(?lstr9_unit02_07_keypad+0)
	MOVWF       FARG_lcdr_a+1 
	CALL        _lcdr+0, 0
L_main16:
L_main15:
L_main13:
L_main11:
;unit02_07_keypad.c,141 :: 		PORTB.RB1 = 1;                    // Disable keypad's second column
	BSF         PORTB+0, 1 
;unit02_07_keypad.c,144 :: 		PORTB.RB2 = 0;
	BCF         PORTB+0, 2 
;unit02_07_keypad.c,145 :: 		line = PORTD;
	MOVF        PORTD+0, 0 
	MOVWF       main_line_L0+0 
;unit02_07_keypad.c,146 :: 		if (line.RD0 == 0) lcdr("-->");
	BTFSC       main_line_L0+0, 0 
	GOTO        L_main17
	MOVLW       ?lstr10_unit02_07_keypad+0
	MOVWF       FARG_lcdr_a+0 
	MOVLW       hi_addr(?lstr10_unit02_07_keypad+0)
	MOVWF       FARG_lcdr_a+1 
	CALL        _lcdr+0, 0
	GOTO        L_main18
L_main17:
;unit02_07_keypad.c,147 :: 		else if (line.RD1 == 0) lcdr("9");
	BTFSC       main_line_L0+0, 1 
	GOTO        L_main19
	MOVLW       ?lstr11_unit02_07_keypad+0
	MOVWF       FARG_lcdr_a+0 
	MOVLW       hi_addr(?lstr11_unit02_07_keypad+0)
	MOVWF       FARG_lcdr_a+1 
	CALL        _lcdr+0, 0
	GOTO        L_main20
L_main19:
;unit02_07_keypad.c,148 :: 		else if (line.RD2 == 0) lcdr("6");
	BTFSC       main_line_L0+0, 2 
	GOTO        L_main21
	MOVLW       ?lstr12_unit02_07_keypad+0
	MOVWF       FARG_lcdr_a+0 
	MOVLW       hi_addr(?lstr12_unit02_07_keypad+0)
	MOVWF       FARG_lcdr_a+1 
	CALL        _lcdr+0, 0
	GOTO        L_main22
L_main21:
;unit02_07_keypad.c,149 :: 		else if (line.RD3 == 0) lcdr("3");
	BTFSC       main_line_L0+0, 3 
	GOTO        L_main23
	MOVLW       ?lstr13_unit02_07_keypad+0
	MOVWF       FARG_lcdr_a+0 
	MOVLW       hi_addr(?lstr13_unit02_07_keypad+0)
	MOVWF       FARG_lcdr_a+1 
	CALL        _lcdr+0, 0
L_main23:
L_main22:
L_main20:
L_main18:
;unit02_07_keypad.c,150 :: 		PORTB.RB2 = 1;                    // Disable keypad's third column
	BSF         PORTB+0, 2 
;unit02_07_keypad.c,152 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main24:
	DECFSZ      R13, 1, 1
	BRA         L_main24
	DECFSZ      R12, 1, 1
	BRA         L_main24
	DECFSZ      R11, 1, 1
	BRA         L_main24
	NOP
;unit02_07_keypad.c,155 :: 		while(1);
	GOTO        L_main0
;unit02_07_keypad.c,157 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
