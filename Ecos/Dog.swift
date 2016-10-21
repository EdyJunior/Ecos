//
//  Dog.swift
//  Ecos
//
//  Created by Edvaldo Junior on 21/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class Dog: Button {
    
    func initialize() {
        
        touchableArea.physicsBody = SKPhysicsBody(circleOfRadius: touchableArea.size.height / 7)
        touchableArea.physicsBody?.affectedByGravity = false
        touchableArea.physicsBody?.allowsRotation = false
        touchableArea.physicsBody?.isDynamic = false
        touchableArea.physicsBody?.categoryBitMask = BodyType.obstacle.rawValue
        touchableArea.physicsBody?.collisionBitMask = BodyType.player.rawValue
        touchableArea.physicsBody?.contactTestBitMask = BodyType.player.rawValue
        
        touchableArea.xScale *= -1
        touchableArea.zPosition = Position.middle.rawValue
        
        self.animate("Dog", imgName: "dog")
    }
    
    func touchDog(dog: Button) {
        
        let gameScene = self.scene as! GameScene
        gameScene.player.jump()
    }
}
