//
//  TimeTrial.swift
//  Dots!
//
//  Created by Chris Gilardi on 5/21/15.
//  Copyright (c) 2015 Chris Gilardi. All rights reserved.
//

import Foundation
import SpriteKit

class TimeTrial : DBasicLevel{
    let TIME_INCREMENT = 20.0
    //gameTimer: NSTimer = NSTimer()
    var firstTouch = true
    var timeLeft: Int = 19
    let timeLeftLabel = SKLabelNode(text: "20")
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
       // gameTimer = NSTimer.scheduledTimerWithTimeInterval(TIME_INCREMENT, target:self, selector: Selector("endGame"), userInfo: nil, repeats: false)
        timeLeftLabel.position = CGPointMake(self.score.position.x, self.score.position.y - 40)
        timeLeftLabel.fontColor = SKColor.blackColor()
        timeLeftLabel.fontSize = 30
        

        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        if !ran{
            addChild(timeLeftLabel)
        }

        if firstTouch {
            let shownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("decTimer"), userInfo: nil, repeats: true)
            gameTimer = NSTimer.scheduledTimerWithTimeInterval(TIME_INCREMENT, target:self, selector: Selector("endGame"), userInfo: nil, repeats: false)
            firstTouch = false
        }


    }
    
    override func update(currentTime: CFTimeInterval) {
        super.update(currentTime)
        
    }
    
    func endGame(){
        var scene =  GameOver(size: self.size)
        scene.setMyScore(scoreCount)
        let skView = self.view!
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        scene.size = skView.bounds.size
        scene.setMessage("Time's Up!")
        skView.presentScene(scene)
    }
    
    func decTimer(){
        //timeLeftLabel.removeFromParent()
        timeLeftLabel.text = "\(timeLeft)"
        timeLeft--
        //self.addChild(timeLeftLabel)
    }
}
