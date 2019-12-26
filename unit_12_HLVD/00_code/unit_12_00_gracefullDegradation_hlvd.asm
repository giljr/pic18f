
_INTERRUPCAO_HIGH:

;unit_12_00_gracefullDegradation_hlvd.c,26 :: 		void INTERRUPCAO_HIGH() iv 0x0008 ics ICS_AUTO {
;unit_12_00_gracefullDegradation_hlvd.c,27 :: 		if(HLVDIF_bit == 1)
	BTFSS       HLVDIF_bit+0, BitPos(HLVDIF_bit+0) 
	GOTO        L_INTERRUPCAO_HIGH0
;unit_12_00_gracefullDegradation_hlvd.c,29 :: 		EEPROM_Write(0, count);              // Variable LED's state change count saved in eeprom at interruptions routine only :)
	CLRF        FARG_EEPROM_Write_address+0 
	MOVF        _count+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;unit_12_00_gracefullDegradation_hlvd.c,31 :: 		HLVDIF_bit = 0;
	BCF         HLVDIF_bit+0, BitPos(HLVDIF_bit+0) 
;unit_12_00_gracefullDegradation_hlvd.c,32 :: 		}
L_INTERRUPCAO_HIGH0:
;unit_12_00_gracefullDegradation_hlvd.c,33 :: 		}
L_end_INTERRUPCAO_HIGH:
L__INTERRUPCAO_HIGH6:
	RETFIE      1
; end of _INTERRUPCAO_HIGH

_ConfigMCU:

;unit_12_00_gracefullDegradation_hlvd.c,35 :: 		void ConfigMCU()
;unit_12_00_gracefullDegradation_hlvd.c,40 :: 		ADCON1 |= 0X0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;unit_12_00_gracefullDegradation_hlvd.c,43 :: 		TRISD = 0;
	CLRF        TRISD+0 
;unit_12_00_gracefullDegradation_hlvd.c,44 :: 		PORTD = 0;
	CLRF        PORTD+0 
;unit_12_00_gracefullDegradation_hlvd.c,45 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_main:

;unit_12_00_gracefullDegradation_hlvd.c,46 :: 		void main() {
;unit_12_00_gracefullDegradation_hlvd.c,47 :: 		ConfigMCU();
	CALL        _ConfigMCU+0, 0
;unit_12_00_gracefullDegradation_hlvd.c,48 :: 		count = EEPROM_Read(0);               // As soon as the power is back, read eeprom and save in PORTD
	CLRF        FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _count+0 
	MOVLW       0
	MOVWF       _count+1 
;unit_12_00_gracefullDegradation_hlvd.c,49 :: 		PORTD = count;
	MOVF        _count+0, 0 
	MOVWF       PORTD+0 
;unit_12_00_gracefullDegradation_hlvd.c,50 :: 		GIEH_bit = 1;                        // Enable high priority interruptions
	BSF         GIEH_bit+0, BitPos(GIEH_bit+0) 
;unit_12_00_gracefullDegradation_hlvd.c,51 :: 		GIEL_bit = 1;
	BSF         GIEL_bit+0, BitPos(GIEL_bit+0) 
;unit_12_00_gracefullDegradation_hlvd.c,52 :: 		IPEN_bit = 1;
	BSF         IPEN_bit+0, BitPos(IPEN_bit+0) 
;unit_12_00_gracefullDegradation_hlvd.c,54 :: 		HLVDIF_bit = 0;                      // Config HLVD peripheral (clears flag, High priority, HLVD's INT enable)
	BCF         HLVDIF_bit+0, BitPos(HLVDIF_bit+0) 
;unit_12_00_gracefullDegradation_hlvd.c,55 :: 		HLVDIP_bit = 1;
	BSF         HLVDIP_bit+0, BitPos(HLVDIP_bit+0) 
;unit_12_00_gracefullDegradation_hlvd.c,56 :: 		HLVDIE_bit = 1;                      // See datasheet (pg.341) Table 26-4 for specifications: HLVD<7,6,5,4,3,2,1,0>
	BSF         HLVDIE_bit+0, BitPos(HLVDIE_bit+0) 
;unit_12_00_gracefullDegradation_hlvd.c,57 :: 		HLVDCON = 0B00011110;                // Event occurs when voltage equals or falls below trip point HLVDL<7> = 0
	MOVLW       30
	MOVWF       HLVDCON+0 
;unit_12_00_gracefullDegradation_hlvd.c,65 :: 		Delay_ms(2000);                      // Delay for eeprom operation & system stabilization
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main1:
	DECFSZ      R13, 1, 1
	BRA         L_main1
	DECFSZ      R12, 1, 1
	BRA         L_main1
	DECFSZ      R11, 1, 1
	BRA         L_main1
	NOP
;unit_12_00_gracefullDegradation_hlvd.c,66 :: 		while(1) {
L_main2:
;unit_12_00_gracefullDegradation_hlvd.c,67 :: 		PORTD = count++;
	MOVF        _count+0, 0 
	MOVWF       PORTD+0 
	MOVLW       1
	ADDWF       _count+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _count+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _count+0 
	MOVF        R1, 0 
	MOVWF       _count+1 
;unit_12_00_gracefullDegradation_hlvd.c,69 :: 		Delay_ms(1000);                     // DO NOT MAKE IT IN PRODUCTION or you will decrease the life cycle or your eeprom :/
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
	NOP
;unit_12_00_gracefullDegradation_hlvd.c,70 :: 		}                                    // Use interruptions instead :)
	GOTO        L_main2
;unit_12_00_gracefullDegradation_hlvd.c,71 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
