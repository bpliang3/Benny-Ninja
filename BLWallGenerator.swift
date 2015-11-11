//
//  BLWallGenerator.swift
//  Benny Ninja
//
//  Created by Ben Liang on 11/9/15.
//  Copyright (c) 2015 Ben Liang. All rights reserved.
//

import Foundation
import SpriteKit

class BLWallGenerator: SKSpriteNode {
    
    var generationTimer: NSTimer?
    var walls = [BLWall]()
    var wallTrackers = [BLWall]()
    
    
    func startGeneratingWallsEvery(seconds: NSTimeInterval) {
        generationTimer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "generateWall", userInfo: nil, repeats: true)
        
    }
    
    func stopGenerating() {
        generationTimer?.invalidate()
        
    }
    
    func generateWall() {
        var scale: CGFloat
        let rand = arc4random_uniform(2)
        
        if rand == 0 {
            scale = -1.0
        } else {
            scale = 1.0
        }
        
        
        let wall = BLWall()
        wall.position.x = size.width/2 + wall.size.width/2
        wall.position.y = scale * (kBLGroundHeight/2 + wall.size.height/2)
        walls.append(wall)
        wallTrackers.append(wall)
        addChild(wall)
    }
    
    func stopWalls() {
        stopGenerating()
        for wall in walls {
            wall.stopMoving()
        }
    }
}