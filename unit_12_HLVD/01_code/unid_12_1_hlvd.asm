
_INTERRUPTION_HIGH:

;unid_12_1_hlvd.c,38 :: 		void INTERRUPTION_HIGH() iv 0x0008 ics ICS_AUTO {
;unid_12_1_hlvd.c,47 :: 		if(HLVDIF_bit == 1)
	BTFSS       HLVDIF_bit+0, BitPos(HLVDIF_bit+0) 
	GOTO        L_INTERRUPTION_HIGH0
;unid_12_1_hlvd.c,49 :: 		EEPROM_Write(0, Count);
	CLRF        FARG_EEPROM_Write_address+0 
	MOVF        _Count+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;unid_12_1_hlvd.c,50 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_INTERRUPTION_HIGH1:
	DECFSZ      R13, 1, 1
	BRA         L_INTERRUPTION_HIGH1
	DECFSZ      R12, 1, 1
	BRA         L_INTERRUPTION_HIGH1
	DECFSZ      R11, 1, 1
	BRA         L_INTERRUPTION_HIGH1
	NOP
	NOP
;unid_12_1_hlvd.c,51 :: 		HLVDIF_bit = 0;
	BCF         HLVDIF_bit+0, BitPos(HLVDIF_bit+0) 
;unid_12_1_hlvd.c,52 :: 		}
	GOTO        L_INTERRUPTION_HIGH2
L_INTERRUPTION_HIGH0:
;unid_12_1_hlvd.c,63 :: 		if(INTCON.TMR0IF == 1)
	BTFSS       INTCON+0, 2 
	GOTO        L_INTERRUPTION_HIGH3
;unid_12_1_hlvd.c,65 :: 		PORTA &= 0B11000011;  //picGenios: Apaga RA2/RA3/RA4/RA5 display pins
	MOVLW       195
	ANDWF       PORTA+0, 1 
;unid_12_1_hlvd.c,66 :: 		switch(state_machine)
	GOTO        L_INTERRUPTION_HIGH4
