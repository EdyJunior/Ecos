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
    
    var playButton = MenuButton(defaultButtonImage: "play1", activeButtonImage: "play1", labelName: "Jogar!")
    var configButton = MenuButton(defaultButtonImage: "config", activeButtonImage: "config", labelName: "Configurar")
    var learnButton = MenuButton(defaultButtonImage: "learn", activeButtonImage: "learn", labelName: "Aprender")
    var infoButton = MenuButton(defaultButtonImage: "info", activeButtonImage: "info", labelName: "Info")
    
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
        
        createButtons()
        createCharacter()
    }
    
    func createButtons() {
        
        let sizePlayButton = CGSize(width: size.width * 0.3, height: size.height * 0.5)
        let sizeButtons = CGSize(width: size.width * 0.1, height: size.height * 0.15)
        let positionPlay = CGPoint(x: frame.width * 0.16, y: frame.height * 0.5)
        let positionLearn = CGPoint(x: frame.width * 0.45, y: frame.height * 0.25)
        let positionConfig = CGPoint(x: frame.width * 0.7, y: frame.height * 0.25)
        let positionInfo = CGPoint(x: frame.width * 0.9, y: frame.height * 0.25)
        
        let labelPositionPlay = CGPoint(x: 0, y: -sizePlayButton.height * 0.8)
        let labelPositionButtons = CGPoint(x: 0, y: -sizeButtons.height)
        
        playButton.setSizeAndPosition(sizePlayButton, position: positionPlay, labelSize: sizePlayButton.height * 0.3, labelPosition: labelPositionPlay)
        learnButton.setSizeAndPosition(sizeButtons, position: positionLearn, labelSize: sizeButtons.height * 0.4, labelPosition: labelPositionButtons)
        configButton.setSizeAndPosition(sizeButtons, position: positionConfig, labelSize: sizeButtons.height * 0.4, labelPosition: labelPositionButtons)
        infoButton.setSizeAndPosition(sizeButtons, position: positionInfo, labelSize: sizeButtons.height * 0.4, labelPosition: labelPositionButtons)
        
        playButton.touchableArea.zPosition = Position.top.rawValue
        learnButton.touchableArea.zPosition = Position.top.rawValue
        configButton.touchableArea.zPosition = Position.top.rawValue
        infoButton.touchableArea.zPosition = Position.top.rawValue
        
        playButton.action = touchPlay
        learnButton.action = touchLearn
        configButton.action = touchConfig
        infoButton.action = touchInfo
        
        addChild(playButton)
        addChild(learnButton)
        addChild(configButton)
        addChild(infoButton)
    }
    
    func createCharacter() {
        
        //TODO: o personagem mostrado na primeira tela será o que foi escolhido da última vez pelo usuário
        let character = SKSpriteNode(imageNamed: "Gloria0")
        character.size = CGSize(width: size.width * 0.2, height: size.height * 0.5)
        character.position = CGPoint(x: size.width * 0.7, y: size.height * 0.65)
        character.zPosition = Position.front.rawValue
        
        let atlas = SKTextureAtlas(named: "Gloria")
        var frames = [SKTexture]()
        
        for textureName in atlas.textureNames {
            frames.append(atlas.textureNamed(textureName))
        }
        character.run(SKAction.repeatForever(
            SKAction.animate(with: frames,
                             timePerFrame: 0.3,
                             resize: false,
                             restore: true)
            )
        )
        addChild(character)
    }
    
    func touchPlay(_ button: Button) {
        print("Play")
        let preGameScene = PreGameScene(size: size)
        view?.presentScene(preGameScene, transition: .doorsOpenVertical(withDuration: 0.5))
    }
    
    func touchConfig(_ button: Button) {
        print("Config")
    }
    
    func touchLearn(_ button: Button) {
        print("Learn")
    }
    
    func touchInfo(_ button: Button) {
        print("Info")
        let infoScene = InfoScene(size: size)
        view?.presentScene(infoScene, transition: .flipVertical(withDuration: 0.5))
    }
    
    
}
