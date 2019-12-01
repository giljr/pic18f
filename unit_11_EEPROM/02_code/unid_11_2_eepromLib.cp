#line 1 "C:/Users/giljr/Documents/pic/unid_11_EEPROM/02_code/unid_11_2_eepromLib.c"
void EEPROM_Write_byte(unsigned char address, unsigned char dta)
{
 char STATUS_GIE = 0;
 EEADR = address;
 EEDATA = dta;
 EECON1.EEPGD = 0;
 EECON1.CFGS = 0;
 EECON1.WREN = 1;
 STATUS_GIE = INTCON.GIEH;
 INTCON.GIEH = 0;
 EECON2 = 0x55;
 EECON2 = 0xAA;
 EECON1.WR = 1;
 while(EECON1.WR == 1);
 INTCON.GIEH = STATUS_GIE;
 EECON1.WREN = 0;

}

unsigned char EEPROM_Read_byte(unsigned char address)
{
 EEADR = address;
 EECON1.CFGS = 0;
 EECON1.EEPGD = 0;
 EECON1.RD = 1;
 asm nop;
 asm nop;

 return EEDATA;
}

void main() {
#line 37 "C:/Users/giljr/Documents/pic/unid_11_EEPROM/02_code/unid_11_2_eepromLib.c"
 TRISD = 0;
 PORTD = 0;
 EEPROM_Write_byte(0,0B1010101);
 Delay_ms(5);
 PORTD = EEPROM_Read_byte(0);
 while(1);

}
