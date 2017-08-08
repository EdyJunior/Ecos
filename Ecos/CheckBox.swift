//
//  CheckBox.swift
//  Ecos
//
//  Created by Edvaldo Junior on 07/08/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class CheckBox: Button {

    var boolKey: String = ""
    var check = SKSpriteNode(imageNamed: "v")
    
    init(withSize size: CGSize, position pos: CGPoint, andBoolKey key: String) {
        
        super.init(defaultButtonImage: "checkBox", activeButtonImage: "checkBox")
        
        self.boolKey = key
        
        self.zPosition = Position.front.rawValue
        self.setSizeAndPosition(size, position: pos, areaFactor: 1.1)
        self.action = touchCheck
        
        self.check.position = CGPoint.zero
        self.check.zPosition = Position.highlighted.rawValue
        self.check.size = size
        
        self.updateCheck()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func touchCheck(_ button: Button) {
        
        if let val = defaults.object(forKey: boolKey) as? Bool {
            defaults.set(!val, forKey: boolKey)
            updateCheck()
        }
    }
    
    func updateCheck() {
        
        if let val = defaults.object(forKey: boolKey) as? Bool {
            if val {
                self.touchableArea.addChild(check)
            } else {
                check.removeFromParent()
            }
        }
    }
}
