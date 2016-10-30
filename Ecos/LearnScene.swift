//
//  LearnScene.swift
//  Ecos
//
//  Created by Edvaldo Junior on 22/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class LearnScene: SKScene {

    var cardPicker: SpritePicker?
    
    override func didMove(to view: SKView) {
        
        backgroundColor = .black
        createCardPicker()
        createBackButton()
    }
    
    func createCardPicker() {
        
        let cardsNames = [Key.waterTapCard.rawValue, Key.trashCard.rawValue, Key.trashCanCard.rawValue]//, Key.tvCard.rawValue, Key.lampCard.rawValue]
        var cards = [Button]()
        
        for nameCard in cardsNames {

            let sizeCard = CGSize(width: self.size.width * 0.2, height: self.size.height * 0.8)
            let card: Card
            
            if let value = defaults.object(forKey: nameCard) {
                let locked = value as! Bool
                card = Card(defaultButtonImage: nameCard, activeButtonImage: nameCard, locked: locked)
            } else {
                defaults.set(true, forKey: nameCard)
                card = Card(defaultButtonImage: nameCard, activeButtonImage: nameCard, locked: true)
            }
            card.setSizeAndPosition(sizeCard, position: CGPoint.zero, areaFactor: 1)
            cards.append(card)
        }
        
        cardPicker = SpritePicker(withView: view!, withSprites: cards, withNames: cardsNames)
        cardPicker!.position = CGPoint(x: size.width * 0.4, y: size.height * 0.5)
        addChild(cardPicker!)
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










/*
 if let plist = Plist(name: "CardList") {
 let dict = plist.getMutablePlistFile()!
 do {
 try plist.addValuesToPlistFile(dictionary: dict)
 } catch {
 print(error)
 }
 
 print(plist.getValuesInPlistFile())
 } else {
 print("Unable to get Plist")
 }
 */

//        if let path = Bundle.main.path(forResource: "CardList", ofType: "plist") {
//            if let dic = NSDictionary(contentsOfFile: path) as? [String: String] {
//                print("\n\nOBJECT = \(dic["CloseWaterTapCard"])")
//            }
//        }
