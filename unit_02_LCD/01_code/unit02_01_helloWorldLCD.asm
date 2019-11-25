
_main:

;unit02_01_helloWorlldLCD.c,86 :: 		void main(){
;unit02_01_helloWorlldLCD.c,91 :: 		ADCON1 |= 0X0F;                // Config all ADC's pins as digital
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit02_01_helloWorlldLCD.c,94 :: 		Lcd_Init();                         // Initialize LCD
	CALL        _Lcd_Init+0, 0
;unit02_01_helloWorlldLCD.c,96 :: 		Lcd_Cmd(_LCD_CLEAR);                // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_01_helloWorlldLCD.c,97 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);           // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_01_helloWorlldLCD.c,99 :: 		Lcd_Out(1,1,"First Line");          // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_unit02_01_helloWorlldLCD+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_unit02_01_helloWorlldLCD+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_01_helloWorlldLCD.c,100 :: 		Lcd_Out(2,1,"Second Line");         // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_unit02_01_helloWorlldLCD+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_unit02_01_helloWorlldLCD+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_01_helloWorlldLCD.c,102 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
