//
//  GameScene.swift
//  Dots!
//
//  Created by Chris Gilardi on 5/17/15.
//  Copyright (c) 2015 Chris Gilardi. All rights reserved.
//

import SpriteKit
import Foundation

class GameScene: SKScene {
    var score = SKLabelNode(text: "0")
    var scoreCount: Int = 0
    var Colors = [SKColor]()
    var colorIndex: UInt32 = 0
    var startingColor: UInt32 = 0
    var viewMidX: Int = 0
    var viewMidY: Int = 0
    override func didMoveToView(view: SKView) {
        /*SET UP THE SCENE*/
        Colors.append(SKColor(red: 255, green: 0, blue: 0, alpha: 1))
        Colors.append(SKColor(red: 0, green: 255, blue: 0, alpha: 1))
        Colors.append(SKColor(red: 0, green: 0, blue: 255, alpha: 1))
        Colors.append(SKColor.blackColor())
        Colors.append(SKColor.purpleColor())
        Colors.append(SKColor.yellowColor())
        Colors.append(SKColor.orangeColor())
        colorIndex = UInt32(Colors.count)
        startingColor = arc4random_uniform(colorIndex)
        print(startingColor)
        addBall()
        let welcomeMessage = SKLabelNode(text: "Press the Ball")
        welcomeMessage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        welcomeMessage.color = SKColor.blackColor()
        welcomeMessage.fontColor = SKColor.blackColor()
        welcomeMessage.fontSize = 30
        self.addChild(welcomeMessage)
        self.backgroundColor = SKColor.whiteColor()
        score.position = CGPointMake(CGRectGetMaxX(self.frame) - 40, CGRectGetMaxY(self.frame) - 40)
        score.fontSize = 20
        score.fontColor = SKColor.blackColor()
        self.addChild(score)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
            let touch:UITouch = touches.first! as! UITouch
            let positionInScene = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(positionInScene)
            
            if let name = touchedNode.name
            {
                if name == "startball"
                {
                    print("Touched")
                    addBall()
                    self.addChild(score)
                }
                else if name == "ball"{
                    print("Touched")
                    addBall()
                    scoreCount++
                    self.addChild(score)
                }
            }
        

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        score.text = "\(scoreCount)"
        //self.addChild(score)
        
    }
    
    func addBall() {
        let viewMidX = view!.bounds.midX
        let viewMidY = view!.bounds.midY
        println(viewMidX)
        println(viewMidY)
        
        let sceneHeight = view?.scene!.frame.height
        let sceneWidth = view?.scene!.frame.width
        println(sceneWidth)
        println(sceneHeight)
        
        let currentBall = SKShapeNode(circleOfRadius: 75)
        currentBall.fillColor = pickColor()
        //currentBall.strokeColor = SKColor.whiteColor()
        
        let xPosition = view!.scene!.frame.midX - viewMidX + CGFloat(arc4random_uniform(UInt32(viewMidX*2)))
        let yPosition = view!.scene!.frame.midY - viewMidY + CGFloat(arc4random_uniform(UInt32(viewMidY*2)))
        println(xPosition)
        println(yPosition)
        
        currentBall.position = CGPointMake(xPosition,yPosition)
        view?.scene?.addChild(currentBall)
        currentBall.name = "ball"
        
        self.removeAllChildren()
        self.addChild(currentBall)
    }
    
    func pickColor() -> SKColor{
        var temp = colorIndex
        var newColor: SKColor = Colors[Int(arc4random_uniform(UInt32(colorIndex)))]
        colorIndex++
        if(Int(colorIndex) > Colors.count){
            colorIndex = 0
        }
        return newColor
    }
}
