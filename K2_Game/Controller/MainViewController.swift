//
//  MainViewController.swift
//  Swift 2048
//
//  Created by Gilad Shai on 6/16/14.
//  Copyright (c) 2014 Gilad Shai. All rights reserved.
//

import Foundation
import SpriteKit


class MainViewController: UIViewController {
    
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
    @IBOutlet var gridView : UIView
    
    var gameManager: K2GameManager = K2GameManager()
    
    // Override viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGame()
        self.setupView()
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
        let grid: K2GridView = K2GridView()
        self.gridView.addSubview(grid)
    }
    
    
    func startGame() {
        
        // Clear old game
        self.gameManager.resetGame()
        
        // Configure the view.
        let skView: SKView = self.view as SKView
    }
    
    
    // Button actions
    @IBAction func restartAction(sender : UIButton) {
        println("tapped button")
    }
    @IBAction func settingsAction(sender : UIButton) {
        println("tapped settings button")
    }
}

