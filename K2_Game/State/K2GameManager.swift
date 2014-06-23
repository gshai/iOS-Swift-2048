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
    var board: Dictionary<Int, K2Tile>  = [:]
    var gameDelegate: GameDelegate?

    init () {
        self.resetGame()
    }
    
    func resetGame () {
        self.currentScore = 0
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
        tile2.position = (2, 0)
        tile2.value = Int(5)
        
        var tile3: K2Tile = K2Tile()
        tile3.position = (2, 2)
        tile3.value = Int(4)

        var tile4: K2Tile = K2Tile()
        tile4.position = (2, 3)
        tile4.value = Int(4)

        
        // Save the new tiles
        self.board[tile1.position.0*numberOfSegments + tile1.position.1] = tile1
        self.board[tile2.position.0*numberOfSegments + tile2.position.1] = tile2
        self.board[tile3.position.0*numberOfSegments + tile3.position.1] = tile3
        self.board[tile4.position.0*numberOfSegments + tile4.position.1] = tile4


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

    func refreshGridStatus(board: Dictionary<Int, K2Tile>) {
        gameDelegate?.refreshGridStatus(self.board)
    }

    // MARK: matrix calculations
    func shiftTiles(direction: UISwipeGestureRecognizerDirection) {
        switch direction {
        case UISwipeGestureRecognizerDirection.Right:
            
            // Loop over lines
            for row in 0..numberOfSegments {
                let endRowIndex = row*numberOfSegments + numberOfSegments - 1
                
                // Loop over tiles in a line from the end to the start
                for column in 0..numberOfSegments {
                    var tileIndex = row*numberOfSegments + (numberOfSegments - column - 1)
                    
                    // Reached the end of the row
                    if tileIndex == endRowIndex {
                        continue
                    }
                    
                    // Empty cell
                    if self.board[tileIndex] == nil {
                        continue
                    }
                    
                    // Bubble up valid tile
                    if self.board[tileIndex] {
                        var tile: K2Tile! = board[tileIndex]
                        let tileValue: Int? = tile?.value
                        println("processing tile at index: \(tileIndex) with value: \(tileValue)")
                        
                        // Bubble up
                        for i in tileIndex+1...endRowIndex {
                            
                            // Adjusent tile
                            var nextTile: K2Tile? = board[i]
                            let nextValue = nextTile?.value
                            let merged: Bool! = nextTile?.needsMerge
                            
                            
                            // If the cell is empty move tile to new location
                            if nextTile == nil {
                                tile.position = (row, self.columnFromIndex(i))
                                self.board[i] = tile
                                self.board[i-1] = nil
                                println("new tile location: \(self.board[i]?.position)")
                                
                            // If the cell has value check if we can merge
                            } else if tileValue == nextValue  {
                                if !merged {
                                    tile.needsMerge = true
                                    tile.value = tile.value * 2
                                    tile.position = (row, self.columnFromIndex(i))
                                    self.board[i] = tile
                                    self.board[i-1] = nil
                                    println("new tile location with merge: \(self.board[i]?.position) \(self.board[i]?.value)")
                                }
                            }
                        }
                    }
                }
            }
        default:
            println("none")
        }
        
        // debug print
        for row in 0..numberOfSegments {
            for column in 0..numberOfSegments {
                var i = row*numberOfSegments + column
                let n = board[i]?.value
            }
        }
        
        // Update view
        self.refreshGridStatus(self.board)
    }
    
    func canShiftTile(tile: K2Tile, row:Array<K2Tile>, direction:UISwipeGestureRecognizerDirection) -> Bool {
        if tile.position.1 == numberOfSegments {
            return false
        }
        
        if tile.position.1 < numberOfSegments {
            
        }
        return false
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

    func columnFromIndex(index: Int) -> (Int) {
        let column = index % numberOfSegments
        return column
    }
    
    func giveMeTheBoard() -> Dictionary<Int, K2Tile> {
        return self.board
    }
}

protocol GameDelegate {
    func showNewTile(tile: K2Tile)
    func refreshGridStatus(board: Dictionary<Int, K2Tile>)
}