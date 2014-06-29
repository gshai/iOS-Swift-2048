//
//  MainViewController.swift
//  Swift 2048
//
//  Created by Gilad Shai on 6/16/14.
//  Copyright (c) 2014 Gilad Shai. All rights reserved.
//

import UIKit


class MainViewController: UIViewController, GameDelegate, UIAlertViewDelegate {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Outlets
    @IBOutlet var restartButton: UIButton
    @IBOutlet var settingsButton: UIButton
    @IBOutlet var targetScoreLabel: UILabel
    @IBOutlet var subtitleLabel: UILabel
    @IBOutlet var scoreView: ScoreView
    @IBOutlet var bestView: ScoreView
    @IBOutlet var gridView : K2GridView
    
    var gameManager: K2GameManager = K2GameManager()
    
    // Override viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGame()
        self.setupView()
        self.gameManager.gameDelegate = self
        addGestures()
    }
    
    // Init Game
    func setupGame() {
        self.gameManager.resetGame()
    }
    
    // Init view
    func setupView() {
        
        // Load default theme
        let theme = DefaultTheme()
        
        // Set buttons
        self.restartButton.backgroundColor = theme.buttonColor()
        self.settingsButton.backgroundColor = theme.buttonColor()
        
        // Set score views
        self.scoreView.updateAppearance()
        self.scoreView.titleLabel.text = "Score"
        self.bestView.updateAppearance()
        self.bestView.titleLabel.text = "Best"        
    }
    
    // Clear Tiles From Playboard
    func clearTilesFromPlayboard() {
        self.gridView.clear()
    }
    
    // Button actions
    @IBAction func restartAction(sender : UIButton) {
        println("start game")
        self.startGame()
    }
    @IBAction func settingsAction(sender : UIButton) {
        println("tapped settings button")
        self.clearOldGame()
    }
    
    // Gestures
    func addGestures() {
        var swipeHandler = UISwipeGestureRecognizer(target: self, action: "gestureRecognizer:")
        swipeHandler.direction = .Right
        self.gridView.addGestureRecognizer(swipeHandler)
        
        swipeHandler = UISwipeGestureRecognizer(target: self, action: "gestureRecognizer:")
        swipeHandler.direction = .Left
        self.gridView.addGestureRecognizer(swipeHandler)

        swipeHandler = UISwipeGestureRecognizer(target: self, action: "gestureRecognizer:")
        swipeHandler.direction = .Up
        self.gridView.addGestureRecognizer(swipeHandler)
        
        swipeHandler = UISwipeGestureRecognizer(target: self, action: "gestureRecognizer:")
        swipeHandler.direction = .Down
        self.gridView.addGestureRecognizer(swipeHandler)
    }
    
    func gestureRecognizer(sender: UISwipeGestureRecognizer!) {
        
        gameManager.shiftTiles(sender.direction)
        
        
        self.gridView.endEditing(true)
    }
    
    
    // MARK: Game Play
    func clearOldGame() {
        // Clear old game (manager)
        self.gameManager.resetGame()
        
        // Clear old game (view)
        self.clearTilesFromPlayboard()
        
        // Enable user interaction
        gridView.userInteractionEnabled = true
    }
    
    func startGame() {
        // Clear old game
        self.clearOldGame()
        
        // Get first step
        self.gameManager.firstStep()
    }

    func gameOver() {
        println("GAME OVER")
        showOverlayWithFinalScore()
        gridView.userInteractionEnabled = false
    }

    func showOverlayWithFinalScore() {
        var alert:UIAlertView = UIAlertView()
        alert.title = "Game Over"
        alert.message = "Your score is "
        alert.delegate = self
        alert.addButtonWithTitle("Cancel")
        alert.addButtonWithTitle("Play Again")
        alert.show()
    }
    
    // Game Protocol
    func showNewTile(tile: K2Tile) {
        self.gridView.addTile(tile)
    }
    
    func refreshGridStatus(board: Dictionary<Int, K2Tile>) {
        
        let board = self.gameManager.giveMeTheBoard()
        let tiles = Array(board.values)
        self.gridView.animateTiles(tiles)
        
        // Next step
        self.gameManager.nextStep()
    }
    
    func increaseScore(points: Int) {
        self.scoreView.score += points
    }
    
    
    // UIAlert Protocol
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 0 :
            clearOldGame()
        case 1 :
            startGame()
        default :
            println()
        }
    }
}

