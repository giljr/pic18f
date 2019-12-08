
_INTERRUPTION_HIGH:

;unid_10_2_upDownCounter7segs.c,36 :: 		void INTERRUPTION_HIGH() iv 0x0008 ics ICS_AUTO {
;unid_10_2_upDownCounter7segs.c,53 :: 		if(INTCON.TMR0IF == 1)
	BTFSS       INTCON+0, 2 
	GOTO        L_INTERRUPTION_HIGH0
;unid_10_2_upDownCounter7segs.c,55 :: 		PORTA &= 0B11000011;  //picGenios: Apaga RA2/RA3/RA4/RA5 display pins
	MOVLW       195
	ANDWF       PORTA+0, 1 
;unid_10_2_upDownCounter7segs.c,56 :: 		switch(state_machine)
	GOTO        L_INTERRUPTION_HIGH1
;unid_10_2_upDownCounter7segs.c,58 :: 		case d1: {
L_INTERRUPTION_HIGH3:
;unid_10_2_upDownCounter7segs.c,59 :: 		PORTD = Dta[0];
	MOVF        _Dta+0, 0 
	MOVWF       PORTD+0 
;unid_10_2_upDownCounter7segs.c,60 :: 		PORTA.RA5 = 1;
	BSF         PORTA+0, 5 
;unid_10_2_upDownCounter7segs.c,61 :: 		state_machine = d2;
	MOVLW       2
	MOVWF       INTERRUPTION_HIGH_state_machine_L0+0 
;unid_10_2_upDownCounter7segs.c,62 :: 		break;
	GOTO        L_INTERRUPTION_HIGH2
;unid_10_2_upDownCounter7segs.c,64 :: 		case d2: {
L_INTERRUPTION_HIGH4:
;unid_10_2_upDownCounter7segs.c,65 :: 		PORTD = Dta[1];
	MOVF        _Dta+1, 0 
	MOVWF       PORTD+0 
;unid_10_2_upDownCounter7segs.c,66 :: 		PORTA.RA4 = 1;
	BSF         PORTA+0, 4 
;unid_10_2_upDownCounter7segs.c,67 :: 		state_machine = d3;
	MOVLW       3
	MOVWF       INTERRUPTION_HIGH_state_machine_L0+0 
;unid_10_2_upDownCounter7segs.c,68 :: 		break;
	GOTO        L_INTERRUPTION_HIGH2
;unid_10_2_upDownCounter7segs.c,70 :: 		case d3: {
L_INTERRUPTION_HIGH5:
;unid_10_2_upDownCounter7segs.c,71 :: 		PORTD = Dta[2];
	MOVF        _Dta+2, 0 
	MOVWF       PORTD+0 
;unid_10_2_upDownCounter7segs.c,72 :: 		PORTA.RA3 = 1;
	BSF         PORTA+0, 3 
;unid_10_2_upDownCounter7segs.c,73 :: 		state_machine = d4;
	MOVLW       4
	MOVWF       INTERRUPTION_HIGH_state_machine_L0+0 
;unid_10_2_upDownCounter7segs.c,74 :: 		break;
	GOTO        L_INTERRUPTION_HIGH2
;unid_10_2_upDownCounter7segs.c,76 :: 		case d4: {
L_INTERRUPTION_HIGH6:
;unid_10_2_upDownCounter7segs.c,77 :: 		PORTD = Dta[3];
	MOVF        _Dta+3, 0 
	MOVWF       PORTD+0 
;unid_10_2_upDownCounter7segs.c,78 :: 		PORTA.RA2 = 1;
	BSF         PORTA+0, 2 
;unid_10_2_upDownCounter7segs.c,79 :: 		state_machine = d1;
	MOVLW       1
	MOVWF       INTERRUPTION_HIGH_state_machine_L0+0 
;unid_10_2_upDownCounter7segs.c,80 :: 		break;
	GOTO        L_INTERRUPTION_HIGH2
;unid_10_2_upDownCounter7segs.c,82 :: 		}
L_INTERRUPTION_HIGH1:
	MOVF        INTERRUPTION_HIGH_state_machine_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_INTERRUPTION_HIGH3
	MOVF        INTERRUPTION_HIGH_state_machine_L0+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_INTERRUPTION_HIGH4
	MOVF        INTERRUPTION_HIGH_state_machine_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_INTERRUPTION_HIGH5
	MOVF        INTERRUPTION_HIGH_state_machine_L0+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_INTERRUPTION_HIGH6
L_INTERRUPTION_HIGH2:
;unid_10_2_upDownCounter7segs.c,83 :: 		}
L_INTERRUPTION_HIGH0:
;unid_10_2_upDownCounter7segs.c,86 :: 		TMR0H = 0XFE;
	MOVLW       254
	MOVWF       TMR0H+0 
;unid_10_2_upDownCounter7segs.c,87 :: 		TMR0L = 0X06;
	MOVLW       6
	MOVWF       TMR0L+0 
;unid_10_2_upDownCounter7segs.c,88 :: 		INTCON.TMR0IF = 0;              // Clear flag & reset interruption cycle
	BCF         INTCON+0, 2 
;unid_10_2_upDownCounter7segs.c,90 :: 		}
L_end_INTERRUPTION_HIGH:
L__INTERRUPTION_HIGH21:
	RETFIE      1
; end of _INTERRUPTION_HIGH

_configMCU:

;unid_10_2_upDownCounter7segs.c,92 :: 		void configMCU()                   // Timer0 Port & Directions
;unid_10_2_upDownCounter7segs.c,99 :: 		ADCON1 |= 0X0F;                    // Analog pinouts
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unid_10_2_upDownCounter7segs.c,102 :: 		TRISA = 0;
	CLRF        TRISA+0 
;unid_10_2_upDownCounter7segs.c,103 :: 		PORTA = 0;                         // LEDs' control pins
	CLRF        PORTA+0 
;unid_10_2_upDownCounter7segs.c,104 :: 		TRISD = 0;
	CLRF        TRISD+0 
;unid_10_2_upDownCounter7segs.c,105 :: 		PORTD = 0;                         // LEDs' control pins
	CLRF        PORTD+0 
;unid_10_2_upDownCounter7segs.c,109 :: 		TRISB.RB0 = 1;   //COUNT = UP
	BSF         TRISB+0, 0 
;unid_10_2_upDownCounter7segs.c,110 :: 		PORTB.RB0 = 1;
	BSF         PORTB+0, 0 
;unid_10_2_upDownCounter7segs.c,112 :: 		TRISB.RB1 = 1;  //COUNT = DOWN
	BSF         TRISB+0, 1 
;unid_10_2_upDownCounter7segs.c,113 :: 		PORTB.RB1 = 1;
	BSF         PORTB+0, 1 
;unid_10_2_upDownCounter7segs.c,114 :: 		}
L_end_configMCU:
	RETURN      0
; end of _configMCU

_configTimer0:

;unid_10_2_upDownCounter7segs.c,116 :: 		void configTimer0()
;unid_10_2_upDownCounter7segs.c,122 :: 		T0CON = 0B00000010;
	MOVLW       2
	MOVWF       T0CON+0 
;unid_10_2_upDownCounter7segs.c,124 :: 		TMR0L = 0XFE;
	MOVLW       254
	MOVWF       TMR0L+0 
;unid_10_2_upDownCounter7segs.c,125 :: 		TMR0H = 0X0C;                       // Recharge initial counter &
	MOVLW       12
	MOVWF       TMR0H+0 
;unid_10_2_upDownCounter7segs.c,126 :: 		INTCON.TMR0IF = 0;                  // clean overflow Timer0's flag
	BCF         INTCON+0, 2 
;unid_10_2_upDownCounter7segs.c,128 :: 		T0CON.TMR0ON = 1;                   // Timer0 on
	BSF         T0CON+0, 7 
;unid_10_2_upDownCounter7segs.c,129 :: 		}
L_end_configTimer0:
	RETURN      0
