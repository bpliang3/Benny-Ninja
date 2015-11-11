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
        let size = CGSizeMake(WALL_WIDTH, WALL_HEIGHT)
        
        super.init(texture: nil, color: WALL_COLOR, size: size)
        
        loadPhysicsBodyWithSize(size)
        startMoving()   
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadPhysicsBodyWithSize(size: CGSize) {
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.categoryBitMask = wallCategory
        physicsBody?.affectedByGravity = false
    }
    
    func startMoving() {
        let moveLeft = SKAction.moveByX(-kDefaultXToMovePerSecond, y: 0, duration: 1)
        runAction(SKAction.repeatActionForever(moveLeft))
    }
    
    func stopMoving(){
        removeAllActions()
    }
}