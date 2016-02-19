#HD44780CharacterLCD.swift

**IT DOES NOT WORK YET, COME BACK IN A FEW DAYS**

*A Swift library for 16x2(aka 1602A) or 20x4(aka 2004A) Character LCDs with an Hitachi HD44780 controller or one of its clones(KS0066, SPLC780D, ST7066U, NT8331D, etc...).*

<p>
<img src="https://img.shields.io/badge/os-linux-green.svg?style=flat" alt="Linux-only" />
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift2-compatible-4BC51D.svg?style=flat" alt="Swift 2 compatible" /></a>
<a href="https://raw.githubusercontent.com/uraimo/HD44780CharacterLCD.swift/master/LICENSE"><img src="http://img.shields.io/badge/license-BSD-blue.svg?style=flat" alt="License: BSD" /></a>
<a href="https://travis-ci.org/uraimo/HD44780CharacterLCD.swift"><img src="https://travis-ci.org/uraimo/HD44780CharacterLCD.swift.svg" alt="Travis CI"></a>
</p>
 
![LCD with Swift](https://raw.githubusercontent.com/uraimo/HD44780CharacterLCD.swift/master/imgs/lcd.jpg)


#Summary

A Swift library for 16x2(aka 1602A) or 20x4(aka 2004A) Character LCDs with an Hitachi HD44780 controller or one of its clones(KS0066, SPLC780D, ST7066U, NT8331D, etc... 99% of the controllers on the market).

This library will not work with LCDs connected with an additional I2C/SPI driver board (boards with just 5 pins instead of 16 or so). 

Also, the RGB backlight is not supported, it could be added in the future if someone is interested. 

## Supported Boards

Every board supported by [SwiftyGPIO](https://github.com/uraimo/SwiftyGPIO): Raspberries, BeagleBones, C.H.I.P., etc...

The example below will use a RaspberryPi2 board but you can easily modify the example to use one the the other supported boards.
 
## Installation

To use this library, you'll need a Linux ARM board with Swift 2.2.

Please refer to the [SwiftyGPIO](https://github.com/uraimo/SwiftyGPIO) readme for Swift installation instructions.

Once your board runs Swift, considering that at the moment the package manager is not available on ARM, you'll need to manually download the library and its dependencies: 

    wget https://raw.githubusercontent.com/uraimo/SwiftyGPIO/master/Sources/SwiftyGPIO.swift https://raw.githubusercontent.com/uraimo/5110lcd_pcd8544.swift/master/Sources/HD44780CharacterLCD.swift

Once downloaded, in the same directory create an additional file that will contain the code of your application (e.g. main.swift). 

When your code is ready, compile it with:

    swiftc SwiftyGPIO.swift HD44780CharacterLCD.swift main.swift

The compiler will create a **main** executable.
As everything interacting with GPIOs via sysfs, if you are not already root, you will need to run that binary with `sudo ./main`.

## Usage 


## Examples

Examples are available in the *Examples* directory.


## TODO

A few missing features (that you could help implement if interested):

- [ ] User defined characters not supported (see [here](http://www.quinapalus.com/hd44780udg.html))
- [ ] This library only write to the display, reading is not supported
- [ ] RGB backlit LCD variant not supported (can be easily implemented with 3 gpios)

