# RP2040-haptic-vario-TX16S
This project adds a servo inside the TX16S radio whose arm rotates according to the vertical speed telemetry. No noise for neighbour pilots, no difficulties to hear the the vario bips when flying close to noisy engine planes...
Moreover, feeling thermal bubbles at the tip of your fingers is a nice experience...

![PXL_20230907_170501985](https://github.com/aeropic/RP2040-haptic-vario-TX16S/assets/38628543/29f0f15f-9e8a-4ae7-aeb4-d5ef539303eb)
![PXL_20230907_170528011](https://github.com/aeropic/RP2040-haptic-vario-TX16S/assets/38628543/1d0a6027-b88f-43a9-af0b-66a26adc17e5)


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

# mechanical integration

- a DIY AUX1 connector
  
  I did not want to solder anything to the radio, I therefore add to tinker a connector able to be connected from inside.
I use a 3 pins female connector housing. just enlarge the holes drilling them at 1.5 mm and trim the length so that the rubber door still closes...
For the male part, I use a 2mm pitch 3 pi,s connectors, the pins are really thin. Solder them at the tip of a servo wire.
Insert the female connector housing to the end from the outside then slide the 3 pins male connector into the housing from inside... Et voilà !
![PXL_20230907_165027998](https://github.com/aeropic/RP2040-haptic-vario-TX16S/assets/38628543/014c804d-60c7-40f2-a62d-13d8e95fe0da)
![PXL_20230907_165032128](https://github.com/aeropic/RP2040-haptic-vario-TX16S/assets/38628543/3a7223a1-6384-4ad9-9f62-f4b26f7630dc)
![PXL_20230907_165050653](https://github.com/aeropic/RP2040-haptic-vario-TX16S/assets/38628543/7addc534-e3c7-4128-83dd-469de3c63398)
![PXL_20230907_165146388](https://github.com/aeropic/RP2040-haptic-vario-TX16S/assets/38628543/6076db17-3d13-43a4-9bdd-c578b7c1287a)
![PXL_20230907_165245867](https://github.com/aeropic/RP2040-haptic-vario-TX16S/assets/38628543/f58997b4-8bc8-436a-bfc0-83e897bc4b68)

The required servo shall be as small as possible. This one is perfect (and cheap)

![servo](https://github.com/aeropic/RP2040-haptic-vario-TX16S/assets/38628543/aeb7727f-bd75-4891-9766-37899d9125ca)

I bought it on aliexpress here: https://fr.aliexpress.com/item/1005005192733613.html?spm=a2g0o.order_list.order_list_main.107.4b2f5e5bT9yK34&gatewayAdapt=glo2fra

Before connecting it to the AUX port I measured its current:
- 5 mA when idle
- 40 to 50 mA when rotating freely
- up to 200 mA when applying torque on the horn (strong torque...)
As the internal regulator driving both AUX ports is able to deliver up to 500mA, this is really safe.

To install it inside the radio I designed a 3D printed support :
link to Thingiverse
![PXL_20230907_125157019](https://github.com/aeropic/RP2040-haptic-vario-TX16S/assets/38628543/88cb4370-2907-450b-8b0e-303eadfd17a6)
![PXL_20230907_125146717](https://github.com/aeropic/RP2040-haptic-vario-TX16S/assets/38628543/6b705958-d559-4d83-887c-49705dda442e)

![PXL_20230907_125107323](https://github.com/aeropic/RP2040-haptic-vario-TX16S/assets/38628543/c2fad6e4-ae46-4ab5-9a44-53a52416d32f)

Just use the smallest servo horn...
As you can see on the first pictures it fits right into the button's hole of the MKII

# bottom line
This is a nice little project if you want to play with LUA, telemetry and some electronics.
You can use the same concept to do what you want with your servo such as rotating an antenna to keep it in sight of your bird (a GPS woulbe needed but the same logics will apply...)

Obviously connecting electronics to your beloved TX16S shall be done with care. Even if it works really well for me, I cannot be taken for responsible if you end frying your radio, do it at your own risks and enjoy!