;unid_12_1_hlvd.c,68 :: 		case d1: {
L_INTERRUPTION_HIGH6:
;unid_12_1_hlvd.c,69 :: 		PORTD = Dta[0];
	MOVF        _Dta+0, 0 
	MOVWF       PORTD+0 
;unid_12_1_hlvd.c,70 :: 		PORTA.RA5 = 1;
	BSF         PORTA+0, 5 
;unid_12_1_hlvd.c,71 :: 		state_machine = d2;
	MOVLW       2
	MOVWF       INTERRUPTION_HIGH_state_machine_L0+0 
;unid_12_1_hlvd.c,72 :: 		break;
	GOTO        L_INTERRUPTION_HIGH5
;unid_12_1_hlvd.c,74 :: 		case d2: {
L_INTERRUPTION_HIGH7:
;unid_12_1_hlvd.c,75 :: 		PORTD = Dta[1];
	MOVF        _Dta+1, 0 
	MOVWF       PORTD+0 
;unid_12_1_hlvd.c,76 :: 		PORTA.RA4 = 1;
	BSF         PORTA+0, 4 
;unid_12_1_hlvd.c,77 :: 		state_machine = d3;
	MOVLW       3
	MOVWF       INTERRUPTION_HIGH_state_machine_L0+0 
;unid_12_1_hlvd.c,78 :: 		break;
	GOTO        L_INTERRUPTION_HIGH5
;unid_12_1_hlvd.c,80 :: 		case d3: {
L_INTERRUPTION_HIGH8:
;unid_12_1_hlvd.c,81 :: 		PORTD = Dta[2];
	MOVF        _Dta+2, 0 
	MOVWF       PORTD+0 
;unid_12_1_hlvd.c,82 :: 		PORTA.RA3 = 1;
	BSF         PORTA+0, 3 
;unid_12_1_hlvd.c,83 :: 		state_machine = d4;
	MOVLW       4
	MOVWF       INTERRUPTION_HIGH_state_machine_L0+0 
;unid_12_1_hlvd.c,84 :: 		break;
	GOTO        L_INTERRUPTION_HIGH5
;unid_12_1_hlvd.c,86 :: 		case d4: {
L_INTERRUPTION_HIGH9:
;unid_12_1_hlvd.c,87 :: 		PORTD = Dta[3];
	MOVF        _Dta+3, 0 
	MOVWF       PORTD+0 
;unid_12_1_hlvd.c,88 :: 		PORTA.RA2 = 1;
	BSF         PORTA+0, 2 
;unid_12_1_hlvd.c,89 :: 		state_machine = d1;
	MOVLW       1
	MOVWF       INTERRUPTION_HIGH_state_machine_L0+0 
;unid_12_1_hlvd.c,90 :: 		break;
	GOTO        L_INTERRUPTION_HIGH5
;unid_12_1_hlvd.c,92 :: 		}
L_INTERRUPTION_HIGH4:
	MOVF        INTERRUPTION_HIGH_state_machine_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_INTERRUPTION_HIGH6
	MOVF        INTERRUPTION_HIGH_state_machine_L0+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_INTERRUPTION_HIGH7
	MOVF        INTERRUPTION_HIGH_state_machine_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_INTERRUPTION_HIGH8
	MOVF        INTERRUPTION_HIGH_state_machine_L0+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_INTERRUPTION_HIGH9
L_INTERRUPTION_HIGH5:
;unid_12_1_hlvd.c,93 :: 		}
L_INTERRUPTION_HIGH3:
L_INTERRUPTION_HIGH2:
;unid_12_1_hlvd.c,96 :: 		TMR0H = 0XFE;
	MOVLW       254
	MOVWF       TMR0H+0 
;unid_12_1_hlvd.c,97 :: 		TMR0L = 0X06;
	MOVLW       6
	MOVWF       TMR0L+0 
;unid_12_1_hlvd.c,98 :: 		INTCON.TMR0IF = 0;              // Clear flag & reset interruption cycle
	BCF         INTCON+0, 2 
;unid_12_1_hlvd.c,100 :: 		}
L_end_INTERRUPTION_HIGH:
L__INTERRUPTION_HIGH25:
	RETFIE      1
; end of _INTERRUPTION_HIGH

_configMCU:

;unid_12_1_hlvd.c,102 :: 		void configMCU()                   // Timer0 Port & Directions
;unid_12_1_hlvd.c,109 :: 		ADCON1 |= 0X0F;                    // Analog pinouts
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unid_12_1_hlvd.c,112 :: 		TRISA = 0;
	CLRF        TRISA+0 
;unid_12_1_hlvd.c,113 :: 		PORTA = 0;                         // LEDs' control pins
	CLRF        PORTA+0 
;unid_12_1_hlvd.c,114 :: 		TRISD = 0;
	CLRF        TRISD+0 
;unid_12_1_hlvd.c,115 :: 		PORTD = 0;                         // LEDs' control pins
	CLRF        PORTD+0 
;unid_12_1_hlvd.c,119 :: 		TRISB.RB0 = 1;   //COUNT = UP
	BSF         TRISB+0, 0 
;unid_12_1_hlvd.c,120 :: 		PORTB.RB0 = 1;
	BSF         PORTB+0, 0 
;unid_12_1_hlvd.c,122 :: 		TRISB.RB1 = 1;  //COUNT = DOWN
	BSF         TRISB+0, 1 
;unid_12_1_hlvd.c,123 :: 		PORTB.RB1 = 1;
	BSF         PORTB+0, 1 
;unid_12_1_hlvd.c,124 :: 		}
L_end_configMCU:
	RETURN      0
; end of _configMCU

_configTimer0:

;unid_12_1_hlvd.c,126 :: 		void configTimer0()
;unid_12_1_hlvd.c,132 :: 		T0CON = 0B00000010;
	MOVLW       2
	MOVWF       T0CON+0 
;unid_12_1_hlvd.c,134 :: 		TMR0L = 0XFE;
	MOVLW       254
	MOVWF       TMR0L+0 
;unid_12_1_hlvd.c,135 :: 		TMR0H = 0X0C;                       // Recharge initial counter &
	MOVLW       12
	MOVWF       TMR0H+0 
;unid_12_1_hlvd.c,136 :: 		INTCON.TMR0IF = 0;                  // clean overflow Timer0's flag
	BCF         INTCON+0, 2 
;unid_12_1_hlvd.c,138 :: 		T0CON.TMR0ON = 1;                   // Timer0 on
	BSF         T0CON+0, 7 
;unid_12_1_hlvd.c,139 :: 		}
L_end_configTimer0:
	RETURN      0
; end of _configTimer0

_configGlobalInterruption:

;unid_12_1_hlvd.c,141 :: 		void configGlobalInterruption()     // Interruptions's master keys
;unid_12_1_hlvd.c,143 :: 		INTCON.GIEH = 1;                  // High priority enabled
	BSF         INTCON+0, 7 
