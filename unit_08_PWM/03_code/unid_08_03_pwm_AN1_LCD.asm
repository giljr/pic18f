
_ConfigMCU:

;unid_08_03_pwm_AN1_LCD.c,37 :: 		void ConfigMCU ()
;unid_08_03_pwm_AN1_LCD.c,43 :: 		ADCON1 = 0B00001110;// somente pino RA0/AN0 analogico, os outros digitais
	MOVLW       14
	MOVWF       ADCON1+0 
;unid_08_03_pwm_AN1_LCD.c,45 :: 		TRISA.RA0 = 1;
	BSF         TRISA+0, 0 
;unid_08_03_pwm_AN1_LCD.c,46 :: 		PORTA.RA0 = 1; //entrada AN0
	BSF         PORTA+0, 0 
;unid_08_03_pwm_AN1_LCD.c,47 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_main:

;unid_08_03_pwm_AN1_LCD.c,51 :: 		void main() {
;unid_08_03_pwm_AN1_LCD.c,55 :: 		ConfigMcu();
	CALL        _ConfigMCU+0, 0
;unid_08_03_pwm_AN1_LCD.c,57 :: 		Lcd_Init(); //sempre chamado para inicializar LCD, 4-bit Mode
	CALL        _Lcd_Init+0, 0
;unid_08_03_pwm_AN1_LCD.c,58 :: 		Lcd_Cmd(_LCD_CLEAR); //desliga cursor
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unid_08_03_pwm_AN1_LCD.c,59 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);//desliga cursor
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;unid_08_03_pwm_AN1_LCD.c,60 :: 		Lcd_Out(1, 1, "ADC:");  //linha x Coluna
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_unid_08_03_pwm_AN1_LCD+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_unid_08_03_pwm_AN1_LCD+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unid_08_03_pwm_AN1_LCD.c,63 :: 		PWM1_Init(5000);
	BSF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       99
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;unid_08_03_pwm_AN1_LCD.c,64 :: 		PWM1_Set_Duty(255); // 0(%) -> 255(100%)
	MOVLW       255
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;unid_08_03_pwm_AN1_LCD.c,65 :: 		PWM1_Start(); // start pwm ; temos mais de um canal ccp , escolha 1 ou 2...
	CALL        _PWM1_Start+0, 0
;unid_08_03_pwm_AN1_LCD.c,67 :: 		while (TRUE)
L_main0:
;unid_08_03_pwm_AN1_LCD.c,70 :: 		Leitura_ADC = (int) ADC_Read(1) * (255./1023.); //regra de 3 simples
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _int2double+0, 0
	MOVLW       208
	MOVWF       R4 
	MOVLW       63
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       124
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2word+0, 0
	MOVF        R0, 0 
	MOVWF       main_Leitura_ADC_L0+0 
	MOVF        R1, 0 
	MOVWF       main_Leitura_ADC_L0+1 
;unid_08_03_pwm_AN1_LCD.c,71 :: 		PWM1_Set_Duty(Leitura_ADC);// faça leitura 3 simples
	MOVF        R0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;unid_08_03_pwm_AN1_LCD.c,73 :: 		WordToStr(Leitura_ADC, txtDta);
	MOVF        main_Leitura_ADC_L0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        main_Leitura_ADC_L0+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       main_txtDta_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(main_txtDta_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;unid_08_03_pwm_AN1_LCD.c,74 :: 		Lcd_Out(1, 5, txtDta);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txtDta_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txtDta_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;unid_08_03_pwm_AN1_LCD.c,75 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	NOP
	NOP
;unid_08_03_pwm_AN1_LCD.c,76 :: 		}
	GOTO        L_main0
;unid_08_03_pwm_AN1_LCD.c,79 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
