
_Move_Delay:

;unit_02_02_movingTextLCD.c,98 :: 		void Move_Delay() {                   // Function used for text moving
;unit_02_02_movingTextLCD.c,99 :: 		Delay_ms(500);                      // You can change the moving speed here
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Move_Delay0:
	DECFSZ      R13, 1, 1
	BRA         L_Move_Delay0
	DECFSZ      R12, 1, 1
	BRA         L_Move_Delay0
	DECFSZ      R11, 1, 1
	BRA         L_Move_Delay0
	NOP
	NOP
;unit_02_02_movingTextLCD.c,100 :: 		}
L_end_Move_Delay:
	RETURN      0
; end of _Move_Delay

_main:

;unit_02_02_movingTextLCD.c,102 :: 		void main(){
;unit_02_02_movingTextLCD.c,107 :: 		ADCON1 |= 0X0F;                // Config all ADC's pins as digital
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit_02_02_movingTextLCD.c,110 :: 		Lcd_Init();                         // Initialize LCD
	CALL        _Lcd_Init+0, 0
;unit_02_02_movingTextLCD.c,112 :: 		Lcd_Cmd(_LCD_CLEAR);                // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit_02_02_movingTextLCD.c,113 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);           // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit_02_02_movingTextLCD.c,114 :: 		Lcd_Out(1,1,txt3);                  // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt3+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt3+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit_02_02_movingTextLCD.c,116 :: 		Lcd_Out(2,4,txt4);                  // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt4+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit_02_02_movingTextLCD.c,117 :: 		Delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main1:
	DECFSZ      R13, 1, 1
	BRA         L_main1
	DECFSZ      R12, 1, 1
	BRA         L_main1
	DECFSZ      R11, 1, 1
	BRA         L_main1
	NOP
;unit_02_02_movingTextLCD.c,118 :: 		Lcd_Cmd(_LCD_CLEAR);                // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit_02_02_movingTextLCD.c,120 :: 		Lcd_Out(1,1,txt1);                  // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit_02_02_movingTextLCD.c,121 :: 		Lcd_Out(2,1,txt2);                  // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit_02_02_movingTextLCD.c,123 :: 		Delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
;unit_02_02_movingTextLCD.c,126 :: 		for(i=0; i<4; i++) {                // Move text to the right 4 times
	CLRF        _i+0 
L_main3:
	MOVLW       4
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main4
;unit_02_02_movingTextLCD.c,127 :: 		Lcd_Cmd(_LCD_SHIFT_RIGHT);
	MOVLW       28
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit_02_02_movingTextLCD.c,128 :: 		Move_Delay();
	CALL        _Move_Delay+0, 0
;unit_02_02_movingTextLCD.c,126 :: 		for(i=0; i<4; i++) {                // Move text to the right 4 times
	INCF        _i+0, 1 
;unit_02_02_movingTextLCD.c,129 :: 		}
	GOTO        L_main3
L_main4:
;unit_02_02_movingTextLCD.c,131 :: 		while(1) {                          // Endless loop
L_main6:
;unit_02_02_movingTextLCD.c,132 :: 		for(i=0; i<8; i++) {              // Move text to the left 7 times
	CLRF        _i+0 
L_main8:
	MOVLW       8
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main9
;unit_02_02_movingTextLCD.c,133 :: 		Lcd_Cmd(_LCD_SHIFT_LEFT);
	MOVLW       24
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit_02_02_movingTextLCD.c,134 :: 		Move_Delay();
	CALL        _Move_Delay+0, 0
;unit_02_02_movingTextLCD.c,132 :: 		for(i=0; i<8; i++) {              // Move text to the left 7 times
	INCF        _i+0, 1 
;unit_02_02_movingTextLCD.c,135 :: 		}
	GOTO        L_main8
L_main9:
;unit_02_02_movingTextLCD.c,137 :: 		for(i=0; i<8; i++) {              // Move text to the right 7 times
	CLRF        _i+0 
L_main11:
	MOVLW       8
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main12
;unit_02_02_movingTextLCD.c,138 :: 		Lcd_Cmd(_LCD_SHIFT_RIGHT);
	MOVLW       28
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit_02_02_movingTextLCD.c,139 :: 		Move_Delay();
	CALL        _Move_Delay+0, 0
;unit_02_02_movingTextLCD.c,137 :: 		for(i=0; i<8; i++) {              // Move text to the right 7 times
	INCF        _i+0, 1 
;unit_02_02_movingTextLCD.c,140 :: 		}
	GOTO        L_main11
L_main12:
;unit_02_02_movingTextLCD.c,141 :: 		}
	GOTO        L_main6
;unit_02_02_movingTextLCD.c,142 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
