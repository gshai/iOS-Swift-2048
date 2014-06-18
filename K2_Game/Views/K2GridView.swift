//
//  K2GridView.swift
//  Swift 2048
//
//  Created by Gilad Shai on 6/17/14.
//  Copyright (c) 2014 Gilad Shai. All rights reserved.
//

import UIKit

class K2GridView: UIView {
    
    let bordertWidth: Float = 4.0
    let edgeWidth: Float = 65.0
    let numberOfSegments: Int = 4
    
    init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 280, height: 280))
    }
    
    /** iOS8 must be */
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
        self.setupView()
    }

    func setupView() {
        let theme = DefaultTheme()
        
        // Background
        self.backgroundColor = theme.scoreBoardColor()
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
    }
    
    override func drawRect(rect: CGRect) {
        
        // Vertical lines
        var vPath: UIBezierPath = UIBezierPath()
        let color = UIColor.orangeColor()
        color.setStroke()
        
        let gridXStart: CGFloat = 2.5
        let gridYStart: CGFloat = 0.0
        let segmentWidth: CGFloat = Float(edgeWidth + bordertWidth)
        
        // Draw lines
        for i in 0...numberOfSegments {
            vPath.moveToPoint(CGPointMake(gridXStart + Float(i)*segmentWidth, 0))
            vPath.addLineToPoint(CGPointMake(gridXStart + Float(i)*segmentWidth, gridMaxHeight()))
            vPath.lineWidth = Float(bordertWidth)
            vPath.stroke()
        }
        
        // Vertical lines
        var hPath: UIBezierPath = UIBezierPath()
        color.setStroke()
        
        // Draw lines
        for i in 0...numberOfSegments {
            hPath.moveToPoint(CGPointMake(0, gridXStart + Float(i)*segmentWidth))
            hPath.addLineToPoint(CGPointMake(gridMaxHeight(), gridXStart + Float(i)*segmentWidth))
            hPath.lineWidth = Float(bordertWidth)
            hPath.stroke()
        }

    }
    
    func gridMaxHeight() -> Float {
        let height: Float = Float(numberOfSegments+1) * bordertWidth + Float(numberOfSegments) * edgeWidth
        return height
    }
    
}


