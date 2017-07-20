//
//  InfoLabel.swift
//  Ecos
//
//  Created by Edvaldo Junior on 11/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import UIKit
import SpriteKit

class InfoLabel: SKLabelNode {
    
    func set(fontSize size: CGFloat, position: CGPoint, fontColor color: UIColor, zPosition: Position) {
        
        self.fontSize = size
        self.position = position
        self.fontColor = color
        self.zPosition = zPosition.rawValue
        
        self.fontName = "Chubby Cheeks"
    }
}
