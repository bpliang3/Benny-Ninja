//
//  BLWall.swift
//  Benny Ninja
//
//  Created by Ben Liang on 11/9/15.
//  Copyright (c) 2015 Ben Liang. All rights reserved.
//

import Foundation
import SpriteKit

class BLWall: SKSpriteNode {
    
    let WALL_WIDTH: CGFloat = 30.0
    let WALL_HEIGHT: CGFloat = 50.0
    let WALL_COLOR = UIColor.blackColor()
    
    init(){
        super.init(texture: nil, color: WALL_COLOR, size: CGSizeMake(WALL_WIDTH, WALL_HEIGHT))
        
        startMoving()   
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMoving() {
        let moveLeft = SKAction.moveByX(-300, y: 0, duration: 1)
        runAction(SKAction.repeatActionForever(moveLeft))
    }
}