//
//  TimeTrial.swift
//  Dots!
//
//  Created by Chris Gilardi on 5/21/15.
//  Copyright (c) 2015 Chris Gilardi. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class TimeTrial : DBasicLevel{
    let TIME_INCREMENT = 20.0
    //gameTimer: NSTimer = NSTimer()
    var firstTouch = true
    var timeLeft: Int = 19
    let timeLeftLabel = SKLabelNode(text: "20")
    let getSmaller = SKAction.fadeOutWithDuration(1.0)
    var welcomeMessage = SKLabelNode()

    
    override func didMoveToView(view: SKView) {
        NSNotificationCenter.defaultCenter().postNotificationName("hideiAdBanner", object: nil)
        
        //Setup Audio Files/Player
        audioPlayer = AVAudioPlayer(contentsOfURL: blopSound, error: nil)
        audioPlayer.prepareToPlay()
        
        //Color the Background
        self.backgroundColor = SKColor.whiteColor()
        
        //Add preset colors to an array of colors (Predefine them, "pseudorandom")
        Colors.append(SKColor.redColor())
        Colors.append(SKColor.greenColor())
        Colors.append(SKColor.blueColor())
        Colors.append(SKColor.blackColor())
        Colors.append(SKColor.purpleColor())
        Colors.append(SKColor.yellowColor())
        Colors.append(SKColor.orangeColor())
        //Colors.append(SKColor(red: 255, green: 153, blue: 204, alpha: 1))
        
        //Get length of array of colors and find a random start index
        colorIndex = UInt32(Colors.count)
        startingColor = arc4random_uniform(colorIndex)
        print(startingColor)
        
        //Add the first ball to the scene, uses SKShapeNode, r=75, color is "random")
        addBall(ballSize)
        
        //Add the welcome message: "Press the Ball"
        welcomeMessage = SKLabelNode(text: "Press the Ball")
        welcomeMessage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        welcomeMessage.fontColor = SKColor.blackColor()
        welcomeMessage.fontSize = 30
        welcomeMessage.name = "welcome"
        self.addChild(welcomeMessage)
        
        //Setup the score counter
        score.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        score.fontSize = 150
        score.fontName = "Avenir Next"
        score.fontColor = SKColor.blackColor()
       // gameTimer = NSTimer.scheduledTimerWithTimeInterval(TIME_INCREMENT, target:self, selector: Selector("endGame"), userInfo: nil, repeats: false)
        timeLeftLabel.position = CGPointMake(self.score.position.x, self.score.position.y - 40)
        timeLeftLabel.fontColor = SKColor.blackColor()
        timeLeftLabel.fontSize = 30
        timeLeftLabel.name = "timer"
        timeLeftLabel.userInteractionEnabled = false
        

        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        //Touch variables
        let touch:UITouch = touches.first! as! UITouch
        let positionInScene = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(positionInScene)
        
        if let name = touchedNode.name
        {
            //The first ball that shows up, startball
            if name == "startball"
            {
                print("Touched")
                addBall(ballSize)
                self.addChild(score)
            }//Any ball created after the first will use this statement
            else if name == "ball"{
                //print("Touched") -- For testing purposes
                scoreCount++
                addBall(ballSize)
                //print(ballSize)
                audioPlayer.play()
               // self.addChild(timeLeftLabel)
                //self.addChild(score)
            }
        }
        else{
            //Change background to red if the player touches outside the ball
            //self.backgroundColor = SKColor.redColor()
            var scene =  GameOver(size: self.size)
            scene.setMyScore(0)
            let skView = self.view! as SKView
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .ResizeFill
            scene.size = skView.bounds.size
            scene.setMessage("You Lost!")
            scene.setEndGameMode(gm)
            gameTimer.invalidate()
            shownTimer.invalidate()
            print(" timers invalidated ")
            ran = true
            skView.presentScene(scene, transition: SKTransition.crossFadeWithDuration(0.25))
        }
        tapCount++

        if firstTouch {
            NSNotificationCenter.defaultCenter().postNotificationName("hideiAdBanner", object: nil)
            shownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("decTimer"), userInfo: nil, repeats: true)
            gameTimer = NSTimer.scheduledTimerWithTimeInterval(TIME_INCREMENT, target:self, selector: Selector("endGame"), userInfo: nil, repeats: false)
            firstTouch = false
        }


    }
    
    override func update(currentTime: CFTimeInterval) {
        super.update(currentTime)
        
    }
    
    func endGame(){
        shownTimer.invalidate()
        gameTimer.invalidate()
        var scene =  GameOver(size: self.size)
        scene.setMyScore(scoreCount)
        let skView = self.view!
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        scene.size = skView.bounds.size
        scene.setMessage("Time's Up!")

        skView.presentScene(scene, transition: SKTransition.crossFadeWithDuration(0.25))
    }

    override func addBall(size: Int) {
        
        //Find and set bounds of the view
        let viewMidX = view!.bounds.midX
        let viewMidY = view!.bounds.midY
        let sceneHeight = view?.scene!.frame.height
        let sceneWidth = view?.scene!.frame.width
        
        //Setup of the ball constant
        let currentBall = SKShapeNode(circleOfRadius: CGFloat(size))
        currentBall.fillColor = pickColor()
        
        //Finding the random position of the ball
        //TODO: Make it so balls spawn close enough to the middle of the screen that player can touch.
        let xPosition = view!.scene!.frame.midX - viewMidX + CGFloat(arc4random_uniform(UInt32(viewMidX*2)))
        let yPosition = view!.scene!.frame.midY - viewMidY + CGFloat(arc4random_uniform(UInt32(viewMidY*2)))
        
        //Set the ball's random position
        currentBall.position = CGPointMake(xPosition, yPosition)
        
        //Set the ball's name
        
        //Remove other balls and add the new one

        if scoreCount != 0{
            if scoreCount == 1{
            self.addChild(score)
            self.addChild(timeLeftLabel)
            self.childNodeWithName("welcome")?.removeFromParent()
            }
            self.childNodeWithName("ball")?.runAction(getSmaller)
            self.childNodeWithName("ball")?.removeFromParent()
            //self.addChild(childNodeWithName("timer")!)
        }
        currentBall.name = "ball"

        self.addChild(currentBall)
    }

    
    func decTimer(){
        //timeLeftLabel.removeFromParent()
        timeLeftLabel.text = "\(timeLeft)"
        timeLeft--
        //self.addChild(timeLeftLabel)
    }
}
