#line 1 "C:/Users/Microgenios/Desktop/Curso USB/Projetos USB/01_PROJETO_LED/main.c"
unsigned char readbuff[64] absolute 0x500;
unsigned char writebuff[64] absolute 0x540;

char cnt;
char kk;

void interrupt(){
 USB_Interrupt_Proc();
}

 unsigned char count = 0;
void main(void){
 ADCON1 |= 0x0F;
 CMCON |= 7;

 HID_Enable(&readbuff,&writebuff);

 TRISD = 0;
 PORTD = 0;


 while(1){
 if(HID_Read())
 {

 if(readbuff[0] == 10)
 {
 PORTD.RD0 = readbuff[1];
 count++;
 writebuff[19] = 37;
 writebuff[20] = count;

 while(!HID_Write(&writebuff,64));

 }

 if(readbuff[5] == 10)
 {
 PORTD.RD1 = readbuff[6];
 count++;
 writebuff[19] = 37;
 writebuff[20] = count;

 while(!HID_Write(&writebuff,64));

 }

 }


 }
}
