//
//  Tutorial.swift
//  Ecos
//
//  Created by Edvaldo Junior on 21/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class Tutorial: NSObject {
    
    var scene = GameScene()
    var hand = SKSpriteNode(imageNamed: "hand")
    var blackBack = SKSpriteNode(imageNamed: "blackBack")
    var text = InfoLabel()
    var action: ((Button)->Void)?
    var zPos: CGFloat = 0
    
    init(withScene scene: GameScene) {
        
        self.scene = scene
        blackBack.alpha = 0.7
        blackBack.size = scene.size
        super.init()
    }
    
    func start(button: Button, text: String) {
        
        self.text = InfoLabel(text: text)
        self.text.set(fontSize: scene.size.height * 0.1, position: scene.player.position, fontColor: .white, zPosition: .highlighted)
        
        hand.zPosition = Position.highlighted.rawValue
        hand.size = CGSize(width: scene.size.width * 0.2, height: scene.size.height * 0.3)
        
        let pos = button.touchableArea.position
        if pos.y > 0 {
            hand.position = CGPoint(x: 0, y: -hand.size.height / 2 - button.touchableArea.size.height / 2)
            hand.yScale *= (hand.yScale > 0 ? 1 : -1)
            self.text.position = CGPoint(x: -scene.size.width/3, y: hand.position.y - self.text.fontSize)
        } else {
            hand.position = CGPoint(x: 0, y: hand.size.height / 2 + button.touchableArea.size.height / 2)
            hand.yScale *= (hand.yScale > 0 ? -1 : 1)
            self.text.position = CGPoint(x: -scene.size.width/3, y: hand.position.y + self.text.fontSize)
        }
        
        blackBack.position = CGPoint(x: scene.player.position.x, y: scene.size.height / 2)
        blackBack.zPosition = Position.front.rawValue
        
        button.touchableArea.addChild(hand)
        button.touchableArea.addChild(self.text)
        scene.addChild(blackBack)
        
//        scene.playerNameLabel.zPosition = Position.front.rawValue
//        scene.scoreLabel.zPosition = Position.front.rawValue
        
        self.zPos = button.zPosition
        button.zPosition = Position.highlighted.rawValue
        
        scene.player.removeAllActions()
        
        self.action = button.action
        button.action = end
        button.enabled = true
    }
    
    func end(button: Button) {

        button.touchableArea.removeChildren(in: [hand, text])
        scene.removeChildren(in: [blackBack])
        button.touchableArea.zPosition = self.zPos
        self.action?(button)
        scene.player.walk()
    }
    
    func tutorialTrigger(triggerPosition: CGPoint, buttonType: BodyType, room: Room) {
        
        let trigger = SKSpriteNode()
        trigger.size = CGSize(width: scene.size.width * 0.01, height: scene.size.height)
        trigger.position = triggerPosition
        trigger.zPosition = Position.front.rawValue
        
        trigger.physicsBody = SKPhysicsBody(rectangleOf: trigger.size)
        trigger.physicsBody?.affectedByGravity = false
        trigger.physicsBody?.allowsRotation = false
        trigger.physicsBody?.categoryBitMask = buttonType.rawValue
        trigger.physicsBody?.contactTestBitMask = BodyType.player.rawValue
        trigger.physicsBody?.collisionBitMask = 0
        
        room.addChild(trigger)
    }
}
