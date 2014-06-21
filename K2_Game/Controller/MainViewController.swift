//
//  MainViewController.swift
//  Swift 2048
//
//  Created by Gilad Shai on 6/16/14.
//  Copyright (c) 2014 Gilad Shai. All rights reserved.
//

import UIKit


class MainViewController: UIViewController, GameDelegate {
    
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
        for aView:UIView! in self.gridView.subviews {
            if aView.isMemberOfClass(UIView) {
                UIView(aView.removeFromSuperview())
            }
        }
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
    }
    
    func startGame() {
        // Clear old game
        self.clearOldGame()
        
        // Get first step
        self.gameManager.firstStep()
    }

    
    // Game Protocol
    func showNewTile(tile: K2Tile) {
        self.gridView.addTile(tile)
    }
    
}

