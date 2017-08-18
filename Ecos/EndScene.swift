//
//  EndScene.swift
//  Ecos
//
//  Created by Edvaldo Junior on 17/08/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class EndScene: SKScene {

    override func didMove(to view: SKView) {
        
        self.backgroundColor = .white
        buildScene()
    }
    
    func buildScene() {
        
        let background = SKSpriteNode(imageNamed: "blueBack")
        background.size = size
        background.zPosition = Position.deepest.rawValue
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.alpha = 0.75
        addChild(background)
       
        
    }
}
