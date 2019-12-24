
_interrupt:

;main.c,7 :: 		void interrupt(){
;main.c,8 :: 		USB_Interrupt_Proc();                   // USB servicing is done inside the interrupt
	CALL        _USB_Interrupt_Proc+0, 0
;main.c,9 :: 		}
L_end_interrupt:
L__interrupt10:
	RETFIE      1
; end of _interrupt

_main:

;main.c,12 :: 		void main(void){
;main.c,13 :: 		ADCON1 |= 0x0F;                         // Configure all ports with analog function as digital
	MOVLW       15
	IORWF       ADCON1+0, 1 
;main.c,14 :: 		CMCON  |= 7;                            // Disable comparators
	MOVLW       7
	IORWF       CMCON+0, 1 
;main.c,16 :: 		HID_Enable(&readbuff,&writebuff);       // Enable HID communication
	MOVLW       _readbuff+0
	MOVWF       FARG_HID_Enable_readbuff+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_HID_Enable_readbuff+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Enable_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Enable_writebuff+1 
	CALL        _HID_Enable+0, 0
;main.c,18 :: 		TRISD = 0;
	CLRF        TRISD+0 
;main.c,19 :: 		PORTD = 0;
	CLRF        PORTD+0 
;main.c,22 :: 		while(1){
L_main0:
;main.c,23 :: 		if(HID_Read())
	CALL        _HID_Read+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main2
;main.c,26 :: 		if(readbuff[0] == 10)
	MOVF        1280, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
;main.c,28 :: 		PORTD.RD0 = readbuff[1]; //inverter o led
	BTFSC       1281, 0 
	GOTO        L__main12
	BCF         PORTD+0, 0 
	GOTO        L__main13
L__main12:
	BSF         PORTD+0, 0 
L__main13:
;main.c,29 :: 		count++;
	INCF        _count+0, 1 
;main.c,30 :: 		writebuff[19] = 37;
	MOVLW       37
	MOVWF       1363 
;main.c,31 :: 		writebuff[20] = count;
	MOVF        _count+0, 0 
	MOVWF       1364 
;main.c,33 :: 		while(!HID_Write(&writebuff,64));
L_main4:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
	GOTO        L_main4
L_main5:
;main.c,35 :: 		}
L_main3:
;main.c,37 :: 		if(readbuff[5] == 10)
	MOVF        1285, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main6
;main.c,39 :: 		PORTD.RD1 = readbuff[6]; //inverter o led
	BTFSC       1286, 0 
	GOTO        L__main14
	BCF         PORTD+0, 1 
	GOTO        L__main15
L__main14:
	BSF         PORTD+0, 1 
L__main15:
;main.c,40 :: 		count++;
	INCF        _count+0, 1 
;main.c,41 :: 		writebuff[19] = 37;
	MOVLW       37
	MOVWF       1363 
;main.c,42 :: 		writebuff[20] = count;
	MOVF        _count+0, 0 
	MOVWF       1364 
;main.c,44 :: 		while(!HID_Write(&writebuff,64));
L_main7:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main8
	GOTO        L_main7
L_main8:
;main.c,46 :: 		}
L_main6:
;main.c,48 :: 		}
L_main2:
;main.c,51 :: 		}
	GOTO        L_main0
;main.c,52 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
