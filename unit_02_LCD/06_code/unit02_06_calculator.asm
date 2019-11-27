
_getkeypad:

;unit02_06_calculator.c,92 :: 		unsigned char getkeypad()
;unit02_06_calculator.c,94 :: 		unsigned char i,  Key = 0;
	CLRF        getkeypad_Key_L0+0 
;unit02_06_calculator.c,95 :: 		PORTC = 0x01;                            // Start with column 1
	MOVLW       1
	MOVWF       PORTC+0 
;unit02_06_calculator.c,97 :: 		while((PORTC & MASK) == 0)         // While no key pressed
L_getkeypad0:
	MOVLW       240
	ANDWF       PORTC+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_getkeypad1
;unit02_06_calculator.c,99 :: 		PORTC = (PORTC << 1);               // next column
	MOVF        PORTC+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       PORTC+0 
;unit02_06_calculator.c,100 :: 		Key++;                               // column number
	INCF        getkeypad_Key_L0+0, 1 
;unit02_06_calculator.c,101 :: 		if(Key == 4)
	MOVF        getkeypad_Key_L0+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_getkeypad2
;unit02_06_calculator.c,103 :: 		PORTC = 0x01;                   // Back to column 1
	MOVLW       1
	MOVWF       PORTC+0 
;unit02_06_calculator.c,104 :: 		Key = 0;
	CLRF        getkeypad_Key_L0+0 
;unit02_06_calculator.c,105 :: 		}
L_getkeypad2:
;unit02_06_calculator.c,106 :: 		}
	GOTO        L_getkeypad0
L_getkeypad1:
;unit02_06_calculator.c,107 :: 		Delay_Ms(20);                            // Switch debounce
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_getkeypad3:
	DECFSZ      R13, 1, 1
	BRA         L_getkeypad3
	DECFSZ      R12, 1, 1
	BRA         L_getkeypad3
	NOP
	NOP
;unit02_06_calculator.c,108 :: 		for(i = 0x10; i !=0; i <<=1)                     // Find the key pressed
	MOVLW       16
	MOVWF       R2 
L_getkeypad4:
	MOVF        R2, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_getkeypad5
;unit02_06_calculator.c,109 :: 		{            if((PORTC & i) != 0)break;            Key = Key + 4;         }
	MOVF        R2, 0 
	ANDWF       PORTC+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_getkeypad7
	GOTO        L_getkeypad5
L_getkeypad7:
	MOVLW       4
	ADDWF       getkeypad_Key_L0+0, 1 
;unit02_06_calculator.c,108 :: 		for(i = 0x10; i !=0; i <<=1)                     // Find the key pressed
	RLCF        R2, 1 
	BCF         R2, 0 
;unit02_06_calculator.c,109 :: 		{            if((PORTC & i) != 0)break;            Key = Key + 4;         }
	GOTO        L_getkeypad4
L_getkeypad5:
;unit02_06_calculator.c,110 :: 		PORTC = 0x0F;
	MOVLW       15
	MOVWF       PORTC+0 
;unit02_06_calculator.c,111 :: 		while((PORTC & MASK) != 0);                // Wait unl key released
L_getkeypad8:
	MOVLW       240
	ANDWF       PORTC+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_getkeypad9
	GOTO        L_getkeypad8
L_getkeypad9:
;unit02_06_calculator.c,112 :: 		Delay_Ms(20);                                      // Switch debounce
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_getkeypad10:
	DECFSZ      R13, 1, 1
	BRA         L_getkeypad10
	DECFSZ      R12, 1, 1
	BRA         L_getkeypad10
	NOP
	NOP
;unit02_06_calculator.c,113 :: 		return (Key);                               // Return key number
	MOVF        getkeypad_Key_L0+0, 0 
	MOVWF       R0 
;unit02_06_calculator.c,114 :: 		}
L_end_getkeypad:
	RETURN      0
; end of _getkeypad

_main:

