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
 * The r/w line should be connected to GND, so only writes are possible

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
        initDisplay()
    }

    ///Initializes anc configures the screen
    private func initDisplay(){
        e.value = 1
        rs.value = 0
        d7.value = 1
        d6.value = 1
        d5.value = 1
        d4.value = 1

        //Startup delay
        usleep(15000)

        sendCommand(0x3) 
        usleep(1640)

        //4-bit mode
        sendCommand(0x2) 
        usleep(40)
 
        //Function set 001, BW, NumLines, Font, -, -
        // BW 0=8bit, 1=4bit
        // NumLines 0=1 line, 1= more than 1
        // Font 0=5x10, 1=5x8
        //
        sendCommand( 0x28 )
        sendCommand( (1<<LCD_DISPLAYMODE)|(1<<LCD_DISPLAYMODE_ON) )
        sendCommand( (1<<LCD_ENTRY_MODE)|(1<<LCD_ENTRY_INC) )
        cursorHome()
        clearScreen()
    }

    /**
     Moves the cursor and prints a string.

     The only difference between the hd44780 charset and the standard
     ASCII is that the backslash is replaced by the yen symbol.

     If usCharSet is false, the alternative japanese charset with 
     katakana symbols will be used instead of the usual ASCII one.
    */    
    public func printString(x:Int, y:Int, what:String, usCharSet:Bool){
        //TODO: guard position
        
        cursorTo(x,y:y)
        for scalar in what.unicodeScalars {
            let charId:UInt32 = usCharSet ? 0 : 160
            printChar(scalar.value+charId)
        }
    } 

    ///Clears the screen 
    public func clearScreen(){
        sendCommand(1 << LCD_CLEAR)
    }

    //Moves the cursor to 0,0
    public func cursorHome(){
        sendCommand(1 << LCD_HOME)
    }

    ///Moves the cursor to the specified position
    public func cursorTo(x:Int,y:Int){
        var pos = 0

        if height==4 {
            switch(y){
                case 1:
                    pos = 0x40 + y
                case 2:
                    pos = 0x14 + y
                case 3:
                    pos = 0x54 + y
                default:
                    pos = y
            }
        }else{
            pos = x * 0x40 + y
        }

        sendCommand((1 << LCD_DDRAM)+pos)
    }

 
    private func printChar(data:UInt32){
        guard (data>31)&&(data<255) else {
            return //Unprintable character
        }   
        lcdWrite(Int(data),rsvalue:1)
    }

    private func sendCommand(command:Int){
        lcdWrite(command,rsvalue:0)
    }

    private func lcdWrite(data:Int, rsvalue:Int){
        rs.value = rsvalue
                
        d7.value = (data & 0b10000000)==0 ? 0 : 1
        d6.value = (data & 0b01000000)==0 ? 0 : 1
        d5.value = (data & 0b00100000)==0 ? 0 : 1
        d4.value = (data & 0b00010000)==0 ? 0 : 1
        
        usleep(100)
        e.value = 1
        usleep(500)
        e.value = 0

        d7.value = (data & 0b00001000)==0 ? 0 : 1
        d6.value = (data & 0b00000100)==0 ? 0 : 1
        d5.value = (data & 0b00000010)==0 ? 0 : 1
        d4.value = (data & 0b00000001)==0 ? 0 : 1

        usleep(100)
        e.value = 1
        usleep(500)
        e.value = 0

        // Once the byte has been sent, reset to 1
        d7.value = 1
        d6.value = 1
        d5.value = 1
        d4.value = 1

        //Delay
        if ( (rsvalue == 0) && (data<=(1<<LCD_CLEAR)|(1<<LCD_HOME)) ) {
            usleep(1640)
        }else{
            usleep(40)
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


