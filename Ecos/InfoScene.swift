//
//  InfoScene.swift
//  Ecos
//
//  Created by Edvaldo Junior on 11/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import UIKit
import SpriteKit

class InfoScene: SKScene {

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
        
        spreadLabels()
        createBackButton()
    }
    
    func spreadLabels() {
        
        //TODO: Fazer isso de um jeito inteligente, com um vetor de nomes
     
        let developers = InfoLabel(text: "Desenvolvedores")
        developers.set(fontSize: size.height * 0.06, position: CGPoint(x: size.width/2, y: size.height * 0.93), fontColor: .black, zPosition: .front)
        addChild(developers)
        
        let daniel = InfoLabel(text: "Daniel")
        daniel.set(fontSize: size.height * 0.05, position: CGPoint(x: size.width/2, y: size.height * 0.83), fontColor: .white, zPosition: .front)
        addChild(daniel)
        
        let edy = InfoLabel(text: "Edvaldo")
        edy.set(fontSize: size.height * 0.05, position: CGPoint(x: size.width/2, y: size.height * 0.73), fontColor: .white, zPosition: .front)
        addChild(edy)
        
        let gustavo = InfoLabel(text: "Gustavo")
        gustavo.set(fontSize: size.height * 0.05, position: CGPoint(x: size.width/2, y: size.height * 0.63), fontColor: .white, zPosition: .front)
        addChild(gustavo)
        
        let designers = InfoLabel(text: "Designers")
        designers.set(fontSize: size.height * 0.06, position: CGPoint(x: size.width/2, y: size.height * 0.53), fontColor: .black, zPosition: .front)
        addChild(designers)
        
        let daniel2 = InfoLabel(text: "Daniel")
        daniel2.set(fontSize: size.height * 0.05, position: CGPoint(x: size.width/2, y: size.height * 0.43), fontColor: .white, zPosition: .front)
        addChild(daniel2)
        
        let gustavo2 = InfoLabel(text: "Gustavo")
        gustavo2.set(fontSize: size.height * 0.05, position: CGPoint(x: size.width/2, y: size.height * 0.33), fontColor: .white, zPosition: .front)
        addChild(gustavo2)
        
        let douglas = InfoLabel(text: "Douglas")
        douglas.set(fontSize: size.height * 0.05, position: CGPoint(x: size.width/2, y: size.height * 0.23), fontColor: .white, zPosition: .front)
        addChild(douglas)
        
        let musician = InfoLabel(text: "Músico")
        musician.set(fontSize: size.height * 0.06, position: CGPoint(x: size.width/2, y: size.height * 0.13), fontColor: .black, zPosition: .front)
        addChild(musician)
        
        let pericles = InfoLabel(text: "Péricles")
        pericles.set(fontSize: size.height * 0.05, position: CGPoint(x: size.width/2, y: size.height * 0.03), fontColor: .white, zPosition: .front)
        addChild(pericles)
    }
    
    func createBackButton() {
        
        let backButton = MenuButton(defaultButtonImage: "backButton", activeButtonImage: "backButton", labelName: "Voltar", buttonAction: backToMenu)
        
        let sizeButton = CGSize(width: size.width * 0.07, height: size.width * 0.07)
        let labelSize = sizeButton.width / 3
        
        let positionButton = CGPoint(x: size.width * 0.1, y: size.height * 0.9)
        let labelPosition = CGPoint(x: 0, y: -sizeButton.width)
        
        backButton.setSizeAndPosition(sizeButton, position: positionButton, labelSize: labelSize, labelPosition: labelPosition)
        
        backButton.zPosition = Position.front.rawValue
        //backButton.action = backToMenu
        addChild(backButton)
    }
    
    func backToMenu(button: Button) {
        
        print("VOLTRA")
        let first = FirstScene(size: size)
        view?.presentScene(first, transition: .flipHorizontal(withDuration: 0.5))
    }
}