; end of _configTimer0

_configGlobalInterruption:

;unid_10_2_upDownCounter7segs.c,131 :: 		void configGlobalInterruption()     // Interruptions's master keys
;unid_10_2_upDownCounter7segs.c,133 :: 		INTCON.GIEH = 1;                  // High priority enabled
	BSF         INTCON+0, 7 
;unid_10_2_upDownCounter7segs.c,134 :: 		INTCON.GIEL = 1;                  // Low prioritY enabled
	BSF         INTCON+0, 6 
;unid_10_2_upDownCounter7segs.c,135 :: 		RCON.IPEN =   1;                  // Compatibility family 16F (just one level)
	BSF         RCON+0, 7 
;unid_10_2_upDownCounter7segs.c,138 :: 		}
L_end_configGlobalInterruption:
	RETURN      0
; end of _configGlobalInterruption

_configIndividualVctTMR0:

;unid_10_2_upDownCounter7segs.c,139 :: 		void configIndividualVctTMR0()
;unid_10_2_upDownCounter7segs.c,142 :: 		INTCON.TMR0IF  = 0;               // Overflow flag; please init zero
	BCF         INTCON+0, 2 
;unid_10_2_upDownCounter7segs.c,143 :: 		INTCON2.TMR0IP = 1;               // Interruption priority vector: HIGH
	BSF         INTCON2+0, 2 
