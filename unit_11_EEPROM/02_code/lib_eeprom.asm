
_EEPROM_Write_byte:

;lib_eeprom.c,3 :: 		void EEPROM_Write_byte(unsigned char address, unsigned char dta)
;lib_eeprom.c,5 :: 		char  STATUS_GIE  = 0;
	CLRF        EEPROM_Write_byte_STATUS_GIE_L0+0 
;lib_eeprom.c,6 :: 		EEADR        = address; //Endereço a ser gravado
	MOVF        FARG_EEPROM_Write_byte_address+0, 0 
	MOVWF       EEADR+0 
;lib_eeprom.c,7 :: 		EEDATA       = dta;     //Byte a ser gravado
	MOVF        FARG_EEPROM_Write_byte_dta+0, 0 
	MOVWF       EEDATA+0 
;lib_eeprom.c,8 :: 		EECON1.EEPGD = 0;   //Aponta para a memória EEPROM
	BCF         EECON1+0, 7 
;lib_eeprom.c,9 :: 		EECON1.CFGS  = 0;   //Acesso ao controle da EEPROM
	BCF         EECON1+0, 6 
;lib_eeprom.c,10 :: 		EECON1.WREN  = 1;   //Habilita modo de gravação da EEPROM
	BSF         EECON1+0, 2 
;lib_eeprom.c,11 :: 		STATUS_GIE = INTCON.GIEH;
	MOVLW       0
	BTFSC       INTCON+0, 7 
	MOVLW       1
	MOVWF       EEPROM_Write_byte_STATUS_GIE_L0+0 
;lib_eeprom.c,12 :: 		INTCON.GIEH = 0;
	BCF         INTCON+0, 7 
;lib_eeprom.c,13 :: 		EECON2 = 0x55;      //procedimento obrigatório p/ escrita
	MOVLW       85
	MOVWF       EECON2+0 
;lib_eeprom.c,14 :: 		EECON2 = 0xAA;      //procedimento obrigatório p/ escrita
	MOVLW       170
	MOVWF       EECON2+0 
;lib_eeprom.c,15 :: 		EECON1.WR = 1;      //Realiza a gravação da EEPROM
	BSF         EECON1+0, 1 
;lib_eeprom.c,16 :: 		while(EECON1.WR == 1); //Aguarda o término da gravação
L_EEPROM_Write_byte0:
	BTFSS       EECON1+0, 1 
	GOTO        L_EEPROM_Write_byte1
	GOTO        L_EEPROM_Write_byte0
L_EEPROM_Write_byte1:
;lib_eeprom.c,17 :: 		INTCON.GIEH = STATUS_GIE;
	BTFSC       EEPROM_Write_byte_STATUS_GIE_L0+0, 0 
	GOTO        L__EEPROM_Write_byte9
	BCF         INTCON+0, 7 
	GOTO        L__EEPROM_Write_byte10
L__EEPROM_Write_byte9:
	BSF         INTCON+0, 7 
L__EEPROM_Write_byte10:
;lib_eeprom.c,18 :: 		EECON1.WREN = 0;    //Desabilita o modo de gravação
	BCF         EECON1+0, 2 
;lib_eeprom.c,20 :: 		}
L_end_EEPROM_Write_byte:
	RETURN      0
; end of _EEPROM_Write_byte

_EEPROM_Read_byte:

;lib_eeprom.c,22 :: 		unsigned char EEPROM_Read_byte(unsigned char address)
;lib_eeprom.c,24 :: 		EEADR        = address;   //Endereço da EEPROM a ser Lido
	MOVF        FARG_EEPROM_Read_byte_address+0, 0 
	MOVWF       EEADR+0 
;lib_eeprom.c,25 :: 		EECON1.CFGS  = 0;    //Acesso ao controle da memória EEPROM
	BCF         EECON1+0, 6 
;lib_eeprom.c,26 :: 		EECON1.EEPGD = 0;    //Aponta para a memória EEPROM
	BCF         EECON1+0, 7 
;lib_eeprom.c,27 :: 		EECON1.RD    = 1;    //Inicia a Leitura da EEPROM
	BSF         EECON1+0, 0 
;lib_eeprom.c,28 :: 		asm nop;             //Recomenda-se aguardar 2 ciclos
	NOP
;lib_eeprom.c,29 :: 		asm nop;             // de máquina antes de ler EEDATA
	NOP
;lib_eeprom.c,31 :: 		return EEDATA;       //O valor da leitura está em EEDATA
	MOVF        EEDATA+0, 0 
	MOVWF       R0 
;lib_eeprom.c,32 :: 		}
L_end_EEPROM_Read_byte:
	RETURN      0
; end of _EEPROM_Read_byte

_EEPROM_Write_int:

