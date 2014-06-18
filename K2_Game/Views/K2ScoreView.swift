//
//  ScoreView.swift
//  Swift 2048
//
//  Created by Gilad Shai on 6/16/14.
//  Copyright (c) 2014 Gilad Shai. All rights reserved.
//

import UIKit
import QuartzCore

//@IBDesignable

class ScoreView: UIView {
    
    @IBOutlet var scoreLabel: UILabel
    @IBOutlet var titleLabel: UILabel
    
    
    init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    // iOS8 must be
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
    }
    
    // Update appearance func (font, color)
    func updateAppearance() {
        println("updateAppearance")
        let theme = DefaultTheme()
        self.layer.cornerRadius = 2
        self.layer.masksToBounds = true
        self.scoreLabel.font = UIFont(name: theme.boldFontName(), size: 12)
        self.titleLabel.font = UIFont(name: theme.regularFontName(), size: 16)
        self.scoreLabel.text = "0"
        self.titleLabel.text = "Score"
    }
}

