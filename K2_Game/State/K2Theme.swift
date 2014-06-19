//
//  K2Theme.swift
//  Swift 2048
//
//  Created by Gilad Shai on 6/16/14.
//  Copyright (c) 2014 Gilad Shai. All rights reserved.
//

//let HEX(c)       [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]

import UIKit

class DefaultTheme: NSObject {
    
    func RGB(r: Int, g: Int, b: Int) -> UIColor {
        let color: UIColor = UIColor(red: Float(r)/255.0, green: Float(g)/255.0, blue: Float(b)/255.0, alpha: 1.0)
        return color
    }
    
    func RGBA(r: Int, g: Int, b: Int, a: Float) -> UIColor {
        let color: UIColor = UIColor(red: Float(r)/255.0, green: Float(g)/255.0, blue: Float(b)/255.0, alpha: a)
        return color
    }

    func colorForLevel(level: Int) -> UIColor {
        return self.RGB(238, g: 228, b: 218)
        /*
        switch (level) {
        case 1:
            return self.RGB(238, g: 228, b: 218)
        case 2:
            return self.RGB(237, g: 224, b: 200);
        case 3:
            return self.RGB(242, 177, 121);
        case 4:
            return self.RGB(245, 149, 99);
        case 5:
            return self.RGB(246, 124, 95);
        case 6:
            return self.RGB(246, 94, 59);
        case 7:
            return self.RGB(237, 207, 114);
        case 8:
            return self.RGB(237, 204, 97);
        case 9:
            return self.RGB(237, 200, 80);
        case 10:
            return self.RGB(237, 197, 63);
        case 11:
            return self.RGB(237, 194, 46);
        case 12:
            return self.RGB(173, 183, 119);
        case 13:
            return self.RGB(170, 183, 102);
        case 14:
            return self.RGB(164, 183, 79);
        case 15:
        default:
            return self.RGB(161, 183, 63);
        }
        */
    }

    
    func textColorForLevel(level: Int) -> UIColor {
        switch (level) {
        case 1:
            return self.RGB(110, g: 100, b: 110)
        case 2:
            return self.RGB(118, g: 109, b: 100)
        default:
            return UIColor.whiteColor()
        }
    }
    
    func backgroundColor() -> UIColor {
        return self.RGB(250, g: 248, b: 239)
    }

    func boardColor() -> UIColor {
        return self.RGB(204, g: 192, b: 179)
    }
    
    func scoreBoardColor() -> UIColor {
        return self.RGB(187, g: 173, b: 160)
    }
    
    
    func buttonColor() -> UIColor {
        return self.RGB(119, g: 110, b: 101)
    }
    
    
    func boldFontName() -> NSString {
        return "AvenirNext-DemiBold";
    }
    
    
    func regularFontName() -> NSString {
        return "AvenirNext-Regular"
    }
    
    func fontForTile() -> UIFont {
        return UIFont(name: self.boldFontName(), size: 32)
    }
    
    func colorForTileText() -> UIColor {
        return UIColor.whiteColor()
    }
}
