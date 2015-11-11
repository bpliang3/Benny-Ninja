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
        addPointsLabels()
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
        tapToStartLabel.runAction(blinkAnimation())
    }
    
    func addPointsLabels() {
        let pointsLabel = BLPointsLabel(num: 0)
        let highScoreLabel = BLPointsLabel(num: 0)
        let highScoreTextLabel = SKLabelNode(text: "High Score:")
        
        pointsLabel.name = "pointsLabel"
        pointsLabel.position = CGPointMake(20, view!.frame.size.height - 35)
        addChild(pointsLabel)
        
        highScoreLabel.name = "highScoreLabel"
        highScoreLabel.position = CGPointMake(view!.frame.size.width - 20, view!.frame.size.height - 35)
        addChild(highScoreLabel)
        
        highScoreTextLabel.name = "highScoreTextLabel"
        highScoreTextLabel.fontColor = UIColor.blackColor()
        highScoreTextLabel.fontSize = 18.0
        highScoreTextLabel.position = CGPointMake(-60, 0)
        highScoreLabel.addChild(highScoreTextLabel)
        
        
        
    }
    
    func addPhysicsWorld() {
        physicsWorld.contactDelegate = self
        //physicsWorld.gravity = CGVectorMake(0.0, -9.8)
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
        hero.fall()
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
        gameOverLabel.runAction(blinkAnimation())
        
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
        if !isGameOver {
            gameOver()
        }
    }
    
    // MARK: - Animations
    func blinkAnimation() -> SKAction {
        let duration = 0.4
        let fadeOut = SKAction.fadeAlphaTo(0.0, duration: duration)
        let fadeIN = SKAction.fadeAlphaTo(1.0, duration: duration)
        
        let blink = SKAction.sequence([fadeOut, fadeIN])
        return SKAction.repeatActionForever(blink)
    }
}
