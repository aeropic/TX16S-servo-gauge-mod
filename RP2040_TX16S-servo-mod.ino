/* Copyright (c) 2023  Aeropic.

======================== haptic variometer for TX16S ============================
A LUA FUNCTION script is running on the radio. 
The script turns ON the RP2040 and sends over serial a formated servo command with an amplitude of +:-1000µsec.
The RP2040 moves a servo accordingly

The LUA script 
- manages all the stuff needed to compute the servo order with a range equivalent to full motion of the servo arm

The RP2040 clamps the values to 500-2500 µsec not to exceed servo mechanical limits
================================================================================


 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU AFFERO GENERAL PUBLIC LICENSE
 Version 3 as published by the Free Software Foundation; either
 or (at your option) any later version.
 It is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 General Public License for more details.

 */

extern "C" {
#include <hardware/watchdog.h>
};

//#define DEBUG  // uncomment to get debug prints on serial port

#include <Servo.h>

Servo myservo;  // create servo object to control a servo

float fangle = 0.0; // value received from the lua script is a string of a float
int angle = 1500; //  servo angle in µsec
int anglePrec = 1500; // previous servo angle



void setup(){
  Serial.begin(115200);
  delay(2000);
  Serial.println("In setup");

  // init serial1 on pins 0 and 1
  Serial1.setRX(1);
  Serial1.setTX(0);
  
  Serial1.setFIFOSize(128);
  Serial1.begin(115200);

  // initialize the servo on pin 29
  //servo.attach(broche, impuls_min, impuls_max);
     myservo.attach(29, 500,2500); 

  // set the watchdog to 0.5 sec     
  rp2040.wdt_begin(500);

}

void loop(){

 // Serial.println("In loop");

// clear the watchdog
  rp2040.wdt_reset();

// read data arriving from TX16S telemetry  via AUX1 port and manage them 
      String rxValue = "";
      char c;
      if (Serial1.available() > 0)
      {
        rxValue = Serial1.readStringUntil('\n');
      }

      String test = "";
      if (rxValue.length() > 0)
      {


        for (int i = 0; i < rxValue.length(); i++)
        {


          test = test + rxValue[i];
          
        }
#ifdef DEBUG
       
        Serial.print("Received : ");
        Serial.println(test);
#endif
        // convert the string to float
        char floatbuf[32]; // make this at least big enough for the whole string
        test.toCharArray(floatbuf, sizeof(floatbuf));
        fangle = atof(floatbuf);  // ATOF retourne zero si la chaine ne représente pas un float
        angle = int(fangle);
        
        
#ifdef DEBUG
Serial.print("angle : ");
      Serial.println(angle);
#endif
        
      } 
        int microsec = angle+1500; 
        //if (microsec > 2400) microsec = 2400;
        //if (microsec < 600) microsec = 600;

 #ifdef DEBUG
        Serial.print("microsec : ");
        Serial.println(microsec);
#endif
      if (angle != anglePrec) {
        

        // move the servo accordingly
        myservo.writeMicroseconds(microsec);
        anglePrec = angle;
      }       
 
    delay(3);
    
}
