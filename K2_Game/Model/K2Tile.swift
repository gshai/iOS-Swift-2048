//
//  K2Tile.swift
//  K2_Game
//
//  Created by Gilad Shai on 6/18/14.
//  Copyright (c) 2014 Gilad Shai. All rights reserved.
//

import UIKit

class K2Tile: UIView {
    
    var value:Int = 2
    var position = (0, 0)
    var valueLabel: UILabel!
    
    init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup label
        self.valueLabel = UILabel(frame: frame)
        self.valueLabel.text = String(value)
        self.valueLabel.textAlignment = NSTextAlignment.Center
        self.valueLabel.font = DefaultTheme().fontForTile()
        self.valueLabel.textColor = DefaultTheme().colorForTileText()
        self.addSubview(valueLabel)
        
        // Setup Background
        self.backgroundColor = DefaultTheme().colorForLevel(self.value)
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 65, height: 65))
    }
    
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
    }

    
    
}