//
//  Room.swift
//  Ecos
//
//  Created by Edvaldo Junior on 13/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class Room: SKSpriteNode {
    
    let factor: CGFloat = 0.03

    func initialize(size: CGSize, position: CGPoint) {
        
        self.position = position
        self.size = size
        
        let door = SKSpriteNode()
        door.size = CGSize(width: size.width * factor, height: size.height)
        door.position = CGPoint(x: size.width * (1 - factor)/2, y: 0)
        door.color = .blue
        door.alpha = 0.6
        door.zPosition = Position.front.rawValue
        
        door.physicsBody = SKPhysicsBody(rectangleOf: door.size)
        door.physicsBody?.affectedByGravity = false
        door.physicsBody?.allowsRotation = false
        door.physicsBody?.categoryBitMask = BodyType.door.rawValue
        door.physicsBody?.contactTestBitMask = BodyType.player.rawValue
        self.addChild(door)

        let ground = SKSpriteNode()
        ground.size = CGSize(width: size.width, height: size.height * factor)
        ground.position = CGPoint(x: 0, y: -size.height * 0.25)
        ground.color = .purple
        ground.alpha = 0.6
        ground.zPosition = Position.front.rawValue
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.allowsRotation = false
        ground.physicsBody?.categoryBitMask = BodyType.ground.rawValue
        ground.physicsBody?.contactTestBitMask = BodyType.player.rawValue
        ground.physicsBody?.collisionBitMask = BodyType.player.rawValue
        self.addChild(ground)
    }
}
