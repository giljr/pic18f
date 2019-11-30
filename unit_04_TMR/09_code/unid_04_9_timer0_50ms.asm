
_ConfigMCU:

;unid_04_9_timer0_50ms.c,59 :: 		void ConfigMCU()
;unid_04_9_timer0_50ms.c,64 :: 		ADCON1 = 0X0F;                    // (PIC18F45220) Determine if anal/digital pins
	MOVLW       15
	MOVWF       ADCON1+0 
;unid_04_9_timer0_50ms.c,66 :: 		TRISD = 0;                         // LED is attached to PORTD.R0 BYTE
	CLRF        TRISD+0 
;unid_04_9_timer0_50ms.c,67 :: 		PORTD = 0;
	CLRF        PORTD+0 
;unid_04_9_timer0_50ms.c,68 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_ConfigTimer:

;unid_04_9_timer0_50ms.c,70 :: 		void ConfigTimer()
;unid_04_9_timer0_50ms.c,75 :: 		T0CON = 0B10000111;                // Timer0 off, Prescale 1:128 , Mode 16-BITS, LOW-HIGH
	MOVLW       135
	MOVWF       T0CON+0 
;unid_04_9_timer0_50ms.c,77 :: 		TMR0H = 0XFE;                          // Initial values for accumulator registers
	MOVLW       254
	MOVWF       TMR0H+0 
;unid_04_9_timer0_50ms.c,78 :: 		TMR0L = 0X7A;
	MOVLW       122
	MOVWF       TMR0L+0 
;unid_04_9_timer0_50ms.c,80 :: 		INTCON.TMR0IF = 0;                    // Flag cleared
	BCF         INTCON+0, 2 
;unid_04_9_timer0_50ms.c,81 :: 		T0CON.TMR0ON = 1;                    // Timer0 on, everything is configured, rightD
	BSF         T0CON+0, 7 
;unid_04_9_timer0_50ms.c,82 :: 		}
L_end_ConfigTimer:
	RETURN      0
; end of _ConfigTimer

_main:

;unid_04_9_timer0_50ms.c,84 :: 		void main() {
;unid_04_9_timer0_50ms.c,85 :: 		ConfigMCU();
	CALL        _ConfigMCU+0, 0
;unid_04_9_timer0_50ms.c,86 :: 		ConfigTimer();
	CALL        _ConfigTimer+0, 0
;unid_04_9_timer0_50ms.c,88 :: 		while (TRUE)                         // Do forever
L_main0:
;unid_04_9_timer0_50ms.c,90 :: 		if(INTCON.TMR0IF == 1)
	BTFSS       INTCON+0, 2 
	GOTO        L_main2
;unid_04_9_timer0_50ms.c,92 :: 		PORTD.RD5 = ~LATD.RD5;          // toggle LED
	BTFSC       LATD+0, 5 
	GOTO        L__main6
	BSF         PORTD+0, 5 
	GOTO        L__main7
L__main6:
	BCF         PORTD+0, 5 
L__main7:
;unid_04_9_timer0_50ms.c,94 :: 		TMR0H = 0XFE;                  // Recharge default values
	MOVLW       254
	MOVWF       TMR0H+0 
;unid_04_9_timer0_50ms.c,95 :: 		TMR0L = 0X7A;
	MOVLW       122
	MOVWF       TMR0L+0 
;unid_04_9_timer0_50ms.c,96 :: 		INTCON.TMR0IF = 0;                // Clear Timer0's overflow Flag
	BCF         INTCON+0, 2 
;unid_04_9_timer0_50ms.c,97 :: 		}
L_main2:
;unid_04_9_timer0_50ms.c,98 :: 		}
	GOTO        L_main0
;unid_04_9_timer0_50ms.c,99 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
