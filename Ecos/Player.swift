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
    
    var velocity = CGFloat(170)
    var jumping = false
    let impulse = CGVector(dx: 0, dy: 280)
    
    var walkingFrames: [SKTexture]!
    
    var trashBag = TrashBag(withContent: [])
    
    var newPosition = CGPoint()
    
    func initialize(_ size: CGSize, position: CGPoint, zPosition: CGFloat, scene: GameScene) {
        
        self.size = size
        self.position = position
        self.newPosition = position
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
        
        let step: CGFloat = (scene?.size.width)!/5
        
        run(SKAction.repeatForever(SKAction.animate(with: walkingFrames, timePerFrame: 0.3)), withKey: "WalkingAnimation")
        run(SKAction.repeatForever(SKAction.moveBy(x: step, y: 0, duration: Double(step)/Double(velocity))), withKey: "WalkingMovement")
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
