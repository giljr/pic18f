
_CustomChar:

;unit02_04_customChar.c,90 :: 		void CustomChar(char pos_row, char pos_char) {
;unit02_04_customChar.c,92 :: 		Lcd_Cmd(64);
	MOVLW       64
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_04_customChar.c,93 :: 		for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
	CLRF        CustomChar_i_L0+0 
L_CustomChar0:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar1
	MOVLW       _character+0
	ADDWF       CustomChar_i_L0+0, 0 
	MOVWF       TBLPTR+0 
	MOVLW       hi_addr(_character+0)
	MOVWF       TBLPTR+1 
	MOVLW       0
	ADDWFC      TBLPTR+1, 1 
	MOVLW       higher_addr(_character+0)
	MOVWF       TBLPTR+2 
	MOVLW       0
	ADDWFC      TBLPTR+2, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Lcd_Chr_CP_out_char+0
	CALL        _Lcd_Chr_CP+0, 0
	INCF        CustomChar_i_L0+0, 1 
	GOTO        L_CustomChar0
L_CustomChar1:
;unit02_04_customChar.c,94 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_04_customChar.c,95 :: 		Lcd_Chr(pos_row, pos_char, 0);
	MOVF        FARG_CustomChar_pos_row+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_CustomChar_pos_char+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	CLRF        FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;unit02_04_customChar.c,96 :: 		}
L_end_CustomChar:
	RETURN      0
; end of _CustomChar

_main:

;unit02_04_customChar.c,98 :: 		void main(){
;unit02_04_customChar.c,103 :: 		ADCON1 |= 0X0F;                // Config all ADC's pins as digital
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit02_04_customChar.c,106 :: 		Lcd_Init();                         // Initialize LCD
	CALL        _Lcd_Init+0, 0
;unit02_04_customChar.c,108 :: 		Lcd_Cmd(_LCD_CLEAR);                // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_04_customChar.c,109 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);           // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_04_customChar.c,111 :: 		Lcd_Out(1,1,"Right arrow");          // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_unit02_04_customChar+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_unit02_04_customChar+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_04_customChar.c,112 :: 		CustomChar(1, 13);                   // Display the "right arrow" symbol
	MOVLW       1
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       13
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;unit02_04_customChar.c,114 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
