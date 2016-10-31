//
//  Card.swift
//  Ecos
//
//  Created by Edvaldo Junior on 22/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class Card: Button {

    //var locked: Bool!
    
    init(defaultButtonImage: String, activeButtonImage: String) {//, locked: Bool) {
        
        //self.locked = locked
        super.init(defaultButtonImage: defaultButtonImage, activeButtonImage: activeButtonImage)
//        if locked {
//            lockCard()
//        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func lockCard() {
        
        let blackBack = SKSpriteNode(imageNamed: "blackBack")
        blackBack.size = touchableArea.size
        blackBack.position = CGPoint.zero
        blackBack.alpha = 0.7
        blackBack.zPosition = Position.front.rawValue
        touchableArea.addChild(blackBack)
        
        let locker = SKSpriteNode(imageNamed: "locker")
        locker.size = CGSize(width: touchableArea.size.height * 0.8, height: touchableArea.size.height * 0.8)
        locker.position = CGPoint.zero
        locker.zPosition = Position.highlighted.rawValue
        touchableArea.addChild(locker)
        
        self.action = touchedLockedCard
    }
    
    func touchedLockedCard(card: Button) {
        
        
    }
    
    func touchedUnlockedCard(card: Button) {
        
        
    }
}
