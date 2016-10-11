//
//  MenuButton.swift
//  Ecos
//
//  Created by Edvaldo Junior on 11/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import UIKit
import SpriteKit

class MenuButton: Button {
    
    var label: SKLabelNode!
    
    init(defaultButtonImage: String, activeButtonImage: String, labelName: String, buttonAction: ((_ button: Button) -> Void)? = nil) {
        
        label = SKLabelNode(text: labelName)
        
        super.init(defaultButtonImage: defaultButtonImage, activeButtonImage: activeButtonImage, buttonAction: buttonAction, Type: .menuBtn)
    }
    
    func setSizeAndPosition(_ size: CGSize, position: CGPoint, labelSize lSize: CGFloat, labelPosition lPosition: CGPoint) {
        super.setSizeAndPosition(size, position: position, areaFactor: 1)
        
        label.fontName = "DK Amoebica"
        label.fontSize = lSize
        label.position = lPosition
        self.touchableArea.addChild(label)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
