
_INTERRUPTION_HIGH:

;unid_10_1_7segsScan.c,34 :: 		void INTERRUPTION_HIGH() iv 0x0008 ics ICS_AUTO {
;unid_10_1_7segsScan.c,51 :: 		if(INTCON.TMR0IF == 1)
	BTFSS       INTCON+0, 2 
	GOTO        L_INTERRUPTION_HIGH0
;unid_10_1_7segsScan.c,53 :: 		PORTA &= 0B11000011;  //picGenios: Apaga RA2/RA3/RA4/RA5 display pins
	MOVLW       195
	ANDWF       PORTA+0, 1 
;unid_10_1_7segsScan.c,54 :: 		switch(state_machine)
	GOTO        L_INTERRUPTION_HIGH1
;unid_10_1_7segsScan.c,56 :: 		case d1: {
L_INTERRUPTION_HIGH3:
;unid_10_1_7segsScan.c,57 :: 		PORTD = 102;
	MOVLW       102
	MOVWF       PORTD+0 
;unid_10_1_7segsScan.c,58 :: 		PORTA.RA5 = 1;
	BSF         PORTA+0, 5 
;unid_10_1_7segsScan.c,59 :: 		state_machine = d2;
	MOVLW       2
	MOVWF       INTERRUPTION_HIGH_state_machine_L0+0 
;unid_10_1_7segsScan.c,60 :: 		break;
	GOTO        L_INTERRUPTION_HIGH2
;unid_10_1_7segsScan.c,62 :: 		case d2: {
L_INTERRUPTION_HIGH4:
;unid_10_1_7segsScan.c,63 :: 		PORTD = 79;
	MOVLW       79
	MOVWF       PORTD+0 
;unid_10_1_7segsScan.c,64 :: 		PORTA.RA4 = 1;
	BSF         PORTA+0, 4 
;unid_10_1_7segsScan.c,65 :: 		state_machine = d3;
	MOVLW       3
	MOVWF       INTERRUPTION_HIGH_state_machine_L0+0 
;unid_10_1_7segsScan.c,66 :: 		break;
	GOTO        L_INTERRUPTION_HIGH2
;unid_10_1_7segsScan.c,68 :: 		case d3: {
L_INTERRUPTION_HIGH5:
;unid_10_1_7segsScan.c,69 :: 		PORTD = 91;
	MOVLW       91
	MOVWF       PORTD+0 
;unid_10_1_7segsScan.c,70 :: 		PORTA.RA3 = 1;
	BSF         PORTA+0, 3 
;unid_10_1_7segsScan.c,71 :: 		state_machine = d4;
	MOVLW       4
	MOVWF       INTERRUPTION_HIGH_state_machine_L0+0 
;unid_10_1_7segsScan.c,72 :: 		break;
	GOTO        L_INTERRUPTION_HIGH2
;unid_10_1_7segsScan.c,74 :: 		case d4: {
L_INTERRUPTION_HIGH6:
;unid_10_1_7segsScan.c,75 :: 		PORTD = 6;
	MOVLW       6
	MOVWF       PORTD+0 
;unid_10_1_7segsScan.c,76 :: 		PORTA.RA2 = 1;
	BSF         PORTA+0, 2 
;unid_10_1_7segsScan.c,77 :: 		state_machine = d1;
	MOVLW       1
	MOVWF       INTERRUPTION_HIGH_state_machine_L0+0 
;unid_10_1_7segsScan.c,78 :: 		break;
	GOTO        L_INTERRUPTION_HIGH2
;unid_10_1_7segsScan.c,80 :: 		}
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
;unid_10_1_7segsScan.c,81 :: 		}
L_INTERRUPTION_HIGH0:
;unid_10_1_7segsScan.c,84 :: 		TMR0H = 0XFE;
	MOVLW       254
	MOVWF       TMR0H+0 
;unid_10_1_7segsScan.c,85 :: 		TMR0L = 0X06;
	MOVLW       6
	MOVWF       TMR0L+0 
;unid_10_1_7segsScan.c,86 :: 		INTCON.TMR0IF = 0;              // Clear flag & reset interruption cycle
	BCF         INTCON+0, 2 
;unid_10_1_7segsScan.c,88 :: 		}
L_end_INTERRUPTION_HIGH:
L__INTERRUPTION_HIGH10:
	RETFIE      1
; end of _INTERRUPTION_HIGH

_configMCU:

;unid_10_1_7segsScan.c,90 :: 		void configMCU()                   // Timer0 Port & Directions
;unid_10_1_7segsScan.c,96 :: 		ADCON1 |= 0X0F;                    // Analog pinouts
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unid_10_1_7segsScan.c,99 :: 		TRISA = 0;
	CLRF        TRISA+0 
;unid_10_1_7segsScan.c,100 :: 		PORTA = 0;                         // LEDs' control pins
	CLRF        PORTA+0 
;unid_10_1_7segsScan.c,101 :: 		TRISD = 0;
	CLRF        TRISD+0 
;unid_10_1_7segsScan.c,102 :: 		PORTD = 0;                         // LEDs' control pins
	CLRF        PORTD+0 
;unid_10_1_7segsScan.c,103 :: 		}
L_end_configMCU:
	RETURN      0
; end of _configMCU

_configTimer0:

;unid_10_1_7segsScan.c,105 :: 		void configTimer0()
;unid_10_1_7segsScan.c,111 :: 		T0CON = 0B00000010;
	MOVLW       2
	MOVWF       T0CON+0 
;unid_10_1_7segsScan.c,113 :: 		TMR0L = 0XFE;
	MOVLW       254
	MOVWF       TMR0L+0 
;unid_10_1_7segsScan.c,114 :: 		TMR0H = 0X0C;                       // Recharge initial counter &
	MOVLW       12
	MOVWF       TMR0H+0 
;unid_10_1_7segsScan.c,115 :: 		INTCON.TMR0IF = 0;                  // clean overflow Timer0's flag
	BCF         INTCON+0, 2 
;unid_10_1_7segsScan.c,117 :: 		T0CON.TMR0ON = 1;                   // Timer0 on
	BSF         T0CON+0, 7 
;unid_10_1_7segsScan.c,118 :: 		}
L_end_configTimer0:
	RETURN      0
