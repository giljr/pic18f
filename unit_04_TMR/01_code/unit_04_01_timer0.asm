
_ConfigMCU:

;unit_04_01_timer0.c,77 :: 		void ConfigMCU()
;unit_04_01_timer0.c,82 :: 		ADCON1 |= 0X0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit_04_01_timer0.c,85 :: 		TRISD = 0;                               // LED as output
	CLRF        TRISD+0 
;unit_04_01_timer0.c,86 :: 		PORTD = 0;                               // LED off
	CLRF        PORTD+0 
;unit_04_01_timer0.c,87 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_ConfigTimer:

;unit_04_01_timer0.c,89 :: 		void ConfigTimer()
;unit_04_01_timer0.c,91 :: 		T0CON = 0B00000110;                 // prescale 1:128, mode 16-bit
	MOVLW       6
	MOVWF       T0CON+0 
;unit_04_01_timer0.c,92 :: 		TMR0L = 0XF7;
	MOVLW       247
	MOVWF       TMR0L+0 
;unit_04_01_timer0.c,93 :: 		TMR0H = 0XC7;                       // Recharge initial counter &
	MOVLW       199
	MOVWF       TMR0H+0 
;unit_04_01_timer0.c,94 :: 		INTCON.TMR0IF = 0;                  // clean overflow Timer0's flag
	BCF         INTCON+0, 2 
;unit_04_01_timer0.c,96 :: 		T0CON.TMR0ON = 1;                   // Timer0 on
	BSF         T0CON+0, 7 
;unit_04_01_timer0.c,97 :: 		}
L_end_ConfigTimer:
	RETURN      0
; end of _ConfigTimer

_main:

;unit_04_01_timer0.c,100 :: 		void main() {
;unit_04_01_timer0.c,101 :: 		ConfigMCU();
	CALL        _ConfigMCU+0, 0
;unit_04_01_timer0.c,102 :: 		ConfigTimer();
	CALL        _ConfigTimer+0, 0
;unit_04_01_timer0.c,104 :: 		while (TRUE)
L_main0:
;unit_04_01_timer0.c,106 :: 		if(INTCON.TMR0IF == 1)
	BTFSS       INTCON+0, 2 
	GOTO        L_main2
;unit_04_01_timer0.c,108 :: 		PORTD.RD0 = ~LATD.RD0;              // toggle LED's logic signal
	BTFSC       LATD+0, 0 
	GOTO        L__main6
	BSF         PORTD+0, 0 
	GOTO        L__main7
L__main6:
	BCF         PORTD+0, 0 
L__main7:
;unit_04_01_timer0.c,110 :: 		TMR0L = 0XF7;
	MOVLW       247
	MOVWF       TMR0L+0 
;unit_04_01_timer0.c,111 :: 		TMR0H = 0XC7;                       // initial recharged default values
	MOVLW       199
	MOVWF       TMR0H+0 
;unit_04_01_timer0.c,112 :: 		INTCON.TMR0IF = 0;                  // Flag Timer0's overflow signal
	BCF         INTCON+0, 2 
;unit_04_01_timer0.c,113 :: 		}
L_main2:
;unit_04_01_timer0.c,115 :: 		}
	GOTO        L_main0
;unit_04_01_timer0.c,120 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
