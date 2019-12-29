/* Project Name: SD CARD PROJECT - WRITE TEXT TO A FILE
           File:  unit_13_01_sdcarrD_SPI.c
    
    Description: The program creates a new file called MYFILE55.TXT on the SD card and writes the text
                 "This is MYFILE.TXT." to the file. Then the string "This is the added data..."
                 is appended to the file. 
                 
         Author: Dogan Ibrahim Date: October 2013 File: MIKROC-SD1.C
           
      LIBS Note: SD cards (and also MultiMedia Cards, MMC) - Got To Library Manage and enable these libs:
                 > SPI
                 > MMC
                 > MMC - FAT16
                 > MMC - FAT16 - CONFIG
                 > CONVERSIONS
                 > C - STDLIB
                 > C - STRING
                 > C - TYPE
                 
    Connections: In this project an SD card is connected to PORT C as follows:
                 CS RC2
                 CLK RC3
                 DO RC4
                 DI RC5
*/
                                               // MMC module connections
sbit Mmc_Chip_Select at LATC2_bit;
sbit Mmc_Chip_Select_Direction at TRISC2_bit;

                                               // MMC module connections
#define FILE_READ 0x01                         // read only
#define FILE_WRITE 0x02                        // write only
#define FILE_APPEND 0x04                       // append to file
char filename[] = "MYFILE55.TXT";
unsigned char txt[] = "This is the added data...";
unsigned short character;
unsigned long file_size,i;

void main() 
{
   unsigned char fhandle;
   
#ifdef PIC18F45K22                             // For PIC18F4520
       ANSELC = 0;                             // Configure PORTC as digital
#else                                          // For PIC18F45K22
       ADCON1 |= 0X0F;                         // Config all ADC's pins as digital
#endif

  // LEDs on PORTD RD0
  TRISD = 0;                                   // Config all PORTD's pins as Output (0=0:)
  PORTD = 0;                                   // Config all PORTD's pins as LOW,
                                               // then all LEDs attached to it will be OFF;)
                                               // Inialise the SPI bus
SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);


                                               // Inialize the Mmc library. Wait unl card detected
    while(Mmc_Fat_Init());
                                               // Create new file (if it does not exist)
    fhandle = MMc_Fat_Open(&filename,FILE_WRITE,0x80);
                                               // Clear the file, start at the beginning for wring
    Mmc_Fat_Rewrite();                         //Write to the file, specifying the length of the text
    Mmc_Fat_Write("This is MYFILE.TXT.",19);   // Add more data to the end...
    Mmc_Fat_Append();
    Mmc_Fat_Write(txt,sizeof(txt));            // Now close the file (releases the handle) //
    Mmc_Fat_Close();
 
  while(1)                                    // Wait here forever
  {
         PORTD.RD0 = 1;                       // Turn LED on
         Delay_ms(300);                       // delay 300 ms
         PORTD.RD0 = 0;                       // Turn LED off
         Delay_ms(300);                       // delay 300 ms
  }
}