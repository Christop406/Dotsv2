//
//  CreateRandomBall.swift
//  Dots!
//
//  Created by Chris Gilardi on 5/17/15.
//  Copyright (c) 2015 Chris Gilardi. All rights reserved.
//

import Foundation
import SpriteKit

class RandomBall{

    //private let ARC4RANDOM_MAX = 0x100000000
    
    private var newBall: SKShapeNode
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    init(scene: SKScene) {
        newBall = SKShapeNode(circleOfRadius: 100)
        newBall.position = CGPointMake(CGFloat(Random(randNum: Double(scene.frame.maxX)).getInt()), CGFloat(Random(randNum: Double(scene.frame.maxY)).getInt()))
        print("x: \(newBall.position.x) y: \(newBall.position.y)")
        newBall.fillColor = SKColor(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    init(scene: SKScene, size: Int){
        var x = arc4random_uniform(UInt32(scene.frame.maxX)) + UInt32(size)
        var y = arc4random_uniform(UInt32(scene.frame.maxY)) + UInt32(size)
        newBall = SKShapeNode(circleOfRadius: CGFloat(size))
        newBall.position = CGPointMake(CGFloat(x), CGFloat(y))
        newBall.fillColor = SKColor(red: Random(randNum: 255).getFloat(), green: Random(randNum: 255).getFloat(), blue: Random(randNum: 255).getFloat(), alpha: 1)
        
    }
    
    init(scene: SKScene, size: Int, color: SKColor){
        var x = arc4random_uniform(UInt32(scene.frame.maxX)) + UInt32(size)
        var y = arc4random_uniform(UInt32(scene.frame.maxY)) + UInt32(size)
        newBall = SKShapeNode(circleOfRadius: CGFloat(size))
        newBall.position = CGPointMake(CGFloat(x), CGFloat(y))
        newBall.fillColor = SKColor(red: Random(randNum: 255).getFloat(), green: Random(randNum: 255).getFloat(), blue: Random(randNum: 255).getFloat(), alpha: 1)
    }
    
    func getBall() -> SKShapeNode{
        return newBall
    }
}