void EEPROM_Write_byte(unsigned char address, unsigned char dta)
{
   char  STATUS_GIE  = 0;
   EEADR        = address;  // Address to be read
   EEDATA       = dta;      // Byte to print
   EECON1.EEPGD = 0;        // EEPROM memory pointer
   EECON1.CFGS  = 0;        // EEPROM Control access
   EECON1.WREN  = 1;        // EEPROM enable
   STATUS_GIE = INTCON.GIEH;
   INTCON.GIEH = 0;
   EECON2 = 0x55;           // Must procedure
   EECON2 = 0xAA;           // Must procedure to write
   EECON1.WR = 1;           // Make the register
   while(EECON1.WR == 1);   // Wait operation end
   INTCON.GIEH = STATUS_GIE;
   EECON1.WREN = 0;         // Unable record

}

unsigned char EEPROM_Read_byte(unsigned char address)
{
  EEADR        = address;   // Address to be read
  EECON1.CFGS  = 0;         // EEPROM Control access
  EECON1.EEPGD = 0;         // EEPROM memory pointer
  EECON1.RD    = 1;         // Begiin EEPROM read
  asm nop;                  // 2 cycles wait
  asm nop;                  // before read

  return EEDATA;            // the value is available
}

void main() {

#ifdef P18F45K22
  ANSELD = 0;
#endif
  TRISD = 0;
  PORTD = 0;
  EEPROM_Write_byte(0,0B1010101);
  Delay_ms(5);
  PORTD = EEPROM_Read_byte(0);
  while(1);

}