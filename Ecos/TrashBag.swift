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
    
    var content = [Button]()
    var currentIndex = 0
    var nextPosition = CGPoint()
    var size = CGFloat()
    
    init(sceneSize size: CGSize, withContent content: [Button] = []) {
        
        self.content = content
        super.init()
        self.size = size.width * 0.4
        nextPosition = CGPoint(x: -self.size * 0.5, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func push(garbage: Button) {
        
        let pos = Int(arc4random_uniform(2))
        let dir: [CGFloat] = [-1.0, 1.0]
        
        let upDown = SKAction.sequence(
            [SKAction.moveBy(x: size * 0.3 * dir[pos], y: size * 0.3, duration: 0.3),
             SKAction.moveBy(x: size * 0.1 * dir[pos], y: 0, duration: 0.2),
             SKAction.moveBy(x: size * 0.2 * dir[pos], y: -size * 0.6, duration: 0.5)]
        )
        
        garbage.touchableArea.removeAllActions()
        garbage.touchableArea.run(SKAction.sequence(
            [SKAction.group(
                [upDown,
                 SKAction.rotate(byAngle: 400, duration: 1)]
            ), SKAction.run({
                garbage.removeFromParent()
                garbage.touchableArea.position = self.nextPosition
                garbage.action = nil
                self.addChild(garbage)
            })])
        )
        nextPosition.x += size * 0.04
    }
    
    func throwAway(trashCan: Button) {
        
        for garbage in content {
            garbage.removeAllActions()
            garbage.run(SKAction.sequence([SKAction.group([SKAction.move(to: trashCan.touchableArea.position, duration: 0.5), SKAction.rotate(byAngle: 720, duration: 0.5)]),
                SKAction.run({self.removeAllChildren()})
            ]))
            nextPosition.x = 0
        }
    }
}