;unit02_06_calculator.c,116 :: 		void main(){
;unit02_06_calculator.c,125 :: 		ADCON1 |= 0X0F;                // Config all ADC's pins as digital
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit02_06_calculator.c,128 :: 		PORTE = 0;
	CLRF        PORTE+0 
;unit02_06_calculator.c,129 :: 		TRISE = 0;
	CLRF        TRISE+0 
;unit02_06_calculator.c,131 :: 		PORTD = 0;
	CLRF        PORTD+0 
;unit02_06_calculator.c,132 :: 		TRISD = 0XF0;                      // RC4–RC7 are inputs
	MOVLW       240
	MOVWF       TRISD+0 
;unit02_06_calculator.c,134 :: 		Lcd_Init();                         // Initialize LCD
	CALL        _Lcd_Init+0, 0
;unit02_06_calculator.c,136 :: 		Lcd_Cmd(_LCD_CLEAR);                // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_06_calculator.c,137 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);           // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_06_calculator.c,139 :: 		Lcd_Out(1,1,"CALCULATOR");          // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_unit02_06_calculator+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_unit02_06_calculator+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_06_calculator.c,142 :: 		for(;;)                                     // Endless loop
L_main11:
;unit02_06_calculator.c,144 :: 		MyKey = 0;
	CLRF        main_MyKey_L0+0 
;unit02_06_calculator.c,145 :: 		Op1 = 0;
	CLRF        main_Op1_L0+0 
	CLRF        main_Op1_L0+1 
	CLRF        main_Op1_L0+2 
	CLRF        main_Op1_L0+3 
;unit02_06_calculator.c,146 :: 		Op2 = 0;
	CLRF        main_Op2_L0+0 
	CLRF        main_Op2_L0+1 
	CLRF        main_Op2_L0+2 
	CLRF        main_Op2_L0+3 
;unit02_06_calculator.c,148 :: 		Lcd_Out(1,1,"No1: ");                   // Display No1:
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_unit02_06_calculator+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_unit02_06_calculator+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_06_calculator.c,150 :: 		while(1)                              // Get ?rst no
L_main14:
;unit02_06_calculator.c,152 :: 		MyKey = getkeypad();
	CALL        _getkeypad+0, 0
	MOVF        R0, 0 
	MOVWF       main_MyKey_L0+0 
;unit02_06_calculator.c,153 :: 		if(MyKey == Enter)break;             // If ENTER pressed
	MOVF        R0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_main16
	GOTO        L_main15
L_main16:
;unit02_06_calculator.c,154 :: 		MyKey++;
	INCF        main_MyKey_L0+0, 1 
;unit02_06_calculator.c,155 :: 		if(MyKey == 10)MyKey = 0;            // If 0 key pressed
	MOVF        main_MyKey_L0+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main17
	CLRF        main_MyKey_L0+0 
L_main17:
;unit02_06_calculator.c,156 :: 		Lcd_Chr_Cp(MyKey + '0');
	MOVLW       48
	ADDWF       main_MyKey_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;unit02_06_calculator.c,157 :: 		Op1 = 10 * Op1 + MyKey;              // First number in Op1
	MOVLW       10
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        main_Op1_L0+0, 0 
	MOVWF       R4 
	MOVF        main_Op1_L0+1, 0 
	MOVWF       R5 
	MOVF        main_Op1_L0+2, 0 
	MOVWF       R6 
	MOVF        main_Op1_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        main_MyKey_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       main_Op1_L0+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       main_Op1_L0+1 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       main_Op1_L0+2 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       main_Op1_L0+3 
;unit02_06_calculator.c,158 :: 		}
	GOTO        L_main14
L_main15:
;unit02_06_calculator.c,160 :: 		Lcd_Out(2,1,"No2: ");                   // Display No2:
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_unit02_06_calculator+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_unit02_06_calculator+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_06_calculator.c,162 :: 		while(1)                                 // Get ?rst no
L_main18:
;unit02_06_calculator.c,164 :: 		MyKey = getkeypad();
	CALL        _getkeypad+0, 0
	MOVF        R0, 0 
	MOVWF       main_MyKey_L0+0 
;unit02_06_calculator.c,165 :: 		if(MyKey == Enter)break;             // If ENTER pressed
	MOVF        R0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_main20
	GOTO        L_main19
