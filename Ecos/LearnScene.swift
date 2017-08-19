//
//  LearnScene.swift
//  Ecos
//
//  Created by Edvaldo Junior on 22/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class LearnScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        backgroundColor = .white
        buildScene()
    }
    
    func buildScene() {
        
        let background = SKSpriteNode(imageNamed: "greenBack")
        background.zPosition = Position.deepest.rawValue
        background.size = size
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.alpha = 0.75
        addChild(background)
        
        createCards()
        createBackButton()
    }
    
    func createCards() {
        
        let cardsNames = [Key.waterTapCard.rawValue, Key.trashCard.rawValue, Key.trashCanCard.rawValue]//, Key.tvCard.rawValue, Key.lampCard.rawValue]
        let cardText = [
            "Turn off 20",
            "water taps",
            "Pick up",
            "150 trash",
            "Throw away",
            "150 trash"
        ]
        var i = 0
        var pos: CGFloat = 0.2
        
        for nameCard in cardsNames {
            
            let sizeCard = CGSize(width: self.size.width * 0.2, height: self.size.height * 0.48)
            let labelPosition = CGPoint(x: 0, y: -sizeCard.height * 0.8)
            let card: Card = Card(defaultButtonImage: "medal", activeButtonImage: "medal", text: cardText[i])
            let label = InfoLabel(text: cardText[i + 1])
            label.set(fontSize: sizeCard.height * 0.2, position: CGPoint(x: labelPosition.x, y: labelPosition.y - scene!.size.height * 0.08), fontColor: niceGreen, zPosition: .front)
            i += 2
            card.setSizeAndPosition(sizeCard, position: CGPoint(x: pos * scene!.size.width, y: scene!.size.height * 0.5), labelSize: sizeCard.height * 0.2, labelPosition: labelPosition, labelColor: niceGreen)
            pos += 0.3
            
            if let value = defaults.object(forKey: nameCard) {
                let locked = value as! Bool
                if locked {
                    card.lockCard()
                }
            } else {
                defaults.set(true, forKey: nameCard)
                card.lockCard()
            }
            card.zPosition = Position.middle.rawValue
            card.name = nameCard
            addChild(card)
            card.touchableArea.addChild(label)
        }
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
        view?.presentScene(first, transition: .fade(withDuration: 0.5))
    }
}
