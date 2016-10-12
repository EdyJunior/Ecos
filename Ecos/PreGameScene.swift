//
//  PreGameScene.swift
//  Ecos
//
//  Created by Edvaldo Junior on 12/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class PreGameScene: SKScene {

    var maxScoreLabel = SKLabelNode()
    var lastScoreLabel = SKLabelNode()
    var characterShowed = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        buildScene()
    }
    
    func buildScene() {
        //self.backgroundColor = .white
        createStartButton()
        createBackButton()
    }
    
    func createStartButton() {
        
        let buttonStartSize = CGSize(width: size.width * 0.25, height: size.height * 0.4)
        let buttonStartPosition = CGPoint(x: size.width * 0.85, y: size.height * 0.45)
        
        let labelStartSize = buttonStartSize.height * 0.15
        let labelStartposition = CGPoint(x: 0, y: -buttonStartSize.height * 0.65)
        
        let startButton = MenuButton(defaultButtonImage: "play2", activeButtonImage: "play2", labelName: "Começar", buttonAction: touchedStart)
        startButton.setSizeAndPosition(buttonStartSize, position: buttonStartPosition, labelSize: labelStartSize, labelPosition: labelStartposition)
        addChild(startButton)
    }
    
    func touchedStart(button: Button) {
        
        let gameScene = GameScene(size: size)
        view?.presentScene(gameScene, transition: .push(with: .right, duration: 0.5))
    }
    
    func createBackButton() {
        
        let backButton = MenuButton(defaultButtonImage: "backButton", activeButtonImage: "backButton", labelName: "Voltar", buttonAction: backToMenu)
        
        let sizeButton = CGSize(width: size.width * 0.07, height: size.width * 0.07)
        let labelSize = sizeButton.width / 3
        
        let positionButton = CGPoint(x: size.width * 0.1, y: size.height * 0.9)
        let labelPosition = CGPoint(x: 0, y: -sizeButton.width)
        
        backButton.setSizeAndPosition(sizeButton, position: positionButton, labelSize: labelSize, labelPosition: labelPosition)
        
        backButton.zPosition = Position.front.rawValue
        addChild(backButton)
    }
    
    func backToMenu(button: Button) {
        
        let first = FirstScene(size: size)
        view?.presentScene(first, transition: .doorsCloseVertical(withDuration: 0.5))
    }
}
