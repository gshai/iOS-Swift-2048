//
//  K2Tile.swift
//  K2_Game
//
//  Created by Gilad Shai on 6/18/14.
//  Copyright (c) 2014 Gilad Shai. All rights reserved.
//

import UIKit

class K2Tile: UIView {
    
    var valueLabel: UILabel!
    var value: Int = 0
    {
        willSet {
            valueLabel.text = String(newValue)
            self.backgroundColor = DefaultTheme().colorForLevel(newValue)
        }
    }
    var position = (0, 0)
    var needsMerge: Bool = false
    
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
        self.backgroundColor = DefaultTheme().colorForLevel(value)
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 65, height: 65))
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    func setRandomValue() {
        let x: Int = Int(arc4random_uniform(2))
        self.value = x+1
        
        // TODO: place this is the setter of self.value
    }
    
}