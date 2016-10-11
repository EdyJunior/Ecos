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
    
    let background = SKSpriteNode(imageNamed: "blueBack")
    var character = SKSpriteNode(imageNamed: "GloriaWalking000")
    
    var playButton = Button(defaultButtonImage: "play1", activeButtonImage: "play1")
    var configButton = Button(defaultButtonImage: "config", activeButtonImage: "config")
    var learnButton = Button(defaultButtonImage: "learn", activeButtonImage: "learn")
    var infoButton = Button(defaultButtonImage: "info", activeButtonImage: "info")
    
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
        
        createButtons()
    }
    
    func createButtons() {
        let sizePlayButton = CGSize(width: background.size.width * 0.4, height: background.size.height * 0.5)
        let sizeButtons = CGSize(width: background.size.width * 0.1, height: background.size.height * 0.15)
        let positionPlay = CGPoint(x: frame.width * 0.2, y: frame.height * 0.5)
        let positionLearn = CGPoint(x: frame.width * 0.4, y: frame.height * 0.3)
        let positionConfig = CGPoint(x: frame.width * 0.65, y: frame.height * 0.3)
        let positionInfo = CGPoint(x: frame.width * 0.9, y: frame.height * 0.3)
        
        playButton.setSizeAndPosition(sizePlayButton, position: positionPlay, areaFactor: 1)
        learnButton.setSizeAndPosition(sizeButtons, position: positionLearn, areaFactor: 1)
        configButton.setSizeAndPosition(sizeButtons, position: positionConfig, areaFactor: 1)
        infoButton.setSizeAndPosition(sizeButtons, position: positionInfo, areaFactor: 1)
        
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
    
    func touchPlay(_ button: Button) {
        print("Play")
    }
    
    func touchConfig(_ button: Button) {
        print("Config")
    }
    
    func touchLearn(_ button: Button) {
        print("Learn")
    }
    
    func touchInfo(_ button: Button) {
        print("Info")
    }
}
