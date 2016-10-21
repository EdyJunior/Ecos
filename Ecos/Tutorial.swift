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
    
    init(withScene scene: GameScene) {
        
        self.scene = scene
        blackBack.alpha = 0.7
        blackBack.size = scene.size
        super.init()
    }
    
    func start(button: Button, text: String) {
        
        self.text = InfoLabel(text: text)
        self.text.set(fontSize: scene.size.height * 0.2, position: scene.player.position, fontColor: .white, zPosition: .highlighted)
        
        let pos = button.defaultButton.position
        
        if pos.y > scene.size.height/2 {
            hand.position = CGPoint(x: pos.x, y: pos.y - 150)
            hand.yScale *= (hand.yScale > 0 ? 1 : -1)
            self.text.position = CGPoint(x: scene.player.position.x, y: hand.position.y - 150)
        } else {
            hand.position = CGPoint(x: pos.x, y: pos.y + 150)
            hand.yScale *= (hand.yScale > 0 ? -1 : 1)
            self.text.position = CGPoint(x: scene.player.position.x, y: hand.position.y + 150)
        }
        
        hand.zPosition = Position.highlighted.rawValue
        hand.size = CGSize(width: scene.size.width * 0.2, height: scene.size.height * 0.2)
        
        scene.addChild(hand)
        scene.addChild(self.text)
        scene.addChild(blackBack)
        
        scene.playerNameLabel.zPosition = Position.front.rawValue
        scene.scoreLabel.zPosition = Position.front.rawValue
        
        button.zPosition = Position.highlighted.rawValue
        
        scene.player.removeAllActions()
        
        button.action = end
        button.enabled = true
    }
    
    func end(button: Button) {

        
    }
}