;lib_eeprom.c,34 :: 		void EEPROM_Write_int (unsigned char address, unsigned int dta)
;lib_eeprom.c,36 :: 		EEPROM_Write_byte(address + 0, (char)dta);
	MOVF        FARG_EEPROM_Write_int_address+0, 0 
	MOVWF       FARG_EEPROM_Write_byte_address+0 
	MOVF        FARG_EEPROM_Write_int_dta+0, 0 
	MOVWF       FARG_EEPROM_Write_byte_dta+0 
	CALL        _EEPROM_Write_byte+0, 0
;lib_eeprom.c,37 :: 		EEPROM_Write_byte(address + 1, (char)(dta>>8));
	MOVF        FARG_EEPROM_Write_int_address+0, 0 
	ADDLW       1
	MOVWF       FARG_EEPROM_Write_byte_address+0 
	MOVF        FARG_EEPROM_Write_int_dta+1, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVF        R0, 0 
	MOVWF       FARG_EEPROM_Write_byte_dta+0 
	CALL        _EEPROM_Write_byte+0, 0
;lib_eeprom.c,38 :: 		}
L_end_EEPROM_Write_int:
	RETURN      0
; end of _EEPROM_Write_int

_EEPROM_Read_int:

;lib_eeprom.c,40 :: 		unsigned int EEPROM_Read_int (unsigned int address)
;lib_eeprom.c,43 :: 		_val1 = EEPROM_Read_byte(address + 0);
	MOVF        FARG_EEPROM_Read_int_address+0, 0 
	MOVWF       FARG_EEPROM_Read_byte_address+0 
	CALL        _EEPROM_Read_byte+0, 0
	MOVF        R0, 0 
	MOVWF       EEPROM_Read_int__val1_L0+0 
;lib_eeprom.c,44 :: 		_val2 = EEPROM_Read_byte(address + 1);
	MOVF        FARG_EEPROM_Read_int_address+0, 0 
	ADDLW       1
	MOVWF       FARG_EEPROM_Read_byte_address+0 
	CALL        _EEPROM_Read_byte+0, 0
;lib_eeprom.c,45 :: 		return ((_val1 << 8)| (int)_val2); //concatenando os bytes para formar 1 inteiro
	MOVF        EEPROM_Read_int__val1_L0+0, 0 
	MOVWF       R3 
	CLRF        R2 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
	IORWF       R0, 1 
	MOVF        R3, 0 
	IORWF       R1, 1 
;lib_eeprom.c,47 :: 		}
L_end_EEPROM_Read_int:
	RETURN      0
; end of _EEPROM_Read_int

_EEPROM_Write_array:

;lib_eeprom.c,50 :: 		void EEPROM_Write_array (unsigned char address,        unsigned char qtd_byte,unsigned char *dta)
;lib_eeprom.c,53 :: 		for(_i = 0; _i < qtd_byte; ++_i)
	CLRF        EEPROM_Write_array__i_L0+0 
L_EEPROM_Write_array2:
	MOVF        FARG_EEPROM_Write_array_qtd_byte+0, 0 
	SUBWF       EEPROM_Write_array__i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_EEPROM_Write_array3
;lib_eeprom.c,55 :: 		EEPROM_Write_byte(address+_i, *dta);
	MOVF        EEPROM_Write_array__i_L0+0, 0 
	ADDWF       FARG_EEPROM_Write_array_address+0, 0 
	MOVWF       FARG_EEPROM_Write_byte_address+0 
	MOVFF       FARG_EEPROM_Write_array_dta+0, FSR0L+0
	MOVFF       FARG_EEPROM_Write_array_dta+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_byte_dta+0 
	CALL        _EEPROM_Write_byte+0, 0
;lib_eeprom.c,56 :: 		++dta;
	INFSNZ      FARG_EEPROM_Write_array_dta+0, 1 
	INCF        FARG_EEPROM_Write_array_dta+1, 1 
;lib_eeprom.c,53 :: 		for(_i = 0; _i < qtd_byte; ++_i)
	INCF        EEPROM_Write_array__i_L0+0, 1 
;lib_eeprom.c,57 :: 		}
	GOTO        L_EEPROM_Write_array2
L_EEPROM_Write_array3:
;lib_eeprom.c,59 :: 		}
L_end_EEPROM_Write_array:
	RETURN      0
; end of _EEPROM_Write_array

_EEPROM_Read_array:

;lib_eeprom.c,62 :: 		void EEPROM_Read_array  (unsigned char address, unsigned char qtd_byte,unsigned char *buffer)
;lib_eeprom.c,65 :: 		for(_i = 0; _i < qtd_byte; ++_i)
	CLRF        EEPROM_Read_array__i_L0+0 
