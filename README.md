# RP2040-haptic-vario-TX16S
This project adds a servo inside the TX16S radio whose arm rotates according to the vertical speed telemetry

# hardware
a RP2040 zero microcontroler is connected to TX16S AUX1 port (GND,+5V,Tx) pins
the RP2040 drives a nano servo

pins used on RP2040 are:
- +5V
- GND
- 29 : connected to servo signal wire
- 1 : connected to AUX1 port Tx

![schema](https://github.com/aeropic/RP2040-haptic-vario-TX16S/assets/38628543/fffd0cc0-4c00-41d5-bf5b-a583fd1666bd)




# software
radio:  
from system menu, keep the AUX1 port unpowered
in the radio a very simple LUA script is placed inside the SCRIPTS/FUNCTIONS directory
- function "run" is activated by a switch from a SPECIAL FUNCTION in the radio. It does the following tasks:
  - activate the AUX1 port (switch ON 5V) which in turn switches ON the RP and the servo
  - periodically (by the EDGETX system) get the Vertical Speed value from telemetry, format it and push it on the serial port
  - The LUA script manages a "dead zone" around low vertical speed and multiplies the Vspeed expressed in cm/sec by a gain (typicaly 7x)
    (100 cm/sec with the gain of 7x is equivalent to full motion of the servo arm)
- function "background" is executed by the system when the switch associated to the SF is set to OFF. It does only:
  - switch OFF the AUX1 port which in turn switches OFF the RP and the servo

RP2040:  
it is programmed in the arduino IDE but if you're not familiar it is enough to unplug the RP2040, press and hold the boot button, plug the USB to a PC.
A directory will open in a window, just drag ad drop the .uf2 file which is the binary program.


    


