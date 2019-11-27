## pic18f Fun Factory Archieve
Hi, this is all about :tada:[PIC Microcontrollers - Programming in C](https://www.mikroe.com/ebooks/pic-microcontrollers-programming-in-c/the-basics-of-c-programming-language) , using [mikroc PRO for PIC compiler](https://www.mikroe.com/mikroc-pic) and pic Family F18.

You're more then welcome to visit my Web Pages: 

 [Jungletronics](https://medium.com/jungletronics) (Arduino, RPi, PIC, Eagle, Blender, Unity3D, Pixy, and more) 
 [KidsTronics](https://medium.com/kidstronics) (MIT App Inventor, LEGO, Arduino For Kids, and more)
 
And youtube playlists: [PIC Serie Enjoyment](https://www.youtube.com/playlist?list=PLK3PeNcUzb8TYBUxpC2Y9xaXN0wBSY2e0) or [PicAsm - Assembler Right Now!!!](https://www.youtube.com/playlist?list=PLK3PeNcUzb8TGekGLilHvHcUw2GUAEIjC) 

### Why PIC? :heart_eyes:
PIC (usually pronounced as "pick") is a family of microcontrollers made by [Microchip Technolog](https://en.wikipedia.org/wiki/Microchip_Technology).
In 2000, Microchip introduced the PIC18 architecture. it has proven to be very popular, with a large number of device variants presently in manufacture. C has become the predominant development language.


In this series I will bring to you how to code PIC pastile in C all from the beginning 'till advanced feature like interruptions;) 

Welcome!

**Hardware**:    Development Boards (OPTIONS):

  PicGenios:  Hardware: [Elect. Schema. & Layout](hardware/) & Board: [PICGENIOS]( https://loja.microgenios.com.br/produto/kit-picgenios-pic18f4520-com-gravador-usb-microicd-licen-a-compilador-mikroc-pro-for-pic/23507) & Chip: [PIC18F4520](https://www.microchip.com/wwwproducts/en/PIC18F4520),                   
 [EasyPIC™ v7](https://www.mikroe.com/easypic-v7)<- Chip: [PIC18F45k22](https://www.microchip.com/wwwproducts/en/PIC18F45K22) <- The code here works to this board too via preprocessor directives (plz help me to debug :D) or [EasyPIC™ v8](https://www.mikroe.com/easypic)* - Chip: [PIC18F47k42](https://www.microchip.com/wwwproducts/en/PIC18F47K42)
 (*) if you ask me for my recommendation, buy this one! not tested by J3, though :/ make do with what you have :)
 
**Compiler**: Compiler IDE:

[mikroC PRO for PIC](https://www.mikroe.com/mikroc-pic)

**Software**:    Development Programmer/Debugger:

  [Microchip’s PICkit™ 2](https://www.microchip.com/DevelopmentTools/ProductDetails/PartNO/PG164120)* -> [Download:]( http://ww1.microchip.com/downloads/en/DeviceDoc/PICkit%202%20v2.61.00%20Setup%20A.zip ) [Microchip’s PICkit™ 3](https://www.microchip.com/developmenttools/ProductDetails/PG164130) and the new [MPLAB PICkit™ 4](https://www.microchip.com/developmenttools/ProductDetails/PG164140) or								 
  [mikroProg suite for PIC]( https://www.mikroe.com/blog/mikroprog-suite-for-pic-version-2-3-1-released ) (*) used here therein!



### PIC Lessons: How to Start to Program PIC 18 - Step-by-step for Beginners! (2019) :ant:

##### **Unit - 01 - IOs**

[#01_code](unit_01_IO/01_code)#picSeries - [**Pic 18 Hello World \o/**](https://medium.com/jungletronics/pic-18-hello-world-o-f00275279cd0) - *Hello World to PIC 18 using mikroC Pro for PIC compiler*     

[#02_code](unit_01_IO/02_code)#picSeries - [**Pic 18 Push & Blink an LED**](https://medium.com/jungletronics/pic-18-push-blink-an-led-2e6745b3d0b4) - *How to setting a momentary button to blink an LED*     

[#03_code](unit_01_IO/03_code)#picSeries - [**PIC 18 Push & Debounce!**](https://medium.com/jungletronics/pic-18-push-debounce-6487ea8284b) - *How to deal with DEBOUNCE*     

[#04_code](unit_01_IO/04_code)#picSeries - [**PIC 18 Lighting LEDs In a Row!**](https://medium.com/jungletronics/pic-18-lighting-leds-in-a-row-d6d40b4e58d3) - *How to make a usefull lights' switch*    

[#05_code](unit_01_IO/05_code)#picSeries - [**PIC 18 Chasing LEDs**](https://medium.com/jungletronics/pic-18-chasing-leds-c86ba443e531) - *The net result is that LEDs seem to be chasing each other*    

[#06_code](unit_01_IO/06_code)#picSeries - [**PIC 18 Double Chasing LEDs**](https://medium.com/jungletronics/pic-18-double-chasing-8276d6a6886b) - *This code deals with bitwise operators o/*    

[#07_code](unit_01_IO/07_code)#picSeries - [**PIC 18 Ambulance Light LEDs**](https://medium.com/jungletronics/pic-18-ambulance-light-95e308d395e3x') - *Algorithm for ambulance-like-flashing-light*    

[#08_code](unit_01_IO/08_code)#picSeries - [**PIC 18 Random Flashing LEDs**](https://medium.com/jungletronics/pic-18-random-flashing-leds-287ce7d4bf7) - *How to generating a random number w/ seed*    

[#09_code](unit_01_IO/09_code)#picSeries - [**PIC 18 Internal Weak Pull-Ups**](https://medium.com/jungletronics/pic-18-internal-weak-pull-ups-d825e7991bad) - *How to activate weak-pull-ups-resistors on PIC18*    

[#10_code](unit_01_IO/10_code)#picSeries - [**PIC 18 Button Library**](https://medium.com/jungletronics/pic-18-button-library-9d32491b639e) - *How to use Button Library from mikroC PRO for PIC*    

[#11_code](unit_01_IO/11_code)#picSeries - [**PIC 18  Up Down Counter**](https://medium.com/jungletronics/pic-18-up-down-counter-11ce1bf7baab) - *A cool algorithm — making a counter  for PIC18F*    


##### **Unit - 02 - LCD**

[#00_code](unit_02_LCD/00_code)#picSeries - [**PIC 18  LCD Simulator**](https://medium.com/jungletronics/pic-18-lcd-intro-c9665f2d99f8) - *Know How Controller HD44780 Character LCD Displays works!*    

[#01_code](unit_02_LCD/01_code)#picSeries - [**PIC 18  LCD First Print on Screen**](https://medium.com/jungletronics/pic-lcd-first-print-9e3be6455df9) - *Let’s make our first print on LCD using PIC18F!*    

[#02_code](unit_02_LCD/02_code)#picSeries - [**PIC 18  LCD First Animation On Screen**](https://medium.com/jungletronics/pic-lcd-first-animation-45dfd9e7506b) - *Let’s make our first animation on LCD using PIC18F!*    

[#03_code](unit_02_LCD/03_code)#picSeries - [**PIC 18  LCD Key & Counter**](https://medium.com/jungletronics/pic-lcd-key-counter-5b0c6b9ca4b2) - *Press UP or Down key to(inc)decrement a counter-show at LCD*    

[#04_code](unit_02_LCD/04_code)#picSeries - [**PIC 18  LCD Custom Symbols**](https://medium.com/jungletronics/pic-lcd-custom-symbols-d46e30e53017) - *How to create a custom character on LCD for PIC18F*    

[#05_code](unit_02_LCD/05_code)#picSeries - [**PIC 18  LCD Digital Thermomether**](https://medium.com/jungletronics/pic-18-digital-thermometer-d20486bf16e4) - *Designing a Digital Thermometer w/ LM35 & PIC18F*    

[#06_code](unit_02_LCD/06_code)#picSeries - [**PIC 18  LCD Calculator**](https://medium.com/jungletronics/pic-18-lcd-calculator-7e84687d3621) - *How to set up a calculator using PIC18F*    

[#07_code](unit_02_LCD/07_code)#picSeries - [**PIC 18  LCD Keypad**](https://medium.com/jungletronics/pic-18-lcd-keypad-discovery-1fb7e71a5da0) - *How to set up a keypad using PIC18F*    

[#08_code](unit_02_LCD/08_code)#picSeries - [**PIC 18  LCD Menu**](https://medium.com/jungletronics/pic-18-lcd-menu-template-32f7693369f7) - *How to set up a LCD menu using PIC18F*    


##### **Unit - 03 - ADC**

[#01_code](unit_03_ADC/01_code)#picSeries - [**PIC 18  ADC INTRO**](https://medium.com/jungletronics/pic-18-adc-intro-ab9c1d630a98) - *Reading a tripot at AN0 without library w/ PIC18F*    




##### **Unit - 04 - TMR**

[#10_code](unit_04_TMR/10_code)#picSeries - [**PIC18F4520 - Timer0**](https://youtu.be/hI_gNCjo3G0) - *How to program TIMER0 to overflow at each 50ms - step-by-step*     






##### License

[![License: CC BY-NC-ND 3.0](https://img.shields.io/badge/License-CC%20BY--NC--ND%203.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/3.0/)
 