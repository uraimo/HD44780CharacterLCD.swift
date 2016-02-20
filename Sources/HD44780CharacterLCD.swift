#if arch(arm) && os(Linux)
    //import SwiftyGPIO  //Uncomment this when using the package manager
    import Glibc
#else
    import Darwin //Needed for TravisCI
#endif
 

/**
 Class that represents the display being configured
 Keep in mind a few things about this implementation:

 * This library use the 4-bits mode of the controller
 * The r/w line is connected to GND, so only writes are possible

*/
public class HD44780LCD{
    var rs,e,d7,d6,d5,d4:GPIO
    let width,height:Int

    init(rs:GPIO,e:GPIO,
         d7:GPIO,d6:GPIO,d5:GPIO,d4:GPIO,
         width:Int,height:Int){
        self.rs=rs
        self.e=e
        self.d7=d7
        self.d6=d6
        self.d5=d5
        self.d4=d4
        self.width=width
        self.height=height
        self.rs.direction = .OUT
        self.e.direction = .OUT
        self.d7.direction = .OUT
        self.d6.direction = .OUT
        self.d5.direction = .OUT
        self.d4.direction = .OUT

    }

    private func initDisplay(){
        e.value = 0
        rs.value = 0
        d7.value = 1
        d6.value = 1
        d5.value = 1
        d4.value = 1

        //TODO: startup delay

        d7.value = 0
        d6.value = 0

        //TODO: delay 100ns
        e.value = 1
        //TODO: delay 500ns
        e.value = 0
        
        //TODO: delay 4000ns
        //Clock 1
        //TODO: delay 100ns
        e.value = 1
        //TODO: delay 500ns
        e.value = 0
        //Clock 2
        //TODO: delay 100ns
        e.value = 1
        //TODO: delay 500ns
        e.value = 0
        //TODO: delay 40ns   

        d4.value = 0
        //Clock 1
        //TODO: delay 100ns
        e.value = 1
        //TODO: delay 500ns
        e.value = 0
        //TODO: delay 40ns   
        //Clock 2
        //TODO: delay 100ns
        e.value = 1
        //TODO: delay 500ns
        e.value = 0
        //TODO: delay 40ns   
        //TODO: delay 500ns   
 
        if width > 1 {
            d7.value = 1
        }
        //Clock
        //TODO: delay 100ns
        e.value = 1
        //TODO: delay 500ns
        e.value = 0
        //TODO: delay 40ns   
 
        sendCommand(LCD_DISPLAYMODE)
        clearScreen()
        sendCommand(LCD_ENTRY_MODE|LCD_ENTRY_INC)
        sendCommand(LCD_DISPLAYMODE|LCD_DISPLAYMODE_ON)
    }

    /**
     Moves the cursor and sets a character
     The only difference between the hd44780 charset and the standard
     ASCII is that the backslash is replaced by the yen symbol.

     If usCharSet is false, the alternative japanese charset with 
     katakana symbols will be used instead of the usual ASCII one.
    */    
    public func printString(x:Int, y:Int, what:String, usCharSet:Bool){
        //TODO: guard position
        
        cursorTo(y*width+x)
        for scalar in what.unicodeScalars {
            let charId:UInt32 = usCharSet ? 0 : 128
            printChar(scalar.value+charId)
        }
    } 

    private func printChar(data:UInt32){
        guard (data>31)&&(data<255) else {
            return //Unprintable character
        }   
        lcdWrite(Int(data),rsvalue:1)
    }

    public func clearScreen(){
        sendCommand(1 << LCD_CLEAR)
    }

    public func cursorHome(){
        sendCommand(1 << LCD_HOME)
    }

    public func cursorTo(pos:Int){
        sendCommand((1 << LCD_DDRAM)+pos)
    }

    private func sendCommand(command:Int){
        lcdWrite(command,rsvalue:0)
    }

    private func lcdWrite(data:Int, rsvalue:Int){
        rs.value = rsvalue
                
        d7.value = data & 0b10000000
        d6.value = data & 0b01000000
        d5.value = data & 0b00100000
        d4.value = data & 0b00010000
        
        //TODO: Delay 100ns
        e.value = 1
        //TODO: Delay 500ns
        e.value = 0

        d7.value = data & 0b00001000
        d6.value = data & 0b00000100
        d5.value = data & 0b00000010
        d4.value = data & 0b00000001

        //TODO: Delay 100ns
        e.value = 1
        //TODO: Delay 500ns
        e.value = 0

        // Once the byte has been sent, reset to 1
        d7.value = 1
        d6.value = 1
        d5.value = 1
        d4.value = 1

        //Delay
        if ( (rsvalue == 0) && ((data==(1<<LCD_CLEAR))||(data==(1<<LCD_HOME))) ) {
            //Delay 1640ns
        }else{
            //Delay 40ns
        } 
    }

}


internal let LCD_CLEAR:Int = 0
internal let LCD_HOME:Int = 1

internal let LCD_ENTRY_MODE:Int = 2
internal let LCD_ENTRY_INC:Int = 1

internal let LCD_DISPLAYMODE:Int = 3
internal let LCD_DISPLAYMODE_ON:Int = 2

internal let LCD_DDRAM:Int = 7


