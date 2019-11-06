
_ConfigMCU:

;unid_04_timer0_50ms.c,62 :: 		void ConfigMCU()
;unid_04_timer0_50ms.c,67 :: 		ADCON1 = 0X0F;                     // (PIC18F45220) Determine if anal/digital pins
	MOVLW       15
	MOVWF       ADCON1+0 
;unid_04_timer0_50ms.c,69 :: 		TRISD = 0;                         // LED is attached to PORTD.R0 BYTE
	CLRF        TRISD+0 
;unid_04_timer0_50ms.c,70 :: 		PORTD = 0;
	CLRF        PORTD+0 
;unid_04_timer0_50ms.c,71 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_ConfigTimer:

;unid_04_timer0_50ms.c,73 :: 		void ConfigTimer()
;unid_04_timer0_50ms.c,78 :: 		T0CON = 0B00000110;                // Timer0 off, Prescale 1:128 , Mode 16-BITS, LOW/HIGH
	MOVLW       6
	MOVWF       T0CON+0 
;unid_04_timer0_50ms.c,80 :: 		TMR0H = 0XFC;                       // Initial values for accumulator registers
	MOVLW       252
	MOVWF       TMR0H+0 
;unid_04_timer0_50ms.c,81 :: 		TMR0L = 0XF3;
	MOVLW       243
	MOVWF       TMR0L+0 
;unid_04_timer0_50ms.c,83 :: 		INTCON.TMR0IF = 0;                  // Flag cleared
	BCF         INTCON+0, 2 
;unid_04_timer0_50ms.c,84 :: 		T0CON.TMR0ON = 1;                   // Timer0 on, everything is configured, rightD
	BSF         T0CON+0, 7 
;unid_04_timer0_50ms.c,85 :: 		}
L_end_ConfigTimer:
	RETURN      0
; end of _ConfigTimer

_main:

;unid_04_timer0_50ms.c,87 :: 		void main() {
;unid_04_timer0_50ms.c,88 :: 		ConfigMCU();
	CALL        _ConfigMCU+0, 0
;unid_04_timer0_50ms.c,89 :: 		ConfigTimer();
	CALL        _ConfigTimer+0, 0
;unid_04_timer0_50ms.c,91 :: 		while (TRUE)                         // Do forever
L_main0:
;unid_04_timer0_50ms.c,93 :: 		if(INTCON.TMR0IF == 1)
	BTFSS       INTCON+0, 2 
	GOTO        L_main2
;unid_04_timer0_50ms.c,95 :: 		PORTD.RD0 = ~LATD.RD0;          // toggle LED
	BTFSC       LATD+0, 0 
	GOTO        L__main6
	BSF         PORTD+0, 0 
	GOTO        L__main7
L__main6:
	BCF         PORTD+0, 0 
L__main7:
;unid_04_timer0_50ms.c,97 :: 		TMR0H = 0XFC;                   // Recharge default values
	MOVLW       252
	MOVWF       TMR0H+0 
;unid_04_timer0_50ms.c,98 :: 		TMR0L = 0XF3;
	MOVLW       243
	MOVWF       TMR0L+0 
;unid_04_timer0_50ms.c,99 :: 		INTCON.TMR0IF = 0;              // Clear Timer0's overflow Flag
	BCF         INTCON+0, 2 
;unid_04_timer0_50ms.c,100 :: 		}
L_main2:
;unid_04_timer0_50ms.c,101 :: 		}
	GOTO        L_main0
;unid_04_timer0_50ms.c,102 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
