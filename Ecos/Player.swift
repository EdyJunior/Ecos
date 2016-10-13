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
    
    var velocity = CGFloat(10)
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
        setArrays()
        
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
    
    func walk() {
        
        run(SKAction.repeatForever(SKAction.group(
            [SKAction.animate(with: walkingFrames, timePerFrame: 0.3),
             SKAction.moveBy(x: velocity, y: 0, duration: 0.1)]
        )), withKey: "WalkingAnimation")
    }
    
    func jump() {
        
        run(SKAction.group(
            [SKAction.animate(with: walkingFrames, timePerFrame: 0.3),
             SKAction.run({ 
                self.physicsBody?.applyImpulse(self.impulse)
             })]
        ), withKey: "JumpingAnimation")
    }
}
