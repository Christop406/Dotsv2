//
//  MainMenu.swift
//  Dots!
//
//  Created by Chris Gilardi on 6/1/15.
//  Copyright (c) 2015 Chris Gilardi. All rights reserved.
//

import Foundation
import iAd
import UIKit
import SpriteKit

class MainMenu: SKScene {
    var thisGameMode: Int = Int()
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    var lastGM: Int = 0
    var sizeOfView: CGRect = CGRect()
    
    override func didMoveToView(view: SKView) {
        
        print(CGRectGetMidY(self.frame))
        
        
        self.backgroundColor = SKColor.whiteColor()
        let welcomelabel = SKLabelNode(text: "Dots!")
        welcomelabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)/2)
        welcomelabel.fontColor = SKColor.blueColor()
        self.addChild(welcomelabel)
        
        let gm_startButton = SKShapeNode(circleOfRadius: 100)
        gm_startButton.name = "gm_startbutton"
        gm_startButton.fillColor = SKColor.redColor()
        gm_startButton.position = CGPointMake(CGRectGetMidX(self.frame), 3*CGRectGetMaxY(self.frame)/4)
        self.addChild(gm_startButton)
        
        let gm_selector = SKShapeNode(circleOfRadius: 75)
        gm_selector.name = "gm_selector"
        gm_selector.fillColor = SKColor.greenColor()
        gm_selector.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(gm_selector)
        
        let startLabel = SKLabelNode(text: "Start!")
        startLabel.position = CGPointMake(0, 0)
        startLabel.fontSize = 45
        startLabel.fontName = "Helvetica-Bold"
        startLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode(rawValue: 1)!
        startLabel.name = "gm_startbutton"
        gm_startButton.addChild(startLabel)
        
        if let lastGamemode: AnyObject = userDefaults.valueForKey("last_gamemode") as? Int{
            lastGM = Int(lastGamemode as! NSNumber)
        }
        thisGameMode = lastGM
        
        NSNotificationCenter.defaultCenter().postNotificationName("showiAdBanner", object: nil)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch:UITouch = touches.first! as! UITouch
        let positionInScene = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(positionInScene)
        
        if let name = touchedNode.name{
            if name == "gm_startbutton"{
                if thisGameMode == 0 {
                    var scene = TimeTrial(size: self.size)
                    let skView = self.view! as SKView
                    skView.ignoresSiblingOrder = true
                    scene.scaleMode = .ResizeFill
                    scene.size = skView.bounds.size
                    NSNotificationCenter.defaultCenter().postNotificationName("hideiAdBanner", object: nil)
                    skView.presentScene(scene, transition: SKTransition.crossFadeWithDuration(0.5))
                    
                } else if thisGameMode == 1 {
                    var scene = Infinite(size: self.size)
                    let skView = self.view! as SKView
                    skView.ignoresSiblingOrder = true
                    scene.scaleMode = .ResizeFill
                    scene.size = skView.bounds.size
                    NSNotificationCenter.defaultCenter().postNotificationName("hideiAdBanner", object: nil)
                    skView.presentScene(scene, transition: SKTransition.crossFadeWithDuration(0.5))
                } else {
                    var scene = TimeTrial(size: self.size)
                    let skView = self.view! as SKView
                    skView.ignoresSiblingOrder = true
                    scene.scaleMode = .ResizeFill
                    scene.size = skView.bounds.size
                    NSNotificationCenter.defaultCenter().postNotificationName("hideiAdBanner", object: nil)
                    skView.presentScene(scene, transition: SKTransition.crossFadeWithDuration(0.5))
                }
                //var scene =  TimeTrial(size: self.size)
            }
            if name == "gm_selector" {
                var scene =  GameModeSelector(size: self.size)
                let skView = self.view! as SKView
                scene.setThisCurrentGM(lastGM)
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .ResizeFill
                scene.size = skView.bounds.size
                //NSNotificationCenter.defaultCenter().postNotificationName("hideiAdBanner", object: nil)
                skView.presentScene(scene, transition: SKTransition.flipVerticalWithDuration(0.5))
            }
        }
        
    }
    
    func setMainGameMode(gamemode: Int){
        thisGameMode = gamemode
    }
    
    func sizeOfView(size: CGRect){
        sizeOfView = size
    }
}