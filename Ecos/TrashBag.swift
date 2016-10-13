//
//  TrashBag.swift
//  Ecos
//
//  Created by Edvaldo Junior on 13/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import UIKit
import SpriteKit

class TrashBag: SKNode {
    
    var content = [SKSpriteNode]()
    var currentIndex = 0
    var nextPosition = CGPoint()
    
    init(withContent content: [SKSpriteNode]) {
        
        self.content = content
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func push(garbage: SKSpriteNode) {
        
        garbage.removeAllActions()
        garbage.run(SKAction.sequence([SKAction.group([SKAction.move(to: self.position, duration: 0.5),
                                                       SKAction.rotate(byAngle: 720, duration: 0.5)]),
                                       SKAction.run({ 
                                           garbage.position = self.nextPosition
                                           self.addChild(garbage)
                                       })]))
        nextPosition.x += (scene?.size.width)! * 0.02
    }
    
    func throwAway(trashCan: SKSpriteNode) {
        
        for garbage in content {
            garbage.removeAllActions()
            garbage.run(SKAction.sequence([SKAction.group([SKAction.move(to: trashCan.position, duration: 0.5),
                                                           SKAction.rotate(byAngle: 720, duration: 0.5)]),
                                           SKAction.run({
                                               self.removeAllChildren()
                                           })]))
            nextPosition.x = 0
        }
    }
}
