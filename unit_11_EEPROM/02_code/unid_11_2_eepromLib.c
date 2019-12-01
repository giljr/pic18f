void EEPROM_Write_byte(unsigned char address, unsigned char dta)
{
   char  STATUS_GIE  = 0;
   EEADR        = address;      // Where EEPROM lives
   EEDATA       = dta;          // Byte to be saved
   EECON1.EEPGD = 0;            // EEPROM memory pointer
   EECON1.CFGS  = 0;            // EEPROM access control
   EECON1.WREN  = 1;            // EEPROM enable
   STATUS_GIE = INTCON.GIEH;
   INTCON.GIEH = 0;
   EECON2 = 0x55;               // Writing procedures
   EECON2 = 0xAA;               // Writing must procedures
   EECON1.WR = 1;               // EEPROM effect
   while(EECON1.WR == 1);       // Wait procedure end
   INTCON.GIEH = STATUS_GIE;
   EECON1.WREN = 0;             // Desable writing

}

unsigned char EEPROM_Read_byte(unsigned char address)
{
  EEADR        = address;      // Where EEPROM lives
  EECON1.CFGS  = 0;            // EEPROM access control
  EECON1.EEPGD = 0;            // Aponta para a memória EEPROM
  EECON1.RD    = 1;            // EEPROM init
  asm nop;                     // 2 cycles recommended wait
  asm nop;                     // to read EEDATA

  return EEDATA;               // the result is at EEDATA
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