;unid_12_1_hlvd.c,144 :: 		INTCON.GIEL = 1;                  // Low prioritY enabled
	BSF         INTCON+0, 6 
;unid_12_1_hlvd.c,145 :: 		RCON.IPEN =   1;                  // Compatibility family 16F (just one level)
	BSF         RCON+0, 7 
;unid_12_1_hlvd.c,148 :: 		}
L_end_configGlobalInterruption:
	RETURN      0
; end of _configGlobalInterruption

_configIndividualVctTMR0:

;unid_12_1_hlvd.c,149 :: 		void configIndividualVctTMR0()
;unid_12_1_hlvd.c,152 :: 		INTCON.TMR0IF  = 0;               // Overflow flag; please init zero
	BCF         INTCON+0, 2 
;unid_12_1_hlvd.c,153 :: 		INTCON2.TMR0IP = 1;               // Interruption priority vector: HIGH
	BSF         INTCON2+0, 2 
;unid_12_1_hlvd.c,154 :: 		INTCON.TMR0IE  = 1;               // TIMER0's interruption enabled
	BSF         INTCON+0, 5 
;unid_12_1_hlvd.c,155 :: 		}
L_end_configIndividualVctTMR0:
	RETURN      0
; end of _configIndividualVctTMR0

_configIndividualPrfHLVD:

;unid_12_1_hlvd.c,157 :: 		void configIndividualPrfHLVD()       // ???'s Interruptions Peripheral configurations (IF,IP & IE)
;unid_12_1_hlvd.c,159 :: 		HLVDIF_bit  = 0;          // Overflow flag; please init zero
	BCF         HLVDIF_bit+0, BitPos(HLVDIF_bit+0) 
;unid_12_1_hlvd.c,160 :: 		HLVDIP_bit = 1;           // Interruption priority vector: HIGH
	BSF         HLVDIP_bit+0, BitPos(HLVDIP_bit+0) 
;unid_12_1_hlvd.c,161 :: 		HLVDIE_bit  = 1;          // ???'s interruption enabled
	BSF         HLVDIE_bit+0, BitPos(HLVDIE_bit+0) 
;unid_12_1_hlvd.c,162 :: 		}
L_end_configIndividualPrfHLVD:
	RETURN      0
; end of _configIndividualPrfHLVD

_configcrHLVD:

;unid_12_1_hlvd.c,164 :: 		void configcrHLVD()                    // Specific CONTROL REGISTER(s) configuration(s) for ??? peripheral
;unid_12_1_hlvd.c,166 :: 		HLVDCON =  0B00011110;            //  SFR
	MOVLW       30
	MOVWF       HLVDCON+0 
;unid_12_1_hlvd.c,167 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_configcrHLVD10:
	DECFSZ      R13, 1, 1
	BRA         L_configcrHLVD10
	DECFSZ      R12, 1, 1
	BRA         L_configcrHLVD10
	DECFSZ      R11, 1, 1
	BRA         L_configcrHLVD10
	NOP
	NOP
;unid_12_1_hlvd.c,168 :: 		}
L_end_configcrHLVD:
	RETURN      0
; end of _configcrHLVD

_main:

;unid_12_1_hlvd.c,170 :: 		void main()
;unid_12_1_hlvd.c,174 :: 		configMCU();
	CALL        _configMCU+0, 0
;unid_12_1_hlvd.c,175 :: 		configTimer0();
	CALL        _configTimer0+0, 0
;unid_12_1_hlvd.c,176 :: 		configGlobalInterruption();
	CALL        _configGlobalInterruption+0, 0
;unid_12_1_hlvd.c,177 :: 		configIndividualVctTMR0();
	CALL        _configIndividualVctTMR0+0, 0
;unid_12_1_hlvd.c,178 :: 		configIndividualPrfHLVD();
	CALL        _configIndividualPrfHLVD+0, 0
;unid_12_1_hlvd.c,179 :: 		configcrHLVD();
	CALL        _configcrHLVD+0, 0
;unid_12_1_hlvd.c,181 :: 		Count = EEPROM_Read(0);     // não estou conseguindo mostrar no display de 7 seg
	CLRF        FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Count+0 
	MOVLW       0
	MOVWF       _Count+1 
