//
//  Ball.swift
//  Ecos
//
//  Created by Edvaldo Junior on 20/07/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class Ball: SKSpriteNode {
    
    func initialize() {
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.height / 2)
        physicsBody?.allowsRotation = true
        physicsBody?.categoryBitMask = BodyType.toy.rawValue
        physicsBody?.affectedByGravity = true
        physicsBody?.isDynamic = true
        physicsBody?.restitution = 1
        physicsBody?.collisionBitMask = BodyType.player.rawValue | BodyType.ground.rawValue | BodyType.limit.rawValue | BodyType.obstacle.rawValue | BodyType.toy.rawValue
        physicsBody?.contactTestBitMask = BodyType.player.rawValue
        physicsBody?.friction = 0.0
        
        zPosition = Position.middle.rawValue
    }
}
