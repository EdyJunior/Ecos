//
//  ConfigScene.swift
//  Ecos
//
//  Created by Edvaldo Junior on 18/07/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class ConfigScene: SKScene {

    override func didMove(to view: SKView) {
        
        self.backgroundColor = .white
        buildScene()
    }
    
    func buildScene() {
        
        let background = SKSpriteNode(imageNamed: "greenBack")
        background.zPosition = Position.deepest.rawValue
        background.size = size
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.alpha = 0.75
        addChild(background)
        
        createBackButton()
        createLabels()
    }
    
    func createBackButton() {
        
        let backButton = MenuButton(defaultButtonImage: "backButton", activeButtonImage: "backButton", labelName: "Voltar", buttonAction: backToMenu)
        
        let sizeButton = CGSize(width: size.width * 0.07, height: size.width * 0.07)
        let labelSize = sizeButton.width / 3
        
        let positionButton = CGPoint(x: size.width * 0.1, y: size.height * 0.9)
        let labelPosition = CGPoint(x: 0, y: -sizeButton.width)
        
        backButton.setSizeAndPosition(sizeButton, position: positionButton, labelSize: labelSize, labelPosition: labelPosition)
        
        backButton.touchableArea.zPosition = Position.top.rawValue
        addChild(backButton)
    }
    
    func backToMenu(button: Button) {
        
        let first = FirstScene(size: size)
        view?.presentScene(first, transition: .push(with: .left, duration: 0.5))
    }
    
    func createLabels() {
        
        let labelsSize = size.height * 0.05
        
        let lastScorePos = CGPoint(x: size.width * 0.35, y: size.height * 0.85)
        let bestScorePos = CGPoint(x: size.width * 0.75, y: size.height * 0.85)
        let charactersNamePos = CGPoint(x: size.width * 0.4, y: size.height * 0.1)
        
        var lastScore = String()
        if defaults.object(forKey: Key.lastScore.rawValue) == nil{
            defaults.set(0, forKey: Key.lastScore.rawValue)
            lastScore = "0"
        } else {
            lastScore = "\(defaults.object(forKey: Key.lastScore.rawValue) as! Int)"
        }
        
        var bestScore = String()
        if defaults.object(forKey: Key.bestScore.rawValue) == nil{
            defaults.set(0, forKey: Key.bestScore.rawValue)
            bestScore = "0"
        } else {
            bestScore = "\(defaults.object(forKey: Key.bestScore.rawValue) as! Int)"
        }
    }
}
