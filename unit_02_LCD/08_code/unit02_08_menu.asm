
_ReturnToDefaultMenu:

;unit02_08_menu.c,64 :: 		void ReturnToDefaultMenu()
;unit02_08_menu.c,66 :: 		m_state_level_one = 1;
	MOVLW       1
	MOVWF       _m_state_level_one+0 
	MOVLW       0
	MOVWF       _m_state_level_one+1 
;unit02_08_menu.c,67 :: 		submenu = 0;                   //force condition to default menu - Level one
	CLRF        _submenu+0 
	CLRF        _submenu+1 
;unit02_08_menu.c,68 :: 		m_state_level_two = 1;
	MOVLW       1
	MOVWF       _m_state_level_two+0 
	MOVLW       0
	MOVWF       _m_state_level_two+1 
;unit02_08_menu.c,69 :: 		state_selected = 1;
	MOVLW       1
	MOVWF       _state_selected+0 
	MOVLW       0
	MOVWF       _state_selected+1 
;unit02_08_menu.c,72 :: 		Lcd_Cmd(_LCD_CLEAR);           // Delete all text and subscribe default text
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_08_menu.c,73 :: 		Lcd_Out(1, 1,">OPTION1 [ENTER]");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_unit02_08_menu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_unit02_08_menu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_08_menu.c,74 :: 		Lcd_Out(2, 1," OPTION2        ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_unit02_08_menu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_unit02_08_menu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_08_menu.c,75 :: 		}
L_end_ReturnToDefaultMenu:
	RETURN      0
; end of _ReturnToDefaultMenu

_ConfigMCU:

;unit02_08_menu.c,78 :: 		void ConfigMCU()
;unit02_08_menu.c,84 :: 		ADCON1 |= 0X0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit02_08_menu.c,86 :: 		TRISB.RB0 = 1; PORTB.RB0 = 1;  //SELETION
	BSF         TRISB+0, 0 
	BSF         PORTB+0, 0 
;unit02_08_menu.c,87 :: 		TRISB.RB1 = 1; PORTB.RB1 = 1;  //ENTER
	BSF         TRISB+0, 1 
	BSF         PORTB+0, 1 
;unit02_08_menu.c,88 :: 		TRISB.RB2 = 1; PORTB.RB2 = 1;  //RETURN
	BSF         TRISB+0, 2 
	BSF         PORTB+0, 2 
;unit02_08_menu.c,89 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_main:

;unit02_08_menu.c,91 :: 		void main()
;unit02_08_menu.c,93 :: 		ConfigMCU();
	CALL        _ConfigMCU+0, 0
;unit02_08_menu.c,95 :: 		Lcd_Init();                    // Initialize LCD's display
	CALL        _Lcd_Init+0, 0
;unit02_08_menu.c,96 :: 		Lcd_Cmd(_LCD_CLEAR);           // Delete display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_08_menu.c,97 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);      // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_08_menu.c,100 :: 		Lcd_Out(1, 1,">OPTION1 [ENTER]");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_unit02_08_menu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_unit02_08_menu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_08_menu.c,101 :: 		Lcd_Out(2, 1," OPTION2        ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_unit02_08_menu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_unit02_08_menu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_08_menu.c,103 :: 		while (TRUE)
L_main0:
;unit02_08_menu.c,109 :: 		if (SELECT_MENU == 0 && submenu == 0)
	BTFSC       PORTB+0, 0 
	GOTO        L_main4
	MOVLW       0
	XORWF       _submenu+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main31
	MOVLW       0
	XORWF       _submenu+0, 0 
L__main31:
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
L__main27:
;unit02_08_menu.c,111 :: 		switch(m_state_level_one)
	GOTO        L_main5
;unit02_08_menu.c,113 :: 		case 1:
L_main7:
;unit02_08_menu.c,114 :: 		Lcd_Chr(1,1,'>'); LCD_Out(1,9," [ENTER]");
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       62
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_unit02_08_menu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_unit02_08_menu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_08_menu.c,115 :: 		m_state_level_one = 2;
	MOVLW       2
	MOVWF       _m_state_level_one+0 
	MOVLW       0
	MOVWF       _m_state_level_one+1 
;unit02_08_menu.c,116 :: 		state_selected = 1;
	MOVLW       1
	MOVWF       _state_selected+0 
	MOVLW       0
	MOVWF       _state_selected+1 
;unit02_08_menu.c,117 :: 		Lcd_Chr(2,1,' '); LCD_Out(2,9,"        ");
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_unit02_08_menu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_unit02_08_menu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_08_menu.c,118 :: 		break;
	GOTO        L_main6
;unit02_08_menu.c,119 :: 		case 2:
L_main8:
;unit02_08_menu.c,120 :: 		Lcd_Chr(2,1,'>'); LCD_Out(2,9," [ENTER]");
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       62
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_unit02_08_menu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_unit02_08_menu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_08_menu.c,121 :: 		m_state_level_one = 1;
	MOVLW       1
	MOVWF       _m_state_level_one+0 
	MOVLW       0
	MOVWF       _m_state_level_one+1 
;unit02_08_menu.c,122 :: 		state_selected = 2;
	MOVLW       2
	MOVWF       _state_selected+0 
	MOVLW       0
	MOVWF       _state_selected+1 
;unit02_08_menu.c,123 :: 		Lcd_Chr(1,1,' '); LCD_Out(1,9,"                ");
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_unit02_08_menu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_unit02_08_menu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_08_menu.c,124 :: 		break;
	GOTO        L_main6
;unit02_08_menu.c,125 :: 		}
L_main5:
	MOVLW       0
	XORWF       _m_state_level_one+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main32
	MOVLW       1
	XORWF       _m_state_level_one+0, 0 
