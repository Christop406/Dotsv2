//
//  TouchableSpriteNode.swift
//  
//
//  Created by Chris Gilardi on 5/17/15.
//
//

import Foundation
import SpriteKit

class TouchableSpriteNode : SKSpriteNode{
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        print("touched")
    }
}