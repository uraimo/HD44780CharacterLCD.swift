#if arch(arm) && os(Linux)
    //import SwiftyGPIO  //Uncomment this when using the package manager
    import Glibc
#else
    import Darwin //Needed for TravisCI
#endif
 

/// Class that represents the display being configured
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

    /**
     Moves the cursor and sets a character
     The only difference between the hd44780 charset and the standard
     ASCII is that the backslash is replaced by the yen symbol.

     If usCharSet is false, the alternative japanese charset with 
     katakana symbols will be used instead of the usual ASCII one.
    */    
    public func printString(x:Int, y:Int, what:String, usCharSet:bool){

    } 


}
