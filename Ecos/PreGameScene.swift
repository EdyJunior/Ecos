//
//  PreGameScene.swift
//  Ecos
//
//  Created by Edvaldo Junior on 12/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class PreGameScene: SKScene {

    var bestScoreLabel = InfoLabel()
    var lastScoreLabel = InfoLabel()
    var charactersNameLabel = InfoLabel()
    
    var spritePicker: SpritePicker!
    
    let labelsColor = UIColor.init(red: 23/255, green: 136/255, blue: 23/255, alpha: 1)
    
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
        
        createStartButton()
        createBackButton()
        createLabels()
        createSpritePicker()
    }
    
    func createStartButton() {
        
        let buttonStartSize = CGSize(width: size.width * 0.25, height: size.height * 0.45)
        let buttonStartPosition = CGPoint(x: size.width * 0.85, y: size.height * 0.45)
        
        let labelStartSize = buttonStartSize.height * 0.1
        let labelStartposition = CGPoint(x: 0, y: -buttonStartSize.height * 0.65)
        
        let startButton = MenuButton(defaultButtonImage: "play2", activeButtonImage: "play2", labelName: "Começar", buttonAction: touchedStart)
        startButton.setSizeAndPosition(buttonStartSize, position: buttonStartPosition, labelSize: labelStartSize, labelPosition: labelStartposition, labelColor: labelsColor)
        startButton.touchableArea.zPosition = Position.top.rawValue
        
        startButton.defaultButton.run(SKAction.repeatForever(SKAction.sequence(
            [SKAction.scale(by: size.width / 600, duration: 1),
             SKAction.scale(by: 600 / size.width, duration: 1)]
        )))
        
        addChild(startButton)
    }
    
    func touchedStart(button: Button) {
        
        let gameScene = GameScene(size: size)
        view?.presentScene(gameScene, transition: .push(with: .left, duration: 0.5))
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
        view?.presentScene(first, transition: .doorsCloseVertical(withDuration: 0.5))
    }
    
    func createLabels() {
        
        let labelsSize = size.height * 0.05
        
        let lastScorePos = CGPoint(x: size.width * 0.35, y: size.height * 0.85)
        let bestScorePos = CGPoint(x: size.width * 0.75, y: size.height * 0.85)
        let charactersNamePos = CGPoint(x: size.width * 0.4, y: size.height * 0.1)
        
        lastScoreLabel = InfoLabel(text: "Última pontuação:  0")
        lastScoreLabel.set(fontSize: labelsSize, position: lastScorePos, fontColor: labelsColor, zPosition: .front)
        addChild(lastScoreLabel)
        
        bestScoreLabel = InfoLabel(text: "Melhor pontuação:  0")
        bestScoreLabel.set(fontSize: labelsSize, position: bestScorePos, fontColor: labelsColor, zPosition: .front)
        addChild(bestScoreLabel)
        
        charactersNameLabel = InfoLabel(text: "Nome:  Glória")
        charactersNameLabel.set(fontSize: labelsSize, position: charactersNamePos, fontColor: labelsColor, zPosition: .front)
        addChild(charactersNameLabel)
    }
    
    func createSpritePicker() {
        
        let charactersNames = ["Gloria", "Gloriosinho"]
        var characters = [SKSpriteNode]()
        
        for name in charactersNames {
            let character = SKSpriteNode(imageNamed: "\(name)0")
            character.size = CGSize(width: size.width * 0.25, height: size.height * 0.5)
            character.position = CGPoint(x: 0, y: 0)
            character.zPosition = Position.front.rawValue
            characters.append(character)
        }
        
        spritePicker = SpritePicker(withView: view!, withSprites: characters)
        spritePicker.position = CGPoint(x: size.width * 0.4, y: size.height * 0.5)
        addChild(spritePicker)
    }
}