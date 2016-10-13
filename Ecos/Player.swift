//
//  Player.swift
//  Ecos
//
//  Created by Edvaldo Junior on 13/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import UIKit
import SpriteKit

class Player: SKSpriteNode {
    
    var velocity = CGFloat(300)
    var jumping = false
    let impulse = CGVector(dx: 1200, dy: 1300)
    
    var walkingFrames: [SKTexture]!
    
    var trashBag = TrashBag(withContent: [])
    
    func initialize(_ size: CGSize, position: CGPoint, zPosition: CGFloat, scene: GameScene) {
        
        self.size = size
        self.position = position
        self.zPosition = zPosition
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = BodyType.player.rawValue
        physicsBody?.contactTestBitMask = BodyType.obstacle.rawValue | BodyType.toy.rawValue | BodyType.limit.rawValue
        physicsBody?.collisionBitMask = BodyType.toy.rawValue | BodyType.limit.rawValue | BodyType.obstacle.rawValue | BodyType.ground.rawValue
        setArrays()
        
        //self.run(animate(walkingFrames), withKey: "WalkingAnimation")
        scene.addChild(self)
    }
    
    func getTextures(_ atlasName: String) -> [SKTexture] {
        
        let atlas = SKTextureAtlas(named: atlasName)
        var frames = [SKTexture]()
        
        for textureName in atlas.textureNames{
            frames.append(atlas.textureNamed(textureName))
        }
        return frames
    }

    func setArrays() {
        
        self.walkingFrames = self.getTextures("Gloria")//Walking//
        //        self.jumpingFrames = self.getTextures("Jumping")
        //        self.idlingFrames = self.getTextures("Idling")
    }
}