;unid_10_2_upDownCounter7segs.c,144 :: 		INTCON.TMR0IE  = 1;               // TIMER0's interruption enabled
	BSF         INTCON+0, 5 
;unid_10_2_upDownCounter7segs.c,145 :: 		}
L_end_configIndividualVctTMR0:
	RETURN      0
; end of _configIndividualVctTMR0

_main:

;unid_10_2_upDownCounter7segs.c,147 :: 		void main()
;unid_10_2_upDownCounter7segs.c,149 :: 		unsigned int Count = 0;
	CLRF        main_Count_L0+0 
	CLRF        main_Count_L0+1 
;unid_10_2_upDownCounter7segs.c,151 :: 		configMCU();
	CALL        _configMCU+0, 0
;unid_10_2_upDownCounter7segs.c,152 :: 		configTimer0();
	CALL        _configTimer0+0, 0
;unid_10_2_upDownCounter7segs.c,153 :: 		configGlobalInterruption();
	CALL        _configGlobalInterruption+0, 0
;unid_10_2_upDownCounter7segs.c,154 :: 		configIndividualVctTMR0();
	CALL        _configIndividualVctTMR0+0, 0
;unid_10_2_upDownCounter7segs.c,163 :: 		while(TRUE)
L_main7:
;unid_10_2_upDownCounter7segs.c,165 :: 		if(PORTB.RB0 == 0 && Count < 9999)    //UP
	BTFSC       PORTB+0, 0 
	GOTO        L_main11
	MOVLW       39
	SUBWF       main_Count_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main27
	MOVLW       15
	SUBWF       main_Count_L0+0, 0 
L__main27:
	BTFSC       STATUS+0, 0 
	GOTO        L_main11
L__main19:
;unid_10_2_upDownCounter7segs.c,167 :: 		Count++;
	INFSNZ      main_Count_L0+0, 1 
	INCF        main_Count_L0+1, 1 
;unid_10_2_upDownCounter7segs.c,168 :: 		Delay_ms(300);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main12:
	DECFSZ      R13, 1, 1
	BRA         L_main12
	DECFSZ      R12, 1, 1
	BRA         L_main12
	DECFSZ      R11, 1, 1
	BRA         L_main12
	NOP
	NOP
;unid_10_2_upDownCounter7segs.c,169 :: 		}
L_main11:
;unid_10_2_upDownCounter7segs.c,171 :: 		if(PORTB.RB1 == 0 && Count > 0)
	BTFSC       PORTB+0, 1 
	GOTO        L_main15
	MOVLW       0
	MOVWF       R0 
	MOVF        main_Count_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main28
	MOVF        main_Count_L0+0, 0 
	SUBLW       0
L__main28:
	BTFSC       STATUS+0, 0 
	GOTO        L_main15
L__main18:
;unid_10_2_upDownCounter7segs.c,173 :: 		Count--;
	MOVLW       1
	SUBWF       main_Count_L0+0, 1 
	MOVLW       0
	SUBWFB      main_Count_L0+1, 1 
;unid_10_2_upDownCounter7segs.c,174 :: 		Delay_ms(300);
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
;unid_10_2_upDownCounter7segs.c,175 :: 		}
L_main15:
;unid_10_2_upDownCounter7segs.c,180 :: 		Dta[0] = DMatriz[varAux%10];
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_Count_L0+0, 0 
	MOVWF       R0 
	MOVF        main_Count_L0+1, 0 
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
;unid_10_2_upDownCounter7segs.c,181 :: 		varAux /= 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_Count_L0+0, 0 
	MOVWF       R0 
	MOVF        main_Count_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
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
;unid_10_2_upDownCounter7segs.c,182 :: 		Dta[1] = DMatriz[varAux%10];
	MOVLW       _DMatriz+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_DMatriz+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Dta+1 
;unid_10_2_upDownCounter7segs.c,183 :: 		varAux /= 10;
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
;unid_10_2_upDownCounter7segs.c,184 :: 		Dta[2] = DMatriz[varAux%10];
	MOVLW       _DMatriz+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_DMatriz+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Dta+2 
;unid_10_2_upDownCounter7segs.c,185 :: 		varAux /= 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
;unid_10_2_upDownCounter7segs.c,186 :: 		Dta[3] = DMatriz[varAux%10];
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
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
;unid_10_2_upDownCounter7segs.c,187 :: 		Delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_main17:
	DECFSZ      R13, 1, 1
	BRA         L_main17
	DECFSZ      R12, 1, 1
	BRA         L_main17
	NOP
;unid_10_2_upDownCounter7segs.c,190 :: 		}
	GOTO        L_main7
;unid_10_2_upDownCounter7segs.c,191 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
