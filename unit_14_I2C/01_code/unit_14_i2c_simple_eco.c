/*
 * Project name:
     I2C_Simple (Simple test of I2C library routines)
     unit_14_i2c_simple_eco.c
 * Copyright:
     (c) Mikroelektronika, 2011.
 * Revision History:
     20191216:
       - initial release (J3);
 * Description:
     This program demonstrates usage of the I2C library routines. It
     establishes I2C bus communication with 24C02 EEPROM chip, writes one byte
     of data on some location, then reads it and displays it on PORTB.
     You don’t need to configure ports manually for using the module; 
     library will take care of the initialization.
 * Test configuration:
     MCU:             PIC18F45K22
                      http://ww1.microchip.com/downloads/en/DeviceDoc/40001412G.pdf
     Dev.Board:       EasyPIC7 - ac:Serial_EEPROM
                      http://www.mikroe.com/easypic/
     Oscillator:      HS-PLL 32.0000 MHz, 8.0000 MHz Crystal
     Ext. Modules:    None.
     SW:              mikroC PRO for PIC
                      http://www.mikroe.com/mikroc/pic/
 * NOTES(easyPIC v7):
     - Turn on I2C switches SW4.7 and SW4.8. (board specific)
     - Turn off PORTC LEDs (SW3.3). (board specific)
     - Turn on PORTA LEDs (SW3.1). (board specific)
     - Turn on PORTB LEDs (SW3.2). (board specific)
  * NOTES(EEPROM):
     - also written E2PROM is a type of non-volatile memory is a non-volatile memory;
     - used to store relatively small amounts of data that can allow individual bytes to be erased & reprogrammed;
     - This example use loops to write/read a EEPROM just for the demosntration purpose; in real app DO NOT USE while()!
 */



void test(char err){
  if(err == _I2C_TIMEOUT_RD)
    RD5_bit = 1;
  if(err == _I2C_TIMEOUT_WR)
    RD6_bit = 1;
}

void main(){
#ifdef P18F45K22
  //ANSELA = 0;                              // Configure PORTA pins as digital
  ANSELB = 0;                                // Configure PORTB pins as digital
  ANSELC = 0;                                // Configure PORTC pins as digital
#else
   ADCON1 |= 0X0F;
#endif

  TRISB = 0;                                 // Configure PORTB as output
  TRISD = 0;                                 // Configure PORTB as output
  LATB = 0;                                  // Clear PORTB
  LATD = 0;                                  // Clear PORTA


  I2C1_Init(100000);                         // initialize I2C communication

  while (1) {                                // loop for capture both packets

  I2C1_SetTimeoutCallback(1000,&test);       // enable error flag
  I2C1_Start();                              // issue I2C start signal

  I2C1_Wr(0xA2);                             // send byte via I2C  (device address + W)
  I2C1_Wr(2);                                // send byte (address of EEPROM location)

  I2C1_Wr(0xAA);                             // send data (data to be written) 0B10101010

  I2C1_Stop();                               // issue I2C stop signal

  Delay_100ms();

  I2C1_Start();                              // issue I2C start signal
  I2C1_Wr(0xA2);                             // send byte via I2C  (device address + W)
  I2C1_Wr(2);                                // send byte (data address)
  I2C1_Repeated_Start();                     // issue I2C signal repeated start
  I2C1_Wr(0xA3);                             // send byte (device address + R)
  LATB = I2C1_Rd(0);                         // Read the data (NO acknowledge)
  I2C1_Stop();                               // issue I2C stop signal
  
  Delay_ms(4000);
   }
}