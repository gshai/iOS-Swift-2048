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
        
        // Set grid
//        self.gridView = K2GridView()
//        self.view.addSubview(self.gridView)
    }
    
    // Clear Tiles From Playboard
    func clearTilesFromPlayboard() {
        for aView in self.gridView.subviews {
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
    }
    
    
    // MARK: Game Play
    func startGame() {
        
        // Clear old game (manager)
        self.gameManager.resetGame()
        
        // Clear old game (view)
        self.clearTilesFromPlayboard()
        
        // Get first step
        self.gameManager.firstStep()
    }

    
    // Game Protocol
    func showNewTile(tile: K2Tile) {
        println("tile: /(tile)")
        
        self.gridView.addTile(tile)
    }
    
}

