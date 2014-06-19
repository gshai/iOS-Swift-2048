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
    var tiles = K2Tile[]()
    var gameDelegate: GameDelegate?

    init () {
        println("init Game Manager")
        self.resetGame()
    }
    
    func resetGame () {
        self.currentScore = 0
        self.tiles.removeAll(keepCapacity: true)
    }
    
    func firstStep () {
        
        // Create two tiles and locate them randomly
        var tile1: K2Tile = K2Tile()
        let x: Int = 1
        let y: Int = 1
        tile1.position = (x, y)
        
        var tile2: K2Tile = K2Tile()
        tile2.position = (3, 2)
        
        // Alert the VC 
        self.showNewTile(tile1)
        self.showNewTile(tile2)
    }
    
    func showNewTile(tile: K2Tile) {
        gameDelegate?.showNewTile(tile)
    }
}

protocol GameDelegate {
    func showNewTile(tile: K2Tile)
}