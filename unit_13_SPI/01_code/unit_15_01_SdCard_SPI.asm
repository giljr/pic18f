
_main:

;unit_15_01_SdCard_SPI.c,39 :: 		void main()
;unit_15_01_SdCard_SPI.c,46 :: 		ADCON1 |= 0X0F;                         // Config all ADC's pins as digital
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit_15_01_SdCard_SPI.c,50 :: 		TRISD = 0;               // Config all PORTD's pins as Output (0=0:)
	CLRF        TRISD+0 
;unit_15_01_SdCard_SPI.c,51 :: 		PORTD = 0;               // Config all PORTD's pins as LOW,
	CLRF        PORTD+0 
;unit_15_01_SdCard_SPI.c,54 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       2
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;unit_15_01_SdCard_SPI.c,60 :: 		fhandle = MMc_Fat_Open(&filename,FILE_WRITE,0x80);
	MOVLW       _filename+0
	MOVWF       FARG_Mmc_Fat_Open_name+0 
	MOVLW       hi_addr(_filename+0)
	MOVWF       FARG_Mmc_Fat_Open_name+1 
	MOVLW       2
	MOVWF       FARG_Mmc_Fat_Open_mode+0 
	MOVLW       128
	MOVWF       FARG_Mmc_Fat_Open_attrib+0 
	CALL        _Mmc_Fat_Open+0, 0
;unit_15_01_SdCard_SPI.c,62 :: 		Mmc_Fat_Rewrite();                         //Write to the file, specifying the length of the text
	CALL        _Mmc_Fat_Rewrite+0, 0
;unit_15_01_SdCard_SPI.c,63 :: 		Mmc_Fat_Write("This is MYFILE.TXT.",19);   // Add more data to the end...
	MOVLW       ?lstr1_unit_15_01_SdCard_SPI+0
	MOVWF       FARG_Mmc_Fat_Write_fdata+0 
	MOVLW       hi_addr(?lstr1_unit_15_01_SdCard_SPI+0)
	MOVWF       FARG_Mmc_Fat_Write_fdata+1 
	MOVLW       19
	MOVWF       FARG_Mmc_Fat_Write_len+0 
	MOVLW       0
	MOVWF       FARG_Mmc_Fat_Write_len+1 
	CALL        _Mmc_Fat_Write+0, 0
;unit_15_01_SdCard_SPI.c,64 :: 		Mmc_Fat_Append();
	CALL        _Mmc_Fat_Append+0, 0
;unit_15_01_SdCard_SPI.c,65 :: 		Mmc_Fat_Write(txt,sizeof(txt));            // Now close the file (releases the handle) //
	MOVLW       _txt+0
	MOVWF       FARG_Mmc_Fat_Write_fdata+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Mmc_Fat_Write_fdata+1 
	MOVLW       26
	MOVWF       FARG_Mmc_Fat_Write_len+0 
	MOVLW       0
	MOVWF       FARG_Mmc_Fat_Write_len+1 
	CALL        _Mmc_Fat_Write+0, 0
;unit_15_01_SdCard_SPI.c,66 :: 		Mmc_Fat_Close();
	CALL        _Mmc_Fat_Close+0, 0
;unit_15_01_SdCard_SPI.c,68 :: 		while(1)                                    // Wait here forever
L_main0:
;unit_15_01_SdCard_SPI.c,70 :: 		PORTD.RD0 = 1;     // Turn LED on
	BSF         PORTD+0, 0 
;unit_15_01_SdCard_SPI.c,71 :: 		Delay_ms(300);     // delay 300 ms
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
	NOP
;unit_15_01_SdCard_SPI.c,72 :: 		PORTD.RD0 = 0;     // Turn LED off
	BCF         PORTD+0, 0 
;unit_15_01_SdCard_SPI.c,73 :: 		Delay_ms(300);     // delay 300 ms
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;unit_15_01_SdCard_SPI.c,74 :: 		}
	GOTO        L_main0
;unit_15_01_SdCard_SPI.c,75 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
