//
//  GameScene.swift
//  Dots!
//
//  Created by Chris Gilardi on 5/17/15.
//  Copyright (c) 2015 Chris Gilardi. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenHeight = screenSize.height
        let screenWidth = screenSize.width
        let currentBall = SKShapeNode(circleOfRadius: 100)
        currentBall.position = arc4random_uniform(screenWidth), arc4random_uniform(screenHeight)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
