//
//  GameOver.swift
//  Dots!
//
//  Created by Chris Gilardi on 5/20/15.
//  Copyright (c) 2015 Chris Gilardi. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit

class GameOver : SKScene{
    private let restartButton: SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 100, height: 100))
    private let restartLabel: SKLabelNode = SKLabelNode()
    private let thisScore: SKLabelNode = SKLabelNode()
    private let highScore: SKLabelNode = SKLabelNode()
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    private var score = 0
    private var newHigh: Bool = false
    private let message = SKLabelNode()
    
    override func didMoveToView(view: SKView) {
        
        //Background Color
        self.backgroundColor = SKColor.redColor()
        
        //Change the button color based on score
        if(score <= 0){
            restartButton.fillColor = SKColor.redColor()
        }
        else if(score < 6){
            restartButton.fillColor = SKColor.yellowColor()
            restartLabel.fontColor = SKColor.blackColor()
        }
        else if(score >= 6 && score < 25){
            restartButton.fillColor = SKColor.orangeColor()
            restartLabel.fontColor = SKColor.whiteColor()
        }
        else if(score >= 25){
            restartButton.fillColor = SKColor.greenColor()
            restartLabel.fontColor = SKColor.blackColor()
        }
        restartButton.position = CGPointMake(CGRectGetMidX(self.frame) - 50, CGRectGetMidY(self.frame) - 50)
        self.addChild(restartButton)
        
        restartLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 20)
        restartLabel.text = String(score)
        restartLabel.fontSize = 40
        //restartLabel.fontColor = SKColor.whiteColor()
        self.addChild(restartLabel)
        
        //Add the new score and display it
        saveScore()
        highScore.text = getHighScore()
        highScore.position = CGPointMake(CGRectGetMidX(self.frame), 0)
        self.addChild(highScore)
        
        //Add the loss message
        message.position = CGPointMake(CGRectGetMidX(self.frame), 3*CGRectGetHeight(self.frame)/4)
        message.fontColor = SKColor.whiteColor()
        message.fontSize = 30
        self.addChild(message)
    }
    
    func setMyScore(score: Int){
        self.score = score
    }
    
    func saveScore(){
        if let highscore: AnyObject = userDefaults.valueForKey("highscore") {
            if Int((highscore as! Int)) < score {
                userDefaults.setValue(score, forKey: "highscore")
                userDefaults.synchronize() // don't forget this!!!!
                newHigh = true
            }
        }
        else {
            userDefaults.setValue(score, forKey: "highscore")
            userDefaults.synchronize() // don't forget this!!!!
        }

    }
    
    func getHighScore() -> String{
        if let highscore: AnyObject = userDefaults.valueForKey("highscore") {
            if(newHigh){
                newHigh = false
                return "New High Score! \(highscore)"

            }
            return "High Score: \(highscore)"
        }
        else {
            return "No High Score!"
        }
    }
    
    func setMessage(message: String){
        self.message.text = message
    }
}


