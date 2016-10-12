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
    
    let collaborators = ["Desenvolvedores", "Daniel", "Edvaldo", "Gustavo", "Designers", "Daniel", "Douglas", "Gustavo", "Músico", "Péricles"]

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
        
        var i: CGFloat = CGFloat(0.93)
        
        var valuesHeight = [CGFloat]()
        while !i.isLess(than: CGFloat(0)) {
            valuesHeight.append(CGFloat(i))
            i.subtract(CGFloat(0.10))
        }
        let valuesCollaborators: [CGFloat] = [valuesHeight[0], valuesHeight[4], valuesHeight[8]]
        i = valuesHeight.first!
        var count: Int = 1
        
        for name in collaborators {
            let collaborator = InfoLabel(text: name)
            let multi: CGFloat = valuesCollaborators.contains(i) ? CGFloat(0.06) : CGFloat(0.05)
            
            let color: UIColor = (multi.isEqual(to: CGFloat(0.06)) ? .black : .white)
            
            collaborator.set(fontSize: size.height * multi, position: CGPoint(x: size.width/2, y: size.height * i), fontColor: color, zPosition: .front)
            addChild(collaborator)
            
            i = valuesHeight[count]
            count += count < valuesHeight.count - 1 ? 1 : 0
        }
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
        view?.presentScene(first, transition: .flipVertical (withDuration: 0.5))
    }
}
