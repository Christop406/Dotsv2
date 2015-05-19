//
//  Random.swift
//  Dots!
//
//  Created by Chris Gilardi on 5/17/15.
//  Copyright (c) 2015 Chris Gilardi. All rights reserved.
//

import Foundation
import SpriteKit

class Random{
    
    private var finalNum: Double
    
    init(randNum: Double /*, scene: SKScene*/){
        finalNum = drand48()*randNum
    }
    
    func getUInt32() -> UInt32{
        print(Int(finalNum))
        return UInt32(finalNum)
    }
    
    func getInt() -> Int{
        print(Int(finalNum))
        return Int(finalNum)
    }
    
    func getFloat() -> CGFloat{
        print(Int(finalNum))
        return CGFloat(finalNum)
    }
    
}