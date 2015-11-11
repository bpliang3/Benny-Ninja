//
//  BLPointsLabel.swift
//  Benny Ninja
//
//  Created by Ben Liang on 11/10/15.
//  Copyright (c) 2015 Ben Liang. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class BLPointsLabel: SKLabelNode {
    
    var number = 0
    
    init(num: Int) {
        super.init()
        
        fontColor = UIColor.blackColor()
        fontSize = 24.0
        
        
        number = num
        text = "\(num)"
    }
    
    func increment() {
        number++
        text = "\(number)"
        
    }
    
    func setTo(num: Int) {
        self.number = num
        text = "\(number)"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
