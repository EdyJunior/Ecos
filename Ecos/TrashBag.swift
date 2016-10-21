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
    
    init(withContent content: [Button]) {
        
        self.content = content
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func push(garbage: Button) {
        
        garbage.touchableArea.removeAllActions()
        garbage.touchableArea.run(SKAction.sequence([SKAction.group([SKAction.move(to: self.position, duration: 0.5), SKAction.rotate(byAngle: 720, duration: 0.5)]), SKAction.run({
                garbage.touchableArea.position = self.nextPosition
                self.addChild(garbage)
            })]))
        nextPosition.x += (scene?.size.width)! * 0.02
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