L__main32:
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
	MOVLW       0
	XORWF       _m_state_level_one+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main33
	MOVLW       2
	XORWF       _m_state_level_one+0, 0 
L__main33:
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
L_main6:
;unit02_08_menu.c,126 :: 		}
L_main4:
;unit02_08_menu.c,130 :: 		if (ENTER_MENU == 0)
	BTFSC       PORTB+0, 1 
	GOTO        L_main9
;unit02_08_menu.c,132 :: 		switch(state_selected)
	GOTO        L_main10
;unit02_08_menu.c,134 :: 		case 1:
L_main12:
;unit02_08_menu.c,135 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_08_menu.c,136 :: 		Lcd_Out(1, 1," OPTION1");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr9_unit02_08_menu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_unit02_08_menu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_08_menu.c,137 :: 		Lcd_Out(1,9,">SENSOR1");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_unit02_08_menu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_unit02_08_menu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_08_menu.c,138 :: 		Lcd_Out(2,9," EQUIP1");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr11_unit02_08_menu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr11_unit02_08_menu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_08_menu.c,139 :: 		submenu = 1;  // Informa que estamos no segundo nível do menu
	MOVLW       1
	MOVWF       _submenu+0 
	MOVLW       0
	MOVWF       _submenu+1 
;unit02_08_menu.c,140 :: 		break;
	GOTO        L_main11
;unit02_08_menu.c,141 :: 		case 2:
L_main13:
;unit02_08_menu.c,142 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unit02_08_menu.c,143 :: 		Lcd_Out(1, 1," OPTION2");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr12_unit02_08_menu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr12_unit02_08_menu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_08_menu.c,144 :: 		Lcd_Out(1,9,">SENSOR2");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr13_unit02_08_menu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr13_unit02_08_menu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_08_menu.c,145 :: 		Lcd_Out(2,9," EQUIP2");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr14_unit02_08_menu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr14_unit02_08_menu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unit02_08_menu.c,146 :: 		submenu = 1;  // again
	MOVLW       1
	MOVWF       _submenu+0 
	MOVLW       0
	MOVWF       _submenu+1 
