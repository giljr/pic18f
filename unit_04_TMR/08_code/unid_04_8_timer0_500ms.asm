
_ConfigMCU:

;unid_04_8_timer0_500ms.c,69 :: 		void ConfigMCU()
;unid_04_8_timer0_500ms.c,74 :: 		ADCON1 = 0X0F;                     // (PIC18F45220) Determine if anal/digital pins
	MOVLW       15
	MOVWF       ADCON1+0 
;unid_04_8_timer0_500ms.c,76 :: 		TRISD = 0;                         // LED is attached to PORTD.R0 BYTE
	CLRF        TRISD+0 
;unid_04_8_timer0_500ms.c,77 :: 		PORTD = 0;
	CLRF        PORTD+0 
;unid_04_8_timer0_500ms.c,78 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_ConfigTimer0:

;unid_04_8_timer0_500ms.c,80 :: 		void ConfigTimer0()
;unid_04_8_timer0_500ms.c,85 :: 		T0CON = 0B10000111;                // Timer0 off, Prescale 1:256 , Mode 16-BITS, LOW-HIGH
	MOVLW       135
	MOVWF       T0CON+0 
;unid_04_8_timer0_500ms.c,87 :: 		TMR0H = 0XF0;                       // Initial values for accumulator registers
	MOVLW       240
	MOVWF       TMR0H+0 
;unid_04_8_timer0_500ms.c,88 :: 		TMR0L = 0XBE;
	MOVLW       190
	MOVWF       TMR0L+0 
;unid_04_8_timer0_500ms.c,90 :: 		INTCON.TMR0IF = 0;                  // Flag cleared
	BCF         INTCON+0, 2 
;unid_04_8_timer0_500ms.c,91 :: 		T0CON.TMR0ON = 1;                   // Timer0 on, everything is configured, rightD
	BSF         T0CON+0, 7 
;unid_04_8_timer0_500ms.c,92 :: 		}
L_end_ConfigTimer0:
	RETURN      0
; end of _ConfigTimer0

_main:

;unid_04_8_timer0_500ms.c,94 :: 		void main() {
;unid_04_8_timer0_500ms.c,95 :: 		ConfigMCU();
	CALL        _ConfigMCU+0, 0
;unid_04_8_timer0_500ms.c,96 :: 		ConfigTimer0();
	CALL        _ConfigTimer0+0, 0
;unid_04_8_timer0_500ms.c,98 :: 		while (TRUE)                         // Do forever
L_main0:
;unid_04_8_timer0_500ms.c,100 :: 		if(INTCON.TMR0IF == 1)
	BTFSS       INTCON+0, 2 
	GOTO        L_main2
;unid_04_8_timer0_500ms.c,102 :: 		PORTD.RD5 = ~LATD.RD5;          // toggle LED
	BTFSC       LATD+0, 5 
	GOTO        L__main6
	BSF         PORTD+0, 5 
	GOTO        L__main7
L__main6:
	BCF         PORTD+0, 5 
L__main7:
;unid_04_8_timer0_500ms.c,104 :: 		TMR0H = 0XF0;                   // Recharge default values
	MOVLW       240
	MOVWF       TMR0H+0 
;unid_04_8_timer0_500ms.c,105 :: 		TMR0L = 0XBE;
	MOVLW       190
	MOVWF       TMR0L+0 
;unid_04_8_timer0_500ms.c,106 :: 		INTCON.TMR0IF = 0;               // Clear Timer0's overflow Flag
	BCF         INTCON+0, 2 
;unid_04_8_timer0_500ms.c,107 :: 		}
L_main2:
;unid_04_8_timer0_500ms.c,108 :: 		}
	GOTO        L_main0
;unid_04_8_timer0_500ms.c,109 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
