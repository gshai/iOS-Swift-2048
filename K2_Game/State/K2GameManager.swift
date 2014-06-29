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
        //testTiles()
        for _ in 0..2 {
            if !createNewTile() {
                println("GameOver")
                gameDelegate?.gameOver()
            }
        }
    }
    
    func testTiles() {
        var tile: K2Tile = K2Tile()
        tile.position = (0, 0)
        tile.value = 2
        
        var tile1: K2Tile = K2Tile()
        tile1.position = (0, 2)
        tile1.value = 1

        var tile2: K2Tile = K2Tile()
        tile2.position = (0, 3)
        tile2.value = 2

        board[tile.position.0*numberOfSegments + tile.position.1] = tile
        board[tile1.position.0*numberOfSegments + tile1.position.1] = tile1
        board[tile2.position.0*numberOfSegments + tile2.position.1] = tile2
        
        self.showNewTile(tile)
        self.showNewTile(tile1)
        self.showNewTile(tile2)
    }
    
    
    func createNewTile() -> Bool {
        
        // Locate a position for the new tile
        let position = randomEmptyCellPosition()
        if position == nil {
            return false
        }
        
        // Create tile
        var tile: K2Tile = K2Tile()
        tile.position = position!
        tile.setRandomValue()
        let index = tile.position.0*numberOfSegments + tile.position.1
        self.board[index] = tile
        
        // Alert VC (delegate)
        self.showNewTile(tile)
        
        return true
    }
    
    func nextStep() {
        if !createNewTile() {
            if !canUserMergeTiles() {
                println("game over")
                gameDelegate?.gameOver()
            }
        }
    }
    
    // MARK: Delegate Calls
    func showNewTile(tile: K2Tile) {
        gameDelegate?.showNewTile(tile)
    }

    func refreshGridStatus(board: Dictionary<Int, K2Tile>) {
        gameDelegate?.refreshGridStatus(self.board)
    }

    func increaseScore(points: Int) {
        gameDelegate?.increaseScore(points)
    }
    
    
    // MARK: matrix calculations
    func shiftTiles(direction: UISwipeGestureRecognizerDirection) {
        
        var isBoardStatusChanged: Bool = false
        var scoreForCurrentRound: Int = 0
        
        // function to handle the tiles' shift
        func calculateNewTilesPosition(tileIndex: Int, dI: Int, endOfRowIndex: Int ) -> Bool {
            
            // Reached the end of the row
            if tileIndex == endOfRowIndex {
                return false
            }
            
            // Empty cell
            if self.board[tileIndex] == nil {
                return false
            }
            
            var shiftedTiles: Bool = false
            
            // Bubble up valid tile
            if self.board[tileIndex] {
                var tile: K2Tile! = board[tileIndex]
                let tileValue: Int? = tile?.value
                
                // Bubble up
                var i: Int = tileIndex-dI
                while i != endOfRowIndex-dI && i >= 0 && i < numberOfSegments*numberOfSegments{
                    
                    // Adjusent tile
                    var nextTile: K2Tile? = board[i]
                    let nextValue = nextTile?.value
                    let merged: Bool! = nextTile?.needsMerge
                    
                    // If the cell is empty move tile to new location
                    if nextTile == nil {
                        tile.position = (self.rowFromIndex(i), self.columnFromIndex(i))
                        self.board[i] = tile
                        self.board[i+dI] = nil
                        shiftedTiles = true
                        
                    // If the cell has value check if we can merge
                    } else if tileValue == nextValue  {
                        if !merged {
                            tile.needsMerge = true
                            tile.position = (self.rowFromIndex(i), self.columnFromIndex(i))
                            self.board[i] = tile
                            self.board[i+dI] = nil
                            shiftedTiles = true
                            scoreForCurrentRound += tile.value * 2
                        }
                        break
                    } else {
                        break
                    }
                    
                    // Increase of decrease base on the delta
                    i -= dI
                }
            }
            
            return shiftedTiles
        }
        
        // Shift tiles' position base on the direction
        switch direction {
        case UISwipeGestureRecognizerDirection.Right:
            
            // Loop over lines
            for row in 0..numberOfSegments {
                let endRowIndex = row*numberOfSegments + numberOfSegments - 1
                
                // Loop over tiles in a line from the end to the start
                for column in 0..numberOfSegments {
                    var tileIndex = row*numberOfSegments + (numberOfSegments - column - 1)
                    var dI = -1
                    if calculateNewTilesPosition(tileIndex, dI, endRowIndex) {
                        isBoardStatusChanged = true
                    }
                }
            }
            
        case UISwipeGestureRecognizerDirection.Left:
            
            // Loop over lines
            for row in 0..numberOfSegments {
                let endRowIndex = row*numberOfSegments
                
                // Loop over tiles in a line from the end to the start
                for var column:Int = numberOfSegments-1; column >= 0; column-- {
                    var tileIndex = row*numberOfSegments + (numberOfSegments - column - 1)
                    var dI = 1
                    if calculateNewTilesPosition(tileIndex, dI, endRowIndex) {
                        isBoardStatusChanged = true
                    }
                }
            }

        case UISwipeGestureRecognizerDirection.Up:
            
            // Loop over columns
            for column in 0..numberOfSegments {
                let endColumnIndex = column
                
                // Loop over tiles in a line from the end to the start
                for row in 0..numberOfSegments {
                    var tileIndex = row*numberOfSegments + (numberOfSegments - column - 1)
                    var dI = numberOfSegments
                    if calculateNewTilesPosition(tileIndex, dI, endColumnIndex) {
                        isBoardStatusChanged = true
                    }
                }
            }
            
        case UISwipeGestureRecognizerDirection.Down:
            
            // Loop over columns
            for column in 0..numberOfSegments {
                let endColumnIndex = numberOfSegments*(numberOfSegments-1) + column
                
                // Loop over tiles in a line from the end to the start
                for var row:Int = numberOfSegments-1; row >= 0; row-- {
                    var tileIndex = row*numberOfSegments + (numberOfSegments - column - 1)
                    var dI = -numberOfSegments
                    if calculateNewTilesPosition(tileIndex, dI, endColumnIndex) {
                        isBoardStatusChanged = true
                    }
                }
            }
            
        default:
            println("none")
        }
        
        // Update view
        if isBoardStatusChanged {
            refreshGridStatus(self.board)
            increaseScore(scoreForCurrentRound)
        }
        
        // debug print
        self.debugBoardPrint()
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
    func rowFromIndex(index: Int) -> (Int) {
        let row = index / numberOfSegments
        return row
    }
    
    func giveMeTheBoard() -> Dictionary<Int, K2Tile> {
        return self.board
    }
    
    func randomEmptyCellPosition() -> (Int, Int)? {
        
        // build array of empty cells
        var keys: Array<Int> = []
        for idx in 0..numberOfSegments*numberOfSegments {
            if board[idx] == nil {
                keys.append(idx)
            }
        }
        
        // if the board is full -> end the game
        if keys.count == 0 {
            return nil
        }
        
        // return position
        let n:Int = Int(arc4random_uniform(UInt32(keys.count)))
        let row = keys[n] / numberOfSegments
        let column = keys[n] % numberOfSegments
        return (row, column)
    }
    
    // Assume that the board is full
    func canUserMergeTiles() -> Bool {
        
        // TODO: There must be a better way
        let tiles:Array = Array(board.values)
        var set = NSMutableSet()
        for tile in tiles {
            set.addObject(tile.value)
        }
        println("set: \(set)")
        for value : AnyObject in set {
            println(value)
            let indexes = indicesForValue(Int(value as NSNumber))
            println("value: \(value) indexes \(indexes)")

            var i = 0
            while i + 1 < indexes.count {
                println(i)
                let delta = indexes[i] - indexes[i+1]
                let isSameLine = (indexes[i]/numberOfSegments == indexes[i+1]/numberOfSegments)
                let isNextLine = (indexes[i]/numberOfSegments - indexes[i+1]/numberOfSegments == 1)
                if (delta == 1 && isSameLine) || (delta == numberOfSegments && isNextLine) {
                    return true
                }
                i++
            }
            
        }
        
        return true
    }
    
    func indicesForValue(value: Int) -> Array<Int> {
        let tiles:Array = Array(board.values)
        var keys:Array = Array(board.keys)
        let filteredKeys = keys.filter({self.board[$0]!.value == value})
        return sort(filteredKeys, {$0 > $1})
    }
    
    func debugBoardPrint() {
        for row in 0..numberOfSegments {
            for column in 0..numberOfSegments {
                var i = row*numberOfSegments + column
                let n = board[i]?.value
                //println("row: \(row) column: \(column) value: \(n)")
            }
        }
    }
}

protocol GameDelegate {
    func showNewTile(tile: K2Tile)
    func refreshGridStatus(board: Dictionary<Int, K2Tile>)
    func increaseScore(points: Int)
    func gameOver()
}