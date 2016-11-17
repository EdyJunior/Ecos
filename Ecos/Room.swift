//
//  Room.swift
//  Ecos
//
//  Created by Edvaldo Junior on 13/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class Room: SKSpriteNode {
    
    let factor: CGFloat = 0.01
    var firstGarbage: Button?
    
    func initialize(size: CGSize, position: CGPoint) {
        
        self.position = position
        self.size = size
        
        let door = SKSpriteNode()
        door.size = CGSize(width: size.width * factor, height: size.height)
        door.position = CGPoint(x: size.width * (1 - factor)/2, y: 0)
        door.zPosition = Position.front.rawValue

        door.physicsBody = SKPhysicsBody(rectangleOf: door.size)
        door.physicsBody?.affectedByGravity = false
        door.physicsBody?.allowsRotation = false
        door.physicsBody?.categoryBitMask = BodyType.door.rawValue
        door.physicsBody?.contactTestBitMask = BodyType.player.rawValue
        door.physicsBody?.collisionBitMask = 0
        self.addChild(door)

        let ground = SKSpriteNode()
        ground.size = CGSize(width: size.width, height: size.height * factor)
        ground.position = CGPoint(x: 0, y: -size.height * 0.25)
        ground.zPosition = Position.front.rawValue
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.allowsRotation = false
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = BodyType.ground.rawValue
        ground.physicsBody?.contactTestBitMask = BodyType.player.rawValue
        ground.physicsBody?.collisionBitMask = BodyType.player.rawValue
        self.addChild(ground)
        
        let ceil = SKSpriteNode()
        ceil.size = CGSize(width: size.width, height: size.height * factor)
        ceil.position = CGPoint(x: 0, y: size.height * 0.55)
        ceil.zPosition = Position.front.rawValue
        
        ceil.physicsBody = SKPhysicsBody(rectangleOf: ceil.size)
        ceil.physicsBody?.affectedByGravity = false
        ceil.physicsBody?.allowsRotation = false
        ceil.physicsBody?.isDynamic = false
        ceil.physicsBody?.categoryBitMask = BodyType.ceil.rawValue
        ceil.physicsBody?.contactTestBitMask = 0
        ceil.physicsBody?.collisionBitMask = BodyType.player.rawValue
        self.addChild(ceil)
    }
    
    func createTrash() -> [Button] {
        
        var trashSizeTable: Dictionary = [Int : [CGFloat]]()
        trashSizeTable[0] = [0.03, 0.06]
        trashSizeTable[1] = [0.03, 0.09]
        trashSizeTable[2] = [0.02, 0.02]
        
        var trashNameTable: Dictionary = [Int : String]()
        trashNameTable[0] = "Can"
        trashNameTable[1] = "Bottle"
        trashNameTable[2] = "PaperBall"
        
        let quantity = Int(arc4random_uniform(3))
        var trashArray = [Button]()
        
        var min = 2 * size.width
        
        for _ in 0...quantity {
            let key = Int(arc4random_uniform(2))
            let sizeTrash = CGSize(width: size.width * trashSizeTable[key]![0] / 3.0 , height: size.width * trashSizeTable[key]![1] / 3.0)
            let garbagePosition = CGPoint(x: size.width * (CGFloat(arc4random_uniform(10)) / 10.0 - 0.45) / 3.0, y: -size.height * 0.1)
            let image: String = trashNameTable[key]!
            
            let garbage = Button(defaultButtonImage: image, activeButtonImage: image, buttonAction: touchTrash)
            garbage.setSizeAndPosition(sizeTrash, position: garbagePosition, areaFactor: 1.5)
            garbage.zPosition = Position.before.rawValue
            
            if garbage.touchableArea.position.x < min {
                self.firstGarbage = garbage
                min = garbage.touchableArea.position.x
            }
            
            trashArray.append(garbage)
        }
        
        return trashArray
    }
    
    func touchTrash(trash: Button) {
        
        let gameScene = self.scene as! GameScene
        gameScene.player.trashBag!.push(garbage: trash)
        gameScene.updateScore(scoreToAdd: ScoreTable.trash)
        trash.action = nil
        
        if let value = defaults.object(forKey: Key.nTrash.rawValue) {
            let number = value as! Int
            defaults.set(number + 1, forKey: Key.nTrash.rawValue)
        } else {
            defaults.set(Int(1), forKey: Key.nTrash.rawValue)
        }
    }
    
    func addTrash() {
        
        for trash in createTrash() {
            self.addChild(trash)
        }
    }
}
