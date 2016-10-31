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
        
        backgroundColor = .black
        createCardPicker()
        createBackButton()
    }
    
    func createCardPicker() {
        
        let cardsNames = [Key.waterTapCard.rawValue, Key.trashCard.rawValue, Key.trashCanCard.rawValue]//, Key.tvCard.rawValue, Key.lampCard.rawValue]
        var cards = [Button]()
        
        for nameCard in cardsNames {

            let sizeCard = CGSize(width: self.size.width * 0.5, height: self.size.height * 0.8)
            let card: Card = Card(defaultButtonImage: nameCard, activeButtonImage: nameCard)
            card.setSizeAndPosition(sizeCard, position: CGPoint.zero, areaFactor: 1)
            
            if let value = defaults.object(forKey: nameCard) {
                let locked = value as! Bool
                if locked {
                    card.lockCard()
                }
            } else {
                defaults.set(true, forKey: nameCard)
                card.lockCard()
            }
            cards.append(card)
        }
        
        let cardPicker = SpritePicker(withView: view!, withSprites: cards, withNames: cardsNames)
        cardPicker.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(cardPicker)
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
}
