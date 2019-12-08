
_main:

;unid_10_0_7segsTest.c,3 :: 		void main(){                      // função principal do programa
;unid_10_0_7segsTest.c,4 :: 		ADCON1 = 6;                    //configura todos os pinos AD como I/O
	MOVLW       6
	MOVWF       ADCON1+0 
;unid_10_0_7segsTest.c,5 :: 		PORTA = 0;                     //resseta todos os pinos do porta
	CLRF        PORTA+0 
;unid_10_0_7segsTest.c,6 :: 		TRISA = 0;                     //define porta como saida
	CLRF        TRISA+0 
;unid_10_0_7segsTest.c,7 :: 		TRISD = 0;                     //define portd como saida
	CLRF        TRISD+0 
;unid_10_0_7segsTest.c,8 :: 		PORTD = 255;                   //seta todos os pinos do portd
	MOVLW       255
	MOVWF       PORTD+0 
;unid_10_0_7segsTest.c,10 :: 		do {                              //inicio da rotina de loop
L_main0:
;unid_10_0_7segsTest.c,11 :: 		PORTA.F2= 1;                   //liga primeiro display
	BSF         PORTA+0, 2 
;unid_10_0_7segsTest.c,12 :: 		PORTD = 0x06;                  //escreve digito 1
	MOVLW       6
	MOVWF       PORTD+0 
;unid_10_0_7segsTest.c,13 :: 		Delay_ms(1);                   //delay de 1ms
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	NOP
	NOP
;unid_10_0_7segsTest.c,14 :: 		PORTA.F2= 0;                  //desliga primeiro display
	BCF         PORTA+0, 2 
;unid_10_0_7segsTest.c,15 :: 		PORTA.F3= 1;                   //liga segundo display
	BSF         PORTA+0, 3 
;unid_10_0_7segsTest.c,16 :: 		PORTD = 0x5B;                  //escreve digito 2
	MOVLW       91
	MOVWF       PORTD+0 
;unid_10_0_7segsTest.c,17 :: 		Delay_ms(1);                   //delay de 1ms
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	NOP
	NOP
;unid_10_0_7segsTest.c,18 :: 		PORTA.F3= 0;                   //desliga terceiro display
	BCF         PORTA+0, 3 
;unid_10_0_7segsTest.c,19 :: 		PORTA.F4= 1;                   //liga terceiro display
	BSF         PORTA+0, 4 
;unid_10_0_7segsTest.c,20 :: 		PORTD = 0x4F;                  //escreve digito 3
	MOVLW       79
	MOVWF       PORTD+0 
;unid_10_0_7segsTest.c,21 :: 		Delay_ms(1);                  //delay de 1ms
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	NOP
	NOP
;unid_10_0_7segsTest.c,22 :: 		PORTA.F4= 0;                   //desliga terceiro display
	BCF         PORTA+0, 4 
;unid_10_0_7segsTest.c,23 :: 		PORTA.F5= 1;                  //liga quarto display
	BSF         PORTA+0, 5 
;unid_10_0_7segsTest.c,24 :: 		PORTD = 0x66;                 //escreve digito 4
	MOVLW       102
	MOVWF       PORTD+0 
;unid_10_0_7segsTest.c,25 :: 		Delay_ms(1);                   //delay de 1ms
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	NOP
	NOP
;unid_10_0_7segsTest.c,26 :: 		PORTA.F5= 0;                   //desliga quarto display
	BCF         PORTA+0, 5 
;unid_10_0_7segsTest.c,28 :: 		while (1);
	GOTO        L_main0
;unid_10_0_7segsTest.c,29 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
