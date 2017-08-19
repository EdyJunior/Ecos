//
//  EndScene.swift
//  Ecos
//
//  Created by Edvaldo Junior on 17/08/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class EndScene: SKScene {
    
    var won: Bool = true
    
    init(size: CGSize, won: Bool) {
        
        self.won = won
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func didMove(to view: SKView) {
        
        self.backgroundColor = .white
        buildScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let preGame = PreGameScene(size: size)
        view?.presentScene(preGame, transition: .push(with: .right, duration: 0.5))
    }
    
    func buildScene() {
        
        let background = SKSpriteNode(imageNamed: "blueBack")
        background.size = size
        background.zPosition = Position.deepest.rawValue
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.alpha = 0.75
        addChild(background)
       
        setupLabels()
    }
    
    func setupLabels() {
        
        var labels = [InfoLabel]()
        var labelsPositions = [CGPoint]()
        
        if won {
            labels = [
                InfoLabel(text: "Congratulations!"),
                InfoLabel(text: "You saved the World!")
            ]
            labelsPositions = [
                CGPoint(x: size.width / 2, y: size.height * 0.3),
                CGPoint(x: size.width / 2, y: size.height * 0.7)
            ]
            
            for (index, label) in labels.enumerated() {
                label.set(fontSize: size.height * 0.2, position: labelsPositions[index], fontColor: .white, zPosition: .middle)
                addChild(label)
            }
        } else {
            labels = [
                InfoLabel(text: "Well... It seems"),
                InfoLabel(text: "that you didn't"),
                InfoLabel(text: "understand the idea."),
                InfoLabel(text: "Try to set up the"),
                InfoLabel(text: "tutorial mode in"),
                InfoLabel(text: "configuration window")
            ]
            labelsPositions = [
                CGPoint(x: size.width / 2, y: size.height * 0.15),
                CGPoint(x: size.width / 2, y: size.height * 0.3),
                CGPoint(x: size.width / 2, y: size.height * 0.45),
                CGPoint(x: size.width / 2, y: size.height * 0.6),
                CGPoint(x: size.width / 2, y: size.height * 0.75),
                CGPoint(x: size.width / 2, y: size.height * 0.9)
            ]
            
            for (index, label) in labels.enumerated() {
                label.set(fontSize: size.height * 0.15, position: labelsPositions[index], fontColor: .white, zPosition: .middle)
                addChild(label)
            }
        }
    }
}
