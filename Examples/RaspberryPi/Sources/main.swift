import SwiftyGPIO
import HD44780LCD


let gpios = SwiftyGPIO.GPIOs(for:.RaspberryPi2)
var rs = gpios[.P2]!
var e = gpios[.P3]!
var d4 = gpios[.P4]!
var d5 = gpios[.P17]!
var d6 = gpios[.P27]!
var d7 = gpios[.P22]!

let lcd = HD44780LCD(rs:rs,e:e,d7:d7,d6:d6,d5:d5,d4:d4,width:20,height:4)
lcd.clearScreen()
lcd.cursorHome()
lcd.printString(x:0,y:0,what:"Hello",usCharSet:true)
lcd.printString(x:1,y:1,what:"Hello From",usCharSet:true)
lcd.printString(x:2,y:2,what:"Hello From Swift",usCharSet:true)
lcd.printString(x:3,y:3,what:"Hello From Swift!",usCharSet:true)
