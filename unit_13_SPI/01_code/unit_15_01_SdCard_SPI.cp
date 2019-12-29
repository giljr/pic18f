#line 1 "C:/Users/giljr/Documents/pic/unit_13_SPI/01_code/unit_15_01_SdCard_SPI.c"
#line 27 "C:/Users/giljr/Documents/pic/unit_13_SPI/01_code/unit_15_01_SdCard_SPI.c"
sbit Mmc_Chip_Select at LATC2_bit;
sbit Mmc_Chip_Select_Direction at TRISC2_bit;





char filename[] = "MYFILE55.TXT";
unsigned char txt[] = "This is the added data...";
unsigned short character;
unsigned long file_size,i;

void main()
{
 unsigned char fhandle;




 ADCON1 |= 0X0F;



 TRISD = 0;
 PORTD = 0;


SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);





 fhandle = MMc_Fat_Open(&filename, 0x02 ,0x80);

 Mmc_Fat_Rewrite();
 Mmc_Fat_Write("This is MYFILE.TXT.",19);
 Mmc_Fat_Append();
 Mmc_Fat_Write(txt,sizeof(txt));
 Mmc_Fat_Close();

 while(1)
 {
 PORTD.RD0 = 1;
 Delay_ms(300);
 PORTD.RD0 = 0;
 Delay_ms(300);
 }
}