L_EEPROM_Read_array5:
	MOVF        FARG_EEPROM_Read_array_qtd_byte+0, 0 
	SUBWF       EEPROM_Read_array__i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_EEPROM_Read_array6
;lib_eeprom.c,67 :: 		*buffer = EEPROM_Read_byte(address+_i);
	MOVF        EEPROM_Read_array__i_L0+0, 0 
	ADDWF       FARG_EEPROM_Read_array_address+0, 0 
	MOVWF       FARG_EEPROM_Read_byte_address+0 
	CALL        _EEPROM_Read_byte+0, 0
	MOVFF       FARG_EEPROM_Read_array_buffer+0, FSR1L+0
	MOVFF       FARG_EEPROM_Read_array_buffer+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;lib_eeprom.c,68 :: 		++buffer;
	INFSNZ      FARG_EEPROM_Read_array_buffer+0, 1 
	INCF        FARG_EEPROM_Read_array_buffer+1, 1 
;lib_eeprom.c,65 :: 		for(_i = 0; _i < qtd_byte; ++_i)
	INCF        EEPROM_Read_array__i_L0+0, 1 
;lib_eeprom.c,69 :: 		}
	GOTO        L_EEPROM_Read_array5
L_EEPROM_Read_array6:
;lib_eeprom.c,70 :: 		}
L_end_EEPROM_Read_array:
	RETURN      0
; end of _EEPROM_Read_array

_EEPROM_Write_float:

;lib_eeprom.c,73 :: 		void EEPROM_Write_float(unsigned char address,unsigned char *dta)
;lib_eeprom.c,75 :: 		EEPROM_Write_array(address, 4, &dta);
	MOVF        FARG_EEPROM_Write_float_address+0, 0 
	MOVWF       FARG_EEPROM_Write_array_address+0 
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_array_qtd_byte+0 
	MOVLW       FARG_EEPROM_Write_float_dta+0
	MOVWF       FARG_EEPROM_Write_array_dta+0 
	MOVLW       hi_addr(FARG_EEPROM_Write_float_dta+0)
	MOVWF       FARG_EEPROM_Write_array_dta+1 
	CALL        _EEPROM_Write_array+0, 0
;lib_eeprom.c,76 :: 		}
L_end_EEPROM_Write_float:
	RETURN      0
; end of _EEPROM_Write_float

_EEPROM_Read_float:

;lib_eeprom.c,78 :: 		float EEPROM_Read_float(unsigned char address)
;lib_eeprom.c,85 :: 		result._res[0] = EEPROM_Read_byte(address+0);
	MOVF        FARG_EEPROM_Read_float_address+0, 0 
	MOVWF       FARG_EEPROM_Read_byte_address+0 
	CALL        _EEPROM_Read_byte+0, 0
	MOVF        R0, 0 
	MOVWF       EEPROM_Read_float_result_L0+0 
;lib_eeprom.c,86 :: 		result._res[1] = EEPROM_Read_byte(address+1);
	MOVF        FARG_EEPROM_Read_float_address+0, 0 
	ADDLW       1
	MOVWF       FARG_EEPROM_Read_byte_address+0 
	CALL        _EEPROM_Read_byte+0, 0
	MOVF        R0, 0 
	MOVWF       EEPROM_Read_float_result_L0+1 
;lib_eeprom.c,87 :: 		result._res[2] = EEPROM_Read_byte(address+2);
	MOVLW       2
	ADDWF       FARG_EEPROM_Read_float_address+0, 0 
	MOVWF       FARG_EEPROM_Read_byte_address+0 
	CALL        _EEPROM_Read_byte+0, 0
	MOVF        R0, 0 
	MOVWF       EEPROM_Read_float_result_L0+2 
;lib_eeprom.c,88 :: 		result._res[3] = EEPROM_Read_byte(address+3);
	MOVLW       3
	ADDWF       FARG_EEPROM_Read_float_address+0, 0 
	MOVWF       FARG_EEPROM_Read_byte_address+0 
	CALL        _EEPROM_Read_byte+0, 0
	MOVF        R0, 0 
	MOVWF       EEPROM_Read_float_result_L0+3 
;lib_eeprom.c,89 :: 		return result._t;
	MOVF        EEPROM_Read_float_result_L0+0, 0 
	MOVWF       R0 
	MOVF        EEPROM_Read_float_result_L0+1, 0 
	MOVWF       R1 
	MOVF        EEPROM_Read_float_result_L0+2, 0 
	MOVWF       R2 
	MOVF        EEPROM_Read_float_result_L0+3, 0 
	MOVWF       R3 
;lib_eeprom.c,90 :: 		}
L_end_EEPROM_Read_float:
	RETURN      0
; end of _EEPROM_Read_float
