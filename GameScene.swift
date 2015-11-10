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
    var cloudGenerator: BLCloudGenerator!
    
    var isStarted = false
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = UIColor(red: 159.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        
        
        
        // Add ground
        movingGround = BLMovingGround(size: CGSizeMake(view.frame.width, kBLGroundHeight))
        movingGround.position = CGPointMake(0, view.frame.size.height/2)
        addChild(movingGround)
        
        // Add hero
        hero = BLHero()
        hero.position = CGPointMake(70, movingGround.position.y + movingGround.frame.size.height/2  + hero.frame.size.height/2)
        addChild(hero)
        hero.breathe()
        
        // Add clouds
        cloudGenerator = BLCloudGenerator(color: UIColor.clearColor(), size: view.frame.size)
        cloudGenerator.position = view.center
        addChild(cloudGenerator)
        cloudGenerator.populate(7)
        cloudGenerator.startGeneratingWithSpawnTime(5)
    }
    
    func start() {
        isStarted = true
        hero.stop()
        hero.startRunning()
        movingGround.start()
        
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        if !isStarted {
            start()
        } else {
            hero.flip()
        }

        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
