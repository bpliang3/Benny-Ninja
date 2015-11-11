//
//  GameScene.swift
//  Benny Ninja
//
//  Created by Ben Liang on 11/9/15.
//  Copyright (c) 2015 Ben Liang. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var movingGround: BLMovingGround!
    var hero: BLHero!
    var cloudGenerator: BLCloudGenerator!
    var wallGenerator: BLWallGenerator!
    
    var isStarted = false
    var isGameOver = false
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = UIColor(red: 159.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        
        addMovingGround()
        addHero()
        addClouds()
        addWalls()
        addStartLabel()
        addPhysicsWorld()
        
        
        
    }
    
    func addMovingGround(){
        movingGround = BLMovingGround(size: CGSizeMake(view!.frame.width, kBLGroundHeight))
        movingGround.position = CGPointMake(0, view!.frame.size.height/2)
        addChild(movingGround)
    }
    
    func addHero() {
        hero = BLHero()
        hero.position = CGPointMake(70, movingGround.position.y + movingGround.frame.size.height/2  + hero.frame.size.height/2)
        addChild(hero)
        hero.breathe()
    }
    
    func addClouds() {
        cloudGenerator = BLCloudGenerator(color: UIColor.clearColor(), size: view!.frame.size)
        cloudGenerator.position = view!.center
        addChild(cloudGenerator)
        cloudGenerator.populate(7)
        cloudGenerator.startGeneratingWithSpawnTime(5)
    }
    
    func addWalls() {
        wallGenerator = BLWallGenerator(color: UIColor.clearColor(), size: view!.frame.size)
        wallGenerator.position = view!.center
        addChild(wallGenerator)
    }
    
    func addStartLabel() {
        let tapToStartLabel = SKLabelNode(text: "Tap to start!")
        tapToStartLabel.name  = "tapToStartLabel"
        tapToStartLabel.position.x = view!.center.x
        tapToStartLabel.position.y  = view!.center.y + 40
        tapToStartLabel.fontColor = UIColor.blackColor()
        addChild(tapToStartLabel)
    }
    
    func addPhysicsWorld() {
        physicsWorld.contactDelegate = self
    }
    
    func start() {
        isStarted = true
        
        let tapToStartLabel = childNodeWithName("tapToStartLabel")
        tapToStartLabel?.removeFromParent()
        hero.stopBreathing()
        hero.startRunning()
        movingGround.start()
        
        wallGenerator.startGeneratingWallsEvery(1)
    }
    
    
    // MARK: - Game Lifecycle
    func gameOver() {
        isGameOver = true
        
        // stop everything
        hero.physicsBody = nil
        wallGenerator.stopWalls()
        movingGround.stop()
        hero.stopRunning()
        
        // Add game over label
        let gameOverLabel = SKLabelNode(text: "Game Over!")
        gameOverLabel.name  = "gameOverLabel"
        gameOverLabel.position.x = view!.center.x
        gameOverLabel.position.y  = view!.center.y + 40
        gameOverLabel.fontColor = UIColor.grayColor()
        addChild(gameOverLabel)
        
    }
    
    func restart() {
        
        cloudGenerator.stopGenerating()
        
        let newScene = GameScene(size: view!.bounds.size)
        newScene.scaleMode = .AspectFill
        
        view!.presentScene(newScene)
        
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        if isGameOver {
            restart()
        } else if !isStarted {
            start()
        } else {
            hero.flip()
        }

        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    // MARK: - SKPhysicsContactDelegate
    func didBeginContact(contact: SKPhysicsContact) {
       // println("didBeginContact called")
        gameOver()
        
    }
}