; end of _configTimer0

_configGlobalInterruption:

;unid_10_1_7segsScan.c,120 :: 		void configGlobalInterruption()     // Interruptions's master keys
;unid_10_1_7segsScan.c,122 :: 		INTCON.GIEH = 1;                  // High priority enabled
	BSF         INTCON+0, 7 
;unid_10_1_7segsScan.c,123 :: 		INTCON.GIEL = 1;                  // Low prioritY enabled
	BSF         INTCON+0, 6 
;unid_10_1_7segsScan.c,124 :: 		RCON.IPEN =   1;                  // Compatibility family 16F (just one level)
	BSF         RCON+0, 7 
;unid_10_1_7segsScan.c,127 :: 		}
L_end_configGlobalInterruption:
	RETURN      0
; end of _configGlobalInterruption

_configIndividualVctTMR0:

;unid_10_1_7segsScan.c,128 :: 		void configIndividualVctTMR0()
;unid_10_1_7segsScan.c,131 :: 		INTCON.TMR0IF  = 0;               // Overflow flag; please init zero
	BCF         INTCON+0, 2 
;unid_10_1_7segsScan.c,132 :: 		INTCON2.TMR0IP = 1;               // Interruption priority vector: HIGH
	BSF         INTCON2+0, 2 
;unid_10_1_7segsScan.c,133 :: 		INTCON.TMR0IE  = 1;               // TIMER0's interruption enabled
	BSF         INTCON+0, 5 
;unid_10_1_7segsScan.c,134 :: 		}
L_end_configIndividualVctTMR0:
	RETURN      0
; end of _configIndividualVctTMR0

_main:

;unid_10_1_7segsScan.c,136 :: 		void main()
;unid_10_1_7segsScan.c,138 :: 		configMCU();
	CALL        _configMCU+0, 0
;unid_10_1_7segsScan.c,139 :: 		configTimer0();
	CALL        _configTimer0+0, 0
;unid_10_1_7segsScan.c,140 :: 		configGlobalInterruption();
	CALL        _configGlobalInterruption+0, 0
;unid_10_1_7segsScan.c,141 :: 		configIndividualVctTMR0();
	CALL        _configIndividualVctTMR0+0, 0
;unid_10_1_7segsScan.c,150 :: 		while(TRUE)
L_main7:
;unid_10_1_7segsScan.c,154 :: 		}
	GOTO        L_main7
;unid_10_1_7segsScan.c,158 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
