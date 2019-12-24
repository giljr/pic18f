/* Project: Unit 15 - USB
      Code: unit_15_01_USB Intro.c

   Objective:    This program uses the Visual Basic language and mikroC Language 
                 to run an USB Bus Library Functions in a PIC18F4550 chip:)


      Author:   microgenios, edited by J3

   PIC Lessons: How to Start to Program PIC 18 - Step-by-step for Beginners!

   Hardware:    Development Boards (OPTIONS):
                   PicGenios:   PIC18F4520 chip   ( https://loja.microgenios.com.br/produto/kit-picgenios-pic18f4520-com-gravador-usb-microicd-licen-a-compilador-mikroc-pro-for-pic/23507 )
                   EasyPIC™ 7:  PIC18F45K22 chip  ( https://www.microchip.com/Developmenttools/ProductDetails/TMIK013 )
   Software:    Development Programmer/Debugger:
                                PICkit™ 2         ( http://ww1.microchip.com/downloads/en/DeviceDoc/PICkit%202%20v2.61.00%20Setup%20A.zip )
                          mikroProg suite for PIC ( https://www.mikroe.com/blog/mikroprog-suite-for-pic-version-2-3-1-released )

       Date:   Dez 2019
*/
unsigned char readbuff[64] absolute 0x500;   // Buffers should be in USB RAM, please consult datasheet
unsigned char writebuff[64] absolute 0x540;

char cnt;
char kk;

void interrupt(){
   USB_Interrupt_Proc();                   // USB servicing is done inside the interrupt
}

 unsigned char count = 0;
void main(void){
  ADCON1 |= 0x0F;                         // Configure all ports with analog function as digital
  CMCON  |= 7;                            // Disable comparators

  HID_Enable(&readbuff,&writebuff);       // Enable HID communication

  TRISD = 0;
  PORTD = 0;
  //PORTD.RD0 -> LED0

  while(1){
    if(HID_Read())
    {

     if(readbuff[0] == 10)
      {
         PORTD.RD0 = readbuff[1]; //inverter o led
         count++;
         writebuff[19] = 37;
         writebuff[20] = count;
         
         while(!HID_Write(&writebuff,64));

      }
      
      if(readbuff[5] == 10)
      {
         PORTD.RD1 = readbuff[6]; //inverter o led
         count++;
         writebuff[19] = 37;
         writebuff[20] = count;

         while(!HID_Write(&writebuff,64));

      }

    }

  }
}