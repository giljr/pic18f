#line 1 "C:/Users/giljr/Documents/pic/unid_11_EEPROM/02_code/lib_eeprom.c"
#line 1 "c:/users/giljr/documents/pic/unid_11_eeprom/02_code/lib_eeprom.h"


void EEPROM_Write_byte(unsigned char address, unsigned char dta);
unsigned char EEPROM_Read_byte(unsigned char address);
void EEPROM_Write_int (unsigned char address, unsigned int dta);
unsigned int EEPROM_Read_int (unsigned int address);
void EEPROM_Write_float(unsigned char address,unsigned char *dta);
float EEPROM_Read_float(unsigned char address);
void EEPROM_Write_array (unsigned char address, unsigned char qtd_byte,unsigned char *dta);
void EEPROM_Read_array (unsigned char address, unsigned char qtd_byte,unsigned char *buffer);
#line 3 "C:/Users/giljr/Documents/pic/unid_11_EEPROM/02_code/lib_eeprom.c"
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

void EEPROM_Write_int (unsigned char address, unsigned int dta)
{
 EEPROM_Write_byte(address + 0, (char)dta);
 EEPROM_Write_byte(address + 1, (char)(dta>>8));
}

unsigned int EEPROM_Read_int (unsigned int address)
{
 unsigned char _val1, _val2;
 _val1 = EEPROM_Read_byte(address + 0);
 _val2 = EEPROM_Read_byte(address + 1);
 return ((_val1 << 8)| (int)_val2);

}


void EEPROM_Write_array (unsigned char address, unsigned char qtd_byte,unsigned char *dta)
{
 char _i;
 for(_i = 0; _i < qtd_byte; ++_i)
 {
 EEPROM_Write_byte(address+_i, *dta);
 ++dta;
 }

}


void EEPROM_Read_array (unsigned char address, unsigned char qtd_byte,unsigned char *buffer)
{
 char _i;
 for(_i = 0; _i < qtd_byte; ++_i)
 {
 *buffer = EEPROM_Read_byte(address+_i);
 ++buffer;
 }
}


void EEPROM_Write_float(unsigned char address,unsigned char *dta)
{
 EEPROM_Write_array(address, 4, &dta);
}

float EEPROM_Read_float(unsigned char address)
{
 union Result{
 unsigned char _res[4];
 float _t;
 } result;

 result._res[0] = EEPROM_Read_byte(address+0);
 result._res[1] = EEPROM_Read_byte(address+1);
 result._res[2] = EEPROM_Read_byte(address+2);
 result._res[3] = EEPROM_Read_byte(address+3);
 return result._t;
}
