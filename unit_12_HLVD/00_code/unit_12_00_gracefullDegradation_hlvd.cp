#line 1 "C:/Users/giljr/Documents/pic/unid_12_HLVD/00_code/unit_12_00_gracefullDegradation_hlvd.c"
#line 24 "C:/Users/giljr/Documents/pic/unid_12_HLVD/00_code/unit_12_00_gracefullDegradation_hlvd.c"
volatile unsigned int count = 0;

void INTERRUPCAO_HIGH() iv 0x0008 ics ICS_AUTO {
 if(HLVDIF_bit == 1)
 {
 EEPROM_Write(0, count);

 HLVDIF_bit = 0;
 }
}

void ConfigMCU()
{



 ADCON1 |= 0X0F;


 TRISD = 0;
 PORTD = 0;
}
void main() {
 ConfigMCU();
 count = EEPROM_Read(0);
 PORTD = count;
 GIEH_bit = 1;
 GIEL_bit = 1;
 IPEN_bit = 1;

 HLVDIF_bit = 0;
 HLVDIP_bit = 1;
 HLVDIE_bit = 1;
 HLVDCON = 0B00011110;







 Delay_ms(2000);
 while(1) {
 PORTD = count++;

 Delay_ms(1000);
 }
}
