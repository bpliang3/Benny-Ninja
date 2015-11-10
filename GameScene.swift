//
//  GameScene.swift
//  Benny Ninja
//
//  Created by Ben Liang on 11/9/15.
//  Copyright (c) 2015 Ben Liang. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var movingGround: BLMovingGround!
    var hero: BLHero!
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = UIColor(red: 159.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        
        movingGround = BLMovingGround(size: CGSizeMake(view.frame.width, 20))
        movingGround.position = CGPointMake(0, view.frame.size.height/2)
        addChild(movingGround)
        
        hero = BLHero()
        hero.position = CGPointMake(70, movingGround.position.y + movingGround.frame.size.height/2  + hero.frame.size.height/2)
        addChild(hero)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        movingGround.start()
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
