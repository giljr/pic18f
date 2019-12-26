/* Project: Unit 12 - HLVD
      Code: unit_12_01_helloWorldHLVD.c

   Objective:    This shows how HLVD works;)
                 Every time the power goes out we save the LEDs count in eeprom
                 and as soon as the power recovers, we retrieve the last count value 
                 and continue counting from the point we stopped counting. 
        
    Fuse Config Note: Go to Menu > Edit Project > Brown-on Reset > desabled
    Lib  Config Note: Enable EEPROM Lib at Library Manager Tab

      Author:   microgenios, edited by J3

   PIC Lessons: How to Start to Program PIC 18 - Step-by-step for Beginners!

   Hardware:    Development Boards (OPTIONS):
                   PicGenios:   PIC18F4520 chip   ( https://loja.microgenios.com.br/produto/kit-picgenios-pic18f4520-com-gravador-usb-microicd-licen-a-compilador-mikroc-pro-for-pic/23507 )
                   EasyPIC™ 7:  PIC18F45K22 chip  ( https://www.microchip.com/Developmenttools/ProductDetails/TMIK013 )
   Software:    Development Programmer/Debugger:
                                PICkit™ 2         ( http://ww1.microchip.com/downloads/en/DeviceDoc/PICkit%202%20v2.61.00%20Setup%20A.zip )
                          mikroProg suite for PIC ( https://www.mikroe.com/blog/mikroprog-suite-for-pic-version-2-3-1-released )

       Date:   Dec 2019
*/
volatile unsigned int count = 0;

void INTERRUPCAO_HIGH() iv 0x0008 ics ICS_AUTO {
 if(HLVDIF_bit == 1)
  {
     EEPROM_Write(0, count);              // Variable LED's state change count saved in eeprom at interruptions routine only :)
    
     HLVDIF_bit = 0;
  }
}

void ConfigMCU()
{
  #ifdef P18F45K22
  ANSELD = 0;
  #else
  ADCON1 |= 0X0F;
  #endif

  TRISD = 0;
  PORTD = 0;
}
void main() {
  ConfigMCU();
  count = EEPROM_Read(0);               // As soon as the power is back, read eeprom and save in PORTD
  PORTD = count;
  GIEH_bit = 1;                        // Enable high priority interruptions
  GIEL_bit = 1;
  IPEN_bit = 1;

  HLVDIF_bit = 0;                      // Config HLVD peripheral (clears flag, High priority, HLVD's INT enable)
  HLVDIP_bit = 1;
  HLVDIE_bit = 1;                      // See datasheet (pg.341) Table 26-4 for specifications: HLVD<7,6,5,4,3,2,1,0>
  HLVDCON = 0B00011110;                // Event occurs when voltage equals or falls below trip point HLVDL<7> = 0
                                       // Unimplemented: Read as ‘0’ HLVDL<6> = 0
                                       // Internal reference desable - use chip voltage; IRVST: Internal Reference Voltage Stable Flag bit HLVDL<5> = 0
                                       // HLVD enabled - HLVDEN: High/Low-Voltage Detect Power Enable bit HLVDL<4> = 1
                                       // HLVD Voltage on VDD Transition High-to-Low  HLVDL<3:0> = 1110 Min: 4.36 Typ: 4.59 Max: 4.82 V
                                       // VDIRMAG = 0; The trigged will happen on tension's drop (falls below trip point)
                                       // VDIRMAG = 1;
  
  Delay_ms(2000);                      // Delay for eeprom operation & system stabilization
  while(1) {
   PORTD = count++;
   //EEPROM_Write(0,(char)PORTD);      // At All LED's state change we'll save in eeprom the count variable
   Delay_ms(1000);                     // DO NOT MAKE IT IN PRODUCTION or you will decrease the life cycle or your eeprom :/
  }                                    // Use interruptions instead :)
}