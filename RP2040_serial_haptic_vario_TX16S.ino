/* Copyright (c) 2023  Aeropic.

======================== haptic variometer for TX16S ============================
A LUA FUNCTION script is running on the radio. 
The script turns ON the RP2040 and sends over serial a formated Vertical Speed.
The RP2040 moves a servo accordingly

The LUA script 
- manages a "dead zone" around low vertical speed
- multiplies the Vspeed expressed in cm/sec by a gain (typicaly 7x)
 (100 cm/sec with the gain of 7x is equivalent to full motion of the servo arm)

The RP2040 clamps the values to 800-2200 µsec not to exceed servo mechanical limits
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
     myservo.attach(29); 

  // set the watchdog to 1 sec     
  rp2040.wdt_begin(1000);

}

void loop(){

 // Serial.println("In loop");

// clear the watchdog
  rp2040.wdt_reset();

// read data arriving from TX16S telemetry de la TX16s via AUX1 port and manage them 
      String rxValue = "";
      char c;
      if (Serial1.available() > 0)
      {
        rxValue = Serial1.readStringUntil('\n');
      }

      String test = "";
      if (rxValue.length() > 0)
      {

#ifdef DEBUG
        Serial.print("Received : ");
#endif
        for (int i = 0; i < rxValue.length(); i++)
        {

#ifdef DEBUG
        Serial.print(rxValue[i]);
#endif
          test = test + rxValue[i];
          
        }
#ifdef DEBUG
        Serial.println();
        Serial.println(test);
#endif
        // convert the string to float
        char floatbuf[32]; // make this at least big enough for the whole string
        test.toCharArray(floatbuf, sizeof(floatbuf));
        fangle = atof(floatbuf);  // ATOF retourne zero si la chaine ne représente pas un float
        angle = int(fangle);
        
        
#ifdef DEBUG
      Serial.println(angle);
#endif
        
      } 

      if (angle != anglePrec) {
        int microsec = angle+1500+ 200*abs(angle)/angle;
        if (microsec > 2200) microsec = 2200;
        if (microsec < 800) microsec = 800;

        // move the servo accordingly
        myservo.writeMicroseconds(microsec);
        anglePrec = angle;
      }       
 
    delay(3);
    
}
