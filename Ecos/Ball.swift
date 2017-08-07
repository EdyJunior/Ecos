//
//  Ball.swift
//  Ecos
//
//  Created by Edvaldo Junior on 20/07/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class Ball: Button {
    
    func initialize() {
        
        touchableArea.physicsBody = SKPhysicsBody(circleOfRadius: touchableArea.size.height / 7)
        touchableArea.physicsBody?.allowsRotation = true
        touchableArea.physicsBody?.categoryBitMask = BodyType.toy.rawValue
        touchableArea.physicsBody?.affectedByGravity = true
        touchableArea.physicsBody?.isDynamic = true
        touchableArea.physicsBody?.restitution = 1
        touchableArea.physicsBody?.collisionBitMask = BodyType.player.rawValue | BodyType.ground.rawValue | BodyType.limit.rawValue | BodyType.obstacle.rawValue
        touchableArea.physicsBody?.contactTestBitMask = 0
        
        touchableArea.xScale *= -1
        touchableArea.zPosition = Position.middle.rawValue
    }
    
    func touchBall(ball: Button) {
        
        let gameScene = self.scene as! GameScene
        gameScene.player.jump()
    }
}
