//
//  K2GameManager.swift
//  Swift 2048
//
//  Created by Gilad Shai on 6/17/14.
//  Copyright (c) 2014 Gilad Shai. All rights reserved.
//

import UIKit

class K2GameManager {
    
    let numberOfSegments: Int = 4
    var currentScore: Int = 0
    var tiles: Array <K2Tile> = []
    var board: Dictionary<Int, K2Tile>  = [:]
    var gameDelegate: GameDelegate?

    init () {
        println("init Game Manager")
        self.resetGame()
//        self.setupGameGrid()
    }
    
    func setupGameGrid() {
        for row in 0..numberOfSegments {
            for column in 0..numberOfSegments {
                var tile: K2Tile = K2Tile()
                tile.position = (column, row)
                self.showNewTile(tile)
            }
        }
        
    }
    
    func resetGame () {
        self.currentScore = 0
        self.tiles.removeAll(keepCapacity: true)
        self.board = [:]
    }
    
    func firstStep () {
        
        // Create two tiles and locate them randomly
        var tile1: K2Tile = K2Tile()
        let column: Int = 1
        let row: Int = 1
        tile1.position = (column, row)
        tile1.setRandomValue()
        
        var tile2: K2Tile = K2Tile()
        tile2.position = (0, 2)
        tile2.setRandomValue()
        
        var tile3: K2Tile = K2Tile()
        tile3.position = (2, 2)
        tile3.value = Int(4)

        var tile4: K2Tile = K2Tile()
        tile4.position = (3, 2)
        tile4.value = Int(4)

        
        // Save the new tiles
        self.tiles.append(tile4)
        self.tiles.append(tile3)
        self.tiles.append(tile1)
        self.tiles.append(tile2)


        // Alert the VC
        self.showNewTile(tile1)
        self.showNewTile(tile2)
        self.showNewTile(tile3)
        self.showNewTile(tile4)
    }
    
    // MARK: Delegate Calls
    func showNewTile(tile: K2Tile) {
        gameDelegate?.showNewTile(tile)
    }


    // MARK: matrix calculations
    func shiftTiles(direction: UISwipeGestureRecognizerDirection) {
        switch direction {
            
        case UISwipeGestureRecognizerDirection.Right:
            
            // Loop over tiles in line
            var i = numberOfSegments - 1
            while i >= 0 {
                println("shift right line: \(i)")
                
                // Get row at index i
                let row = self.filterByRow(i)
                
                // If there are tiles in the row
                if row.count > 0 {
                    
                    // Shift the tile right
                    let sortedRow = sort(row, sorterByColumnACS)
                    for tile:K2Tile in sortedRow {
                        println("position: \(tile.position) value: \(tile.value)")
                        if self.canShiftTile(tile, row: sortedRow, direction:direction) {
                            
                        }
                    }
                }
                i--
            }
        case UISwipeGestureRecognizerDirection.Left:
            self.filterByRow(1)
        case UISwipeGestureRecognizerDirection.Up:
            self.filterByRow(2)
        case UISwipeGestureRecognizerDirection.Down:
            self.filterByRow(3)
        default:
            println("none")
        }

    }
    
    func canShiftTile(tile: K2Tile, row:Array<K2Tile>, direction:UISwipeGestureRecognizerDirection) -> Bool {
        if tile.position.1 == numberOfSegments {
            return false
        }
        
        if tile.position.1 < numberOfSegments {
            
        }
    }
    
    
    // MARK: helpers
    func sorterByColumnACS(this: K2Tile, that: K2Tile) -> Bool {
        return this.position.0 > that.position.0
    }
    func sorterByColumnDES(this: K2Tile, that: K2Tile) -> Bool {
        return this.position.0 < that.position.0
    }

    func sorterByRowACS(this: K2Tile, that: K2Tile) -> Bool {
        return this.position.1 > that.position.1
    }
    func sorterByRowDES(this: K2Tile, that: K2Tile) -> Bool {
        return this.position.1 < that.position.1
    }

    func filterByRow(row: Int) -> Array<K2Tile> {
        var filtered = self.tiles.filter {
            $0.position.1 == row
        }
        return filtered
    }
    func filterByColumn(column: Int) -> Array<K2Tile> {
        var filtered = self.tiles.filter {
            $0.position.0 == column
        }
        return filtered
    }

}

protocol GameDelegate {
    func showNewTile(tile: K2Tile)
}