;unit02_08_menu.c,147 :: 		break;
	GOTO        L_main11
;unit02_08_menu.c,148 :: 		}
L_main10:
	MOVLW       0
	XORWF       _state_selected+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main34
	MOVLW       1
	XORWF       _state_selected+0, 0 
L__main34:
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
	MOVLW       0
	XORWF       _state_selected+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main35
	MOVLW       2
	XORWF       _state_selected+0, 0 
L__main35:
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
L_main11:
;unit02_08_menu.c,149 :: 		}
L_main9:
;unit02_08_menu.c,153 :: 		if (SELECT_MENU == 0 && submenu == 1)
	BTFSC       PORTB+0, 0 
	GOTO        L_main16
	MOVLW       0
	XORWF       _submenu+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main36
	MOVLW       1
	XORWF       _submenu+0, 0 
L__main36:
	BTFSS       STATUS+0, 2 
	GOTO        L_main16
L__main26:
;unit02_08_menu.c,155 :: 		switch(m_state_level_two)
	GOTO        L_main17
;unit02_08_menu.c,157 :: 		case 1:
L_main19:
;unit02_08_menu.c,158 :: 		Lcd_Chr(1,9,'>');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       62
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;unit02_08_menu.c,159 :: 		m_state_level_two = 2;
	MOVLW       2
	MOVWF       _m_state_level_two+0 
	MOVLW       0
	MOVWF       _m_state_level_two+1 
;unit02_08_menu.c,160 :: 		Lcd_Chr(2,9,' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;unit02_08_menu.c,161 :: 		break;
	GOTO        L_main18
;unit02_08_menu.c,162 :: 		case 2:
L_main20:
;unit02_08_menu.c,163 :: 		Lcd_Chr(2,9,'>');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       62
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;unit02_08_menu.c,164 :: 		m_state_level_two = 1;
	MOVLW       1
	MOVWF       _m_state_level_two+0 
	MOVLW       0
	MOVWF       _m_state_level_two+1 
;unit02_08_menu.c,165 :: 		Lcd_Chr(1,9,' ');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;unit02_08_menu.c,166 :: 		break;
	GOTO        L_main18
;unit02_08_menu.c,167 :: 		}
L_main17:
	MOVLW       0
	XORWF       _m_state_level_two+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main37
	MOVLW       1
	XORWF       _m_state_level_two+0, 0 
L__main37:
	BTFSC       STATUS+0, 2 
	GOTO        L_main19
	MOVLW       0
	XORWF       _m_state_level_two+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main38
	MOVLW       2
	XORWF       _m_state_level_two+0, 0 
L__main38:
	BTFSC       STATUS+0, 2 
	GOTO        L_main20
L_main18:
;unit02_08_menu.c,168 :: 		}
L_main16:
;unit02_08_menu.c,171 :: 		if (RETURN_MAIN_MENU == 0 && submenu == 1)
	BTFSC       PORTB+0, 2 
	GOTO        L_main23
	MOVLW       0
	XORWF       _submenu+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main39
	MOVLW       1
	XORWF       _submenu+0, 0 
L__main39:
	BTFSS       STATUS+0, 2 
	GOTO        L_main23
L__main25:
;unit02_08_menu.c,173 :: 		ReturnToDefaultMenu();
	CALL        _ReturnToDefaultMenu+0, 0
;unit02_08_menu.c,174 :: 		}
L_main23:
;unit02_08_menu.c,176 :: 		Delay_ms(250);           // needed to treat debounce here!
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main24:
	DECFSZ      R13, 1, 1
	BRA         L_main24
	DECFSZ      R12, 1, 1
	BRA         L_main24
	DECFSZ      R11, 1, 1
	BRA         L_main24
	NOP
	NOP
;unit02_08_menu.c,178 :: 		}
	GOTO        L_main0
;unit02_08_menu.c,180 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
