
_ConfigMCU:

;unit04_03_countTillTen.c,66 :: 		void ConfigMCU()
;unit04_03_countTillTen.c,73 :: 		ADCON1 |= 0X0F;                    // Determine if anal/digital pins
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit04_03_countTillTen.c,77 :: 		TRISA.RA4 = 1;                   // Input pin for simulate external pulses
	BSF         TRISA+0, 4 
;unit04_03_countTillTen.c,79 :: 		PORTA.RA4 = 1;                   // Opcional
	BSF         PORTA+0, 4 
;unit04_03_countTillTen.c,81 :: 		TRISB = 0;
	CLRF        TRISB+0 
;unit04_03_countTillTen.c,82 :: 		PORTB = 0;
	CLRF        PORTB+0 
;unit04_03_countTillTen.c,83 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_ConfigTimer:

;unit04_03_countTillTen.c,85 :: 		void ConfigTimer()
;unit04_03_countTillTen.c,87 :: 		T0CON = 0B00111000;               // mode counter, mode16-bits, timer off, edge high-low
	MOVLW       56
	MOVWF       T0CON+0 
;unit04_03_countTillTen.c,88 :: 		TMR0H = 0XFF;                     // valor de carga inicial
	MOVLW       255
	MOVWF       TMR0H+0 
;unit04_03_countTillTen.c,89 :: 		TMR0L = 0XF6;
	MOVLW       246
	MOVWF       TMR0L+0 
;unit04_03_countTillTen.c,91 :: 		INTCON.TMR0IF = 0;                // Flag de sinalização de estouro do Timer0
	BCF         INTCON+0, 2 
;unit04_03_countTillTen.c,92 :: 		T0CON.TMR0ON = 1;                 // liga o Timer0 depois de configurarmos tudo.
	BSF         T0CON+0, 7 
;unit04_03_countTillTen.c,93 :: 		}
L_end_ConfigTimer:
	RETURN      0
; end of _ConfigTimer

_main:

;unit04_03_countTillTen.c,96 :: 		void main() {
;unit04_03_countTillTen.c,97 :: 		ConfigMCU();
	CALL        _ConfigMCU+0, 0
;unit04_03_countTillTen.c,98 :: 		ConfigTimer();
	CALL        _ConfigTimer+0, 0
;unit04_03_countTillTen.c,100 :: 		while (TRUE)
L_main0:
;unit04_03_countTillTen.c,102 :: 		if(INTCON.TMR0IF == 1)
	BTFSS       INTCON+0, 2 
	GOTO        L_main2
;unit04_03_countTillTen.c,104 :: 		PORTB.RB0 = ~LATB.RB0;        // toggle LED
	BTFSC       LATB+0, 0 
	GOTO        L__main6
	BSF         PORTB+0, 0 
	GOTO        L__main7
L__main6:
	BCF         PORTB+0, 0 
L__main7:
;unit04_03_countTillTen.c,106 :: 		TMR0H = 0XFF;
	MOVLW       255
	MOVWF       TMR0H+0 
;unit04_03_countTillTen.c,107 :: 		TMR0L = 0XF6;
	MOVLW       246
	MOVWF       TMR0L+0 
;unit04_03_countTillTen.c,108 :: 		INTCON.TMR0IF = 0;            // Timer0's overflow Flag
	BCF         INTCON+0, 2 
;unit04_03_countTillTen.c,109 :: 		}
L_main2:
;unit04_03_countTillTen.c,110 :: 		}
	GOTO        L_main0
;unit04_03_countTillTen.c,111 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
