#ifndef _LIB_EEPROM_
#define _LIB_EEPROM_
void EEPROM_Write_byte(unsigned char address, unsigned char dta);
unsigned char EEPROM_Read_byte(unsigned char address);
void EEPROM_Write_int (unsigned char address, unsigned int dta);
unsigned int EEPROM_Read_int (unsigned int address);
void EEPROM_Write_float(unsigned char address,unsigned char *dta);
float EEPROM_Read_float(unsigned char address);
void EEPROM_Write_array (unsigned char address,        unsigned char qtd_byte,unsigned char *dta);
void EEPROM_Read_array  (unsigned char address, unsigned char qtd_byte,unsigned char *buffer);
#endif