;unid_12_1_hlvd.c,194 :: 		while(TRUE)
L_main11:
;unid_12_1_hlvd.c,196 :: 		if(PORTB.RB0 == 0 && Count < 9999)    //UP
	BTFSC       PORTB+0, 0 
	GOTO        L_main15
	MOVLW       39
	SUBWF       _Count+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main33
	MOVLW       15
	SUBWF       _Count+0, 0 
L__main33:
	BTFSC       STATUS+0, 0 
	GOTO        L_main15
L__main23:
;unid_12_1_hlvd.c,198 :: 		Count++;
	MOVLW       1
	ADDWF       _Count+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _Count+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _Count+0 
	MOVF        R1, 0 
	MOVWF       _Count+1 
;unid_12_1_hlvd.c,199 :: 		Delay_ms(300);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main16:
	DECFSZ      R13, 1, 1
	BRA         L_main16
	DECFSZ      R12, 1, 1
	BRA         L_main16
	DECFSZ      R11, 1, 1
	BRA         L_main16
	NOP
	NOP
;unid_12_1_hlvd.c,200 :: 		}
L_main15:
;unid_12_1_hlvd.c,202 :: 		if(PORTB.RB1 == 0 && Count > 0)
	BTFSC       PORTB+0, 1 
	GOTO        L_main19
	MOVLW       0
	MOVWF       R0 
	MOVF        _Count+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main34
	MOVF        _Count+0, 0 
	SUBLW       0
L__main34:
	BTFSC       STATUS+0, 0 
	GOTO        L_main19
L__main22:
;unid_12_1_hlvd.c,204 :: 		Count--;
	MOVLW       1
	SUBWF       _Count+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      _Count+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _Count+0 
	MOVF        R1, 0 
	MOVWF       _Count+1 
;unid_12_1_hlvd.c,205 :: 		Delay_ms(300);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main20:
	DECFSZ      R13, 1, 1
	BRA         L_main20
	DECFSZ      R12, 1, 1
	BRA         L_main20
	DECFSZ      R11, 1, 1
	BRA         L_main20
	NOP
	NOP
;unid_12_1_hlvd.c,206 :: 		}
L_main19:
;unid_12_1_hlvd.c,209 :: 		varAux = Count;
	MOVF        _Count+0, 0 
	MOVWF       main_varAux_L0+0 
	MOVF        _Count+1, 0 
	MOVWF       main_varAux_L0+1 
;unid_12_1_hlvd.c,211 :: 		Dta[0] = DMatriz[varAux%10];
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_varAux_L0+0, 0 
	MOVWF       R0 
	MOVF        main_varAux_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       _DMatriz+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_DMatriz+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Dta+0 
;unid_12_1_hlvd.c,212 :: 		varAux /= 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_varAux_L0+0, 0 
	MOVWF       R0 
	MOVF        main_varAux_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	MOVF        FLOC__main+0, 0 
	MOVWF       main_varAux_L0+0 
	MOVF        FLOC__main+1, 0 
	MOVWF       main_varAux_L0+1 
;unid_12_1_hlvd.c,213 :: 		Dta[1] = DMatriz[varAux%10];
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       _DMatriz+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_DMatriz+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Dta+1 
;unid_12_1_hlvd.c,214 :: 		varAux /= 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	MOVF        FLOC__main+0, 0 
	MOVWF       main_varAux_L0+0 
	MOVF        FLOC__main+1, 0 
	MOVWF       main_varAux_L0+1 
;unid_12_1_hlvd.c,215 :: 		Dta[2] = DMatriz[varAux%10];
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       _DMatriz+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_DMatriz+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Dta+2 
;unid_12_1_hlvd.c,216 :: 		varAux /= 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	MOVF        FLOC__main+0, 0 
	MOVWF       main_varAux_L0+0 
	MOVF        FLOC__main+1, 0 
	MOVWF       main_varAux_L0+1 
;unid_12_1_hlvd.c,217 :: 		Dta[3] = DMatriz[varAux%10];
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       _DMatriz+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_DMatriz+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Dta+3 
;unid_12_1_hlvd.c,218 :: 		varAux /= 10;   Delay_ms(10);
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       main_varAux_L0+0 
	MOVF        R1, 0 
	MOVWF       main_varAux_L0+1 
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_main21:
	DECFSZ      R13, 1, 1
	BRA         L_main21
	DECFSZ      R12, 1, 1
	BRA         L_main21
	NOP
;unid_12_1_hlvd.c,219 :: 		}
	GOTO        L_main11
;unid_12_1_hlvd.c,220 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
