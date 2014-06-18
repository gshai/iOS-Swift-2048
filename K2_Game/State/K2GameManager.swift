//
//  K2GameManager.swift
//  Swift 2048
//
//  Created by Gilad Shai on 6/17/14.
//  Copyright (c) 2014 Gilad Shai. All rights reserved.
//

import Foundation

class K2GameManager {
    var currentScore: Int = 0
    
    init () {
        println("init Game Manager")
        self.resetGame()
    }
    
    func resetGame () {
        self.currentScore = 0        
    }
}