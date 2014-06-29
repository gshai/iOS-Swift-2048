//
//  K2Theme.swift
//  Swift 2048
//
//  Created by Gilad Shai on 6/16/14.
//  Copyright (c) 2014 Gilad Shai. All rights reserved.
//
//  Based on Danqing's code https://github.com/ik/2048.git

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
        switch (level) {
        case 1:
            return self.RGB(238, g: 228, b: 218)
        case 2:
            return self.RGB(237, g: 224, b: 200);
        case 4:
            return self.RGB(242, g: 177, b: 121);
        case 8:
            return self.RGB(245, g: 149, b: 99);
        case 16:
            return self.RGB(246, g: 124, b: 95);
        case 32:
            return self.RGB(246, g: 94, b: 59);
        case 64:
            return self.RGB(237, g: 207, b: 114);
        case 128:
            return self.RGB(237, g: 204, b: 97);
        case 256:
            return self.RGB(237, g: 200, b: 80);
        case 512:
            return self.RGB(237, g: 197, b: 63);
        case 1024:
            return self.RGB(237, g: 194, b: 46);
        case 2048:
            return self.RGB(173, g: 183, b: 119);
        default:
            return self.RGB(161, g: 183, b: 63);
        }
        
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
