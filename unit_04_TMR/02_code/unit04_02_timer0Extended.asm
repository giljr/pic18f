
_ConfigMCU:

;unit04_02_timer0Extended.c,82 :: 		void ConfigMCU()
;unit04_02_timer0Extended.c,87 :: 		ADCON1 |= 0X0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit04_02_timer0Extended.c,90 :: 		TRISB = 0;                               // LED as output
	CLRF        TRISB+0 
;unit04_02_timer0Extended.c,91 :: 		PORTB = 0;                               // LED off
	CLRF        PORTB+0 
;unit04_02_timer0Extended.c,92 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_ConfigTimer:

;unit04_02_timer0Extended.c,94 :: 		void ConfigTimer()
;unit04_02_timer0Extended.c,96 :: 		T0CON = 0B00000110;                 // prescale 1:128, mode 16-bit
	MOVLW       6
	MOVWF       T0CON+0 
;unit04_02_timer0Extended.c,97 :: 		TMR0L = 0XF7;
	MOVLW       247
	MOVWF       TMR0L+0 
;unit04_02_timer0Extended.c,98 :: 		TMR0H = 0XC7;                       // Recharge initial counter &
	MOVLW       199
	MOVWF       TMR0H+0 
;unit04_02_timer0Extended.c,99 :: 		INTCON.TMR0IF = 0;                  // clean overflow Timer0's flag
	BCF         INTCON+0, 2 
;unit04_02_timer0Extended.c,101 :: 		T0CON.TMR0ON = 1;                   // Timer0 on
	BSF         T0CON+0, 7 
;unit04_02_timer0Extended.c,102 :: 		}
L_end_ConfigTimer:
	RETURN      0
; end of _ConfigTimer

_main:

;unit04_02_timer0Extended.c,105 :: 		void main() {
;unit04_02_timer0Extended.c,106 :: 		unsigned char counter = 0;                // variable used for extend overflow time for TMR0
	CLRF        main_counter_L0+0 
;unit04_02_timer0Extended.c,108 :: 		ConfigMCU();
	CALL        _ConfigMCU+0, 0
;unit04_02_timer0Extended.c,109 :: 		ConfigTimer();
	CALL        _ConfigTimer+0, 0
;unit04_02_timer0Extended.c,111 :: 		while (TRUE)
L_main0:
;unit04_02_timer0Extended.c,113 :: 		if(INTCON.TMR0IF == 1)
	BTFSS       INTCON+0, 2 
	GOTO        L_main2
;unit04_02_timer0Extended.c,115 :: 		counter++;                          // By using counter you can make this
	INCF        main_counter_L0+0, 1 
;unit04_02_timer0Extended.c,117 :: 		if(counter == 5)
	MOVF        main_counter_L0+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
;unit04_02_timer0Extended.c,119 :: 		PORTB.RB0 = ~LATB.RB0;          // toggle LED's logic signal
	BTFSC       LATB+0, 0 
	GOTO        L__main7
	BSF         PORTB+0, 0 
	GOTO        L__main8
L__main7:
	BCF         PORTB+0, 0 
L__main8:
;unit04_02_timer0Extended.c,120 :: 		counter = 0;
	CLRF        main_counter_L0+0 
;unit04_02_timer0Extended.c,121 :: 		}
L_main3:
;unit04_02_timer0Extended.c,123 :: 		TMR0L = 0XF7;
	MOVLW       247
	MOVWF       TMR0L+0 
;unit04_02_timer0Extended.c,124 :: 		TMR0H = 0XC7;                       // initial recharged default values
	MOVLW       199
	MOVWF       TMR0H+0 
;unit04_02_timer0Extended.c,125 :: 		INTCON.TMR0IF = 0;                  // Flag Timer0's overflow signal
	BCF         INTCON+0, 2 
;unit04_02_timer0Extended.c,126 :: 		}
L_main2:
;unit04_02_timer0Extended.c,128 :: 		}
	GOTO        L_main0
;unit04_02_timer0Extended.c,133 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
