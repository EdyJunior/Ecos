//
//  FirstScene.swift
//  Ecos
//
//  Created by Edvaldo Junior on 06/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import UIKit
import SpriteKit

class FirstScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "BlueBack")
    var character = SKSpriteNode(imageNamed: "GloriaWalking000")
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .white
        buildScene()
    }
    
    func buildScene() {
        background.size = size
        background.zPosition = Position.front.rawValue
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.alpha = 0.75
        addChild(background)
    }
}
