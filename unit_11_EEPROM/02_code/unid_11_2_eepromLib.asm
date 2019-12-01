
_EEPROM_Write_byte:

;unid_11_2_eepromLib.c,1 :: 		void EEPROM_Write_byte(unsigned char address, unsigned char dta)
;unid_11_2_eepromLib.c,3 :: 		char  STATUS_GIE  = 0;
	CLRF        EEPROM_Write_byte_STATUS_GIE_L0+0 
;unid_11_2_eepromLib.c,4 :: 		EEADR        = address; //Endereço a ser gravado
	MOVF        FARG_EEPROM_Write_byte_address+0, 0 
	MOVWF       EEADR+0 
;unid_11_2_eepromLib.c,5 :: 		EEDATA       = dta;     //Byte a ser gravado
	MOVF        FARG_EEPROM_Write_byte_dta+0, 0 
	MOVWF       EEDATA+0 
;unid_11_2_eepromLib.c,6 :: 		EECON1.EEPGD = 0;   //Aponta para a memória EEPROM
	BCF         EECON1+0, 7 
;unid_11_2_eepromLib.c,7 :: 		EECON1.CFGS  = 0;   //Acesso ao controle da EEPROM
	BCF         EECON1+0, 6 
;unid_11_2_eepromLib.c,8 :: 		EECON1.WREN  = 1;   //Habilita modo de gravação da EEPROM
	BSF         EECON1+0, 2 
;unid_11_2_eepromLib.c,9 :: 		STATUS_GIE = INTCON.GIEH;
	MOVLW       0
	BTFSC       INTCON+0, 7 
	MOVLW       1
	MOVWF       EEPROM_Write_byte_STATUS_GIE_L0+0 
;unid_11_2_eepromLib.c,10 :: 		INTCON.GIEH = 0;
	BCF         INTCON+0, 7 
;unid_11_2_eepromLib.c,11 :: 		EECON2 = 0x55;      //procedimento obrigatório p/ escrita
	MOVLW       85
	MOVWF       EECON2+0 
;unid_11_2_eepromLib.c,12 :: 		EECON2 = 0xAA;      //procedimento obrigatório p/ escrita
	MOVLW       170
	MOVWF       EECON2+0 
;unid_11_2_eepromLib.c,13 :: 		EECON1.WR = 1;      //Realiza a gravação da EEPROM
	BSF         EECON1+0, 1 
;unid_11_2_eepromLib.c,14 :: 		while(EECON1.WR == 1); //Aguarda o término da gravação
L_EEPROM_Write_byte0:
	BTFSS       EECON1+0, 1 
	GOTO        L_EEPROM_Write_byte1
	GOTO        L_EEPROM_Write_byte0
L_EEPROM_Write_byte1:
;unid_11_2_eepromLib.c,15 :: 		INTCON.GIEH = STATUS_GIE;
	BTFSC       EEPROM_Write_byte_STATUS_GIE_L0+0, 0 
	GOTO        L__EEPROM_Write_byte6
	BCF         INTCON+0, 7 
	GOTO        L__EEPROM_Write_byte7
L__EEPROM_Write_byte6:
	BSF         INTCON+0, 7 
L__EEPROM_Write_byte7:
;unid_11_2_eepromLib.c,16 :: 		EECON1.WREN = 0;    //Desabilita o modo de gravação
	BCF         EECON1+0, 2 
;unid_11_2_eepromLib.c,18 :: 		}
L_end_EEPROM_Write_byte:
	RETURN      0
; end of _EEPROM_Write_byte

_EEPROM_Read_byte:

;unid_11_2_eepromLib.c,20 :: 		unsigned char EEPROM_Read_byte(unsigned char address)
;unid_11_2_eepromLib.c,22 :: 		EEADR        = address;   //Endereço da EEPROM a ser Lido
	MOVF        FARG_EEPROM_Read_byte_address+0, 0 
	MOVWF       EEADR+0 
;unid_11_2_eepromLib.c,23 :: 		EECON1.CFGS  = 0;    //Acesso ao controle da memória EEPROM
	BCF         EECON1+0, 6 
;unid_11_2_eepromLib.c,24 :: 		EECON1.EEPGD = 0;    //Aponta para a memória EEPROM
	BCF         EECON1+0, 7 
;unid_11_2_eepromLib.c,25 :: 		EECON1.RD    = 1;    //Inicia a Leitura da EEPROM
	BSF         EECON1+0, 0 
;unid_11_2_eepromLib.c,26 :: 		asm nop;             //Recomenda-se aguardar 2 ciclos
	NOP
;unid_11_2_eepromLib.c,27 :: 		asm nop;             // de máquina antes de ler EEDATA
	NOP
;unid_11_2_eepromLib.c,29 :: 		return EEDATA;       //O valor da leitura está em EEDATA
	MOVF        EEDATA+0, 0 
	MOVWF       R0 
;unid_11_2_eepromLib.c,30 :: 		}
L_end_EEPROM_Read_byte:
	RETURN      0
; end of _EEPROM_Read_byte

_main:

;unid_11_2_eepromLib.c,32 :: 		void main() {
;unid_11_2_eepromLib.c,37 :: 		TRISD = 0;
	CLRF        TRISD+0 
;unid_11_2_eepromLib.c,38 :: 		PORTD = 0;
	CLRF        PORTD+0 
;unid_11_2_eepromLib.c,39 :: 		EEPROM_Write_byte(0,0B1010101);
	CLRF        FARG_EEPROM_Write_byte_address+0 
	MOVLW       85
	MOVWF       FARG_EEPROM_Write_byte_dta+0 
	CALL        _EEPROM_Write_byte+0, 0
;unid_11_2_eepromLib.c,40 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	NOP
	NOP
;unid_11_2_eepromLib.c,41 :: 		PORTD = EEPROM_Read_byte(0);
	CLRF        FARG_EEPROM_Read_byte_address+0 
	CALL        _EEPROM_Read_byte+0, 0
	MOVF        R0, 0 
	MOVWF       PORTD+0 
;unid_11_2_eepromLib.c,42 :: 		while(1);
L_main3:
	GOTO        L_main3
;unid_11_2_eepromLib.c,44 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
