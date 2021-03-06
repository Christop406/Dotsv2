//
//  GameScene.swift
//  Dots!
//
//  Created by Chris Gilardi on 5/17/15.
//  Copyright (c) 2015 Chris Gilardi. All rights reserved.
//

import SpriteKit
import Foundation
import iAd

class GameScene: SKScene {

    override func didMoveToView(view: SKView) {
        self.backgroundColor = SKColor.whiteColor()
        let timer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: "presentMenu", userInfo: nil, repeats: false)
        
        //TODO: Make "Dots!" Logo
        
        let loadingLabel = SKLabelNode(text: "Dots!")
        loadingLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        loadingLabel.fontColor = SKColor.blackColor()
        loadingLabel.fontSize = 60
        loadingLabel.alpha = 0
        self.addChild(loadingLabel)
        let fadeIn = SKAction.fadeInWithDuration(1)
        let wait = SKAction.waitForDuration(2)
        let fadeOut = SKAction.fadeOutWithDuration(1)
        let sequence = SKAction.sequence([fadeIn, wait, fadeOut])
        loadingLabel.runAction(sequence)
        
        //TODO: Add Loading Animation
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
    
    func presentMenu(){
        var scene = MainMenu(size: self.size)
        let skView = self.view! as SKView
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        scene.size = skView.bounds.size
        //NSNotificationCenter.defaultCenter().postNotificationName("hideiAdBanner", object: nil)
        skView.presentScene(scene, transition: SKTransition.fadeWithColor(UIColor.whiteColor(), duration: 1))
    }
}