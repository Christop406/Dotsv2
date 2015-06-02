//
//  TwoPlayer.swift
//  Dots!
//
//  Created by Chris Gilardi on 5/27/15.
//  Copyright (c) 2015 Chris Gilardi. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class TwoPlayer : DBasicLevel {
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = SKColor.whiteColor()
        let midLine = SKShapeNode()
        var pathToDraw: CGMutablePathRef = CGPathCreateMutable()
        CGPathMoveToPoint(pathToDraw, nil, 0, CGRectGetMidY(self.frame))
        CGPathAddLineToPoint(pathToDraw, nil, CGRectGetMaxY(self.frame), CGRectGetMidY(self.frame))
        midLine.path = pathToDraw
        midLine.strokeColor = UIColor.blackColor()
        self.addChild(midLine)
    }
}