L_main20:
;unit02_06_calculator.c,166 :: 		MyKey++;
	INCF        main_MyKey_L0+0, 1 
;unit02_06_calculator.c,167 :: 		if(MyKey == 10)MyKey = 0;            // If 0 key pressed
	MOVF        main_MyKey_L0+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main21
	CLRF        main_MyKey_L0+0 
L_main21:
;unit02_06_calculator.c,168 :: 		Lcd_Chr_Cp(MyKey + '0');
	MOVLW       48
	ADDWF       main_MyKey_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;unit02_06_calculator.c,169 :: 		Op2 = 10 * Op1 + MyKey;              // Second number in Op2
	MOVLW       10
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        main_Op1_L0+0, 0 
	MOVWF       R4 
	MOVF        main_Op1_L0+1, 0 
	MOVWF       R5 
	MOVF        main_Op1_L0+2, 0 
	MOVWF       R6 
	MOVF        main_Op1_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        main_MyKey_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       main_Op2_L0+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       main_Op2_L0+1 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       main_Op2_L0+2 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       main_Op2_L0+3 
;unit02_06_calculator.c,170 :: 		}
	GOTO        L_main18
L_main19:
;unit02_06_calculator.c,171 :: 		Lcd_Cmd(_LCD_CLEAR);                     // Clear LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_06_calculator.c,172 :: 		Lcd_Out(1,1,"Op: ");                    // Display Op:
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_unit02_06_calculator+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_unit02_06_calculator+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_06_calculator.c,173 :: 		MyKey = getkeypad();                    // Get operaon
	CALL        _getkeypad+0, 0
	MOVF        R0, 0 
	MOVWF       main_MyKey_L0+0 
;unit02_06_calculator.c,174 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_06_calculator.c,175 :: 		Lcd_Out(1,1,"Res=");                    // Display Res=
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_unit02_06_calculator+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_unit02_06_calculator+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_06_calculator.c,177 :: 		switch(MyKey)                           // Perform the operaon
	GOTO        L_main22
;unit02_06_calculator.c,179 :: 		case Plus:
L_main24:
;unit02_06_calculator.c,180 :: 		Calc = Op1 + Op2;             // If ADD
	MOVF        main_Op2_L0+0, 0 
	ADDWF       main_Op1_L0+0, 0 
	MOVWF       main_Calc_L0+0 
	MOVF        main_Op2_L0+1, 0 
	ADDWFC      main_Op1_L0+1, 0 
	MOVWF       main_Calc_L0+1 
	MOVF        main_Op2_L0+2, 0 
	ADDWFC      main_Op1_L0+2, 0 
	MOVWF       main_Calc_L0+2 
	MOVF        main_Op2_L0+3, 0 
	ADDWFC      main_Op1_L0+3, 0 
	MOVWF       main_Calc_L0+3 
;unit02_06_calculator.c,181 :: 		break;
	GOTO        L_main23
;unit02_06_calculator.c,182 :: 		case Minus:
L_main25:
;unit02_06_calculator.c,183 :: 		Calc = Op1 - Op2;                // If Subtract
	MOVF        main_Op1_L0+0, 0 
	MOVWF       main_Calc_L0+0 
	MOVF        main_Op1_L0+1, 0 
	MOVWF       main_Calc_L0+1 
	MOVF        main_Op1_L0+2, 0 
	MOVWF       main_Calc_L0+2 
	MOVF        main_Op1_L0+3, 0 
	MOVWF       main_Calc_L0+3 
	MOVF        main_Op2_L0+0, 0 
	SUBWF       main_Calc_L0+0, 1 
	MOVF        main_Op2_L0+1, 0 
	SUBWFB      main_Calc_L0+1, 1 
	MOVF        main_Op2_L0+2, 0 
	SUBWFB      main_Calc_L0+2, 1 
	MOVF        main_Op2_L0+3, 0 
	SUBWFB      main_Calc_L0+3, 1 
;unit02_06_calculator.c,184 :: 		break;
	GOTO        L_main23
;unit02_06_calculator.c,185 :: 		case Mulply:
L_main26:
;unit02_06_calculator.c,186 :: 		Calc = Op1 * Op2;             // If Mulply
	MOVF        main_Op1_L0+0, 0 
	MOVWF       R0 
	MOVF        main_Op1_L0+1, 0 
	MOVWF       R1 
	MOVF        main_Op1_L0+2, 0 
	MOVWF       R2 
	MOVF        main_Op1_L0+3, 0 
	MOVWF       R3 
	MOVF        main_Op2_L0+0, 0 
	MOVWF       R4 
	MOVF        main_Op2_L0+1, 0 
	MOVWF       R5 
	MOVF        main_Op2_L0+2, 0 
	MOVWF       R6 
	MOVF        main_Op2_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       main_Calc_L0+0 
	MOVF        R1, 0 
	MOVWF       main_Calc_L0+1 
	MOVF        R2, 0 
	MOVWF       main_Calc_L0+2 
	MOVF        R3, 0 
	MOVWF       main_Calc_L0+3 
;unit02_06_calculator.c,187 :: 		break;
	GOTO        L_main23
;unit02_06_calculator.c,188 :: 		case Divide:
L_main27:
;unit02_06_calculator.c,189 :: 		Calc = Op1/Op2;            // If Divide
	MOVF        main_Op2_L0+0, 0 
	MOVWF       R4 
	MOVF        main_Op2_L0+1, 0 
	MOVWF       R5 
	MOVF        main_Op2_L0+2, 0 
	MOVWF       R6 
	MOVF        main_Op2_L0+3, 0 
	MOVWF       R7 
	MOVF        main_Op1_L0+0, 0 
	MOVWF       R0 
	MOVF        main_Op1_L0+1, 0 
	MOVWF       R1 
	MOVF        main_Op1_L0+2, 0 
	MOVWF       R2 
	MOVF        main_Op1_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       main_Calc_L0+0 
	MOVF        R1, 0 
	MOVWF       main_Calc_L0+1 
	MOVF        R2, 0 
	MOVWF       main_Calc_L0+2 
	MOVF        R3, 0 
	MOVWF       main_Calc_L0+3 
;unit02_06_calculator.c,190 :: 		break;
	GOTO        L_main23
;unit02_06_calculator.c,191 :: 		}
L_main22:
	MOVF        main_MyKey_L0+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_main24
	MOVF        main_MyKey_L0+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_main25
	MOVF        main_MyKey_L0+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_main26
	MOVF        main_MyKey_L0+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_main27
L_main23:
;unit02_06_calculator.c,193 :: 		LongToStr(Calc, op);                    // Convert to string in op
	MOVF        main_Calc_L0+0, 0 
	MOVWF       FARG_LongToStr_input+0 
	MOVF        main_Calc_L0+1, 0 
	MOVWF       FARG_LongToStr_input+1 
	MOVF        main_Calc_L0+2, 0 
	MOVWF       FARG_LongToStr_input+2 
	MOVF        main_Calc_L0+3, 0 
	MOVWF       FARG_LongToStr_input+3 
	MOVLW       main_op_L0+0
	MOVWF       FARG_LongToStr_output+0 
	MOVLW       hi_addr(main_op_L0+0)
	MOVWF       FARG_LongToStr_output+1 
	CALL        _LongToStr+0, 0
;unit02_06_calculator.c,194 :: 		lcd = Ltrim(op);                       // Remove leading blanks
	MOVLW       main_op_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(main_op_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;unit02_06_calculator.c,195 :: 		Lcd_Out_Cp(lcd);                        // Display result
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVF        R1, 0 
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;unit02_06_calculator.c,196 :: 		Delay_ms(5000);                         // Wait 5 s
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_main28:
	DECFSZ      R13, 1, 1
	BRA         L_main28
	DECFSZ      R12, 1, 1
	BRA         L_main28
	DECFSZ      R11, 1, 1
	BRA         L_main28
	NOP
	NOP
;unit02_06_calculator.c,197 :: 		Lcd_Cmd(_LCD_CLEAR);                    // Clear LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_06_calculator.c,198 :: 		}
	GOTO        L_main11
;unit02_06_calculator.c,200 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
