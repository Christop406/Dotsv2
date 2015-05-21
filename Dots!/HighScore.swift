//
//  HighScore.swift
//  Dots!
//
//  Created by Chris Gilardi on 5/20/15.
//  Copyright (c) 2015 Chris Gilardi. All rights reserved.
//

import Foundation
import SpriteKit

class HighScore: NSObject, NSCoding{
    let score:Int;
    let dateOfScore:NSDate;
    
    init(score:Int, dateOfScore:NSDate) {
        self.score = score;
        self.dateOfScore = dateOfScore;
    }
    
    required init(coder: NSCoder) {
        self.score = coder.decodeObjectForKey("score")! as! Int;
        self.dateOfScore = coder.decodeObjectForKey("dateOfScore")! as! NSDate;
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.score, forKey: "score")
        coder.encodeObject(self.dateOfScore, forKey: "dateOfScore")
    }
    
    func getScore() -> Int {
        return score
    }
}
