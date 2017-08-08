//
//  ConfigScene.swift
//  Ecos
//
//  Created by Edvaldo Junior on 18/07/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class ConfigScene: SKScene {

    var plusBtn = Button(defaultButtonImage: "plus", activeButtonImage: "plus")
    var minusBtn = Button(defaultButtonImage: "minus", activeButtonImage: "minus")
    var funBox = CheckBox(withSize: CGSize.zero, position: CGPoint.zero, andBoolKey: "")
    var tutorialBox = CheckBox(withSize: CGSize.zero, position: CGPoint.zero, andBoolKey: "")
        
    var cells = [SKSpriteNode]()
    
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
        buildControlButtons()
        buildCells()
        buildCheckBox()
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
        
        let speedLabel = InfoLabel(text: "Speed")
        let funModeLabel = InfoLabel(text: "Fun Mode")
        let tutorialModeLabel = InfoLabel(text: "Tutorial Mode")
        
        let color: UIColor = .white
        
        speedLabel.set(fontSize: size.height * 0.1, position: CGPoint(x: size.width/2, y: size.height * 0.87), fontColor: color, zPosition: .front)
        funModeLabel.set(fontSize: size.height * 0.1, position: CGPoint(x: size.width * 0.3, y: size.height * 0.4), fontColor: color, zPosition: .front)
        tutorialModeLabel.set(fontSize: size.height * 0.1, position: CGPoint(x: size.width * 0.7, y: size.height * 0.4), fontColor: color, zPosition: .front)
        
        addChild(speedLabel)
        addChild(funModeLabel)
        addChild(tutorialModeLabel)
    }
    
    func buildControlButtons() {
        
        let sizePlus = CGSize(width: size.width * 0.07, height: size.height * 0.12)
        let sizeMinus = CGSize(width: size.width * 0.07, height: size.height * 0.03)
        let positionPlus = CGPoint(x: frame.width * 0.75, y: frame.height * 0.7)
        let positionMinus = CGPoint(x: frame.width * 0.25, y: frame.height * 0.7)
        
        plusBtn.setSizeAndPosition(sizePlus, position: positionPlus, areaFactor: 1.1)
        minusBtn.setSizeAndPosition(sizeMinus, position: positionMinus, areaFactor: 1.1)
        
        plusBtn.touchableArea.zPosition = Position.top.rawValue
        minusBtn.touchableArea.zPosition = Position.top.rawValue
        
        plusBtn.action = touchPlus
        minusBtn.action = touchMinus
        
        addChild(plusBtn)
        addChild(minusBtn)
    }
    
    func buildCells() {
        
        let w = frame.width
        let h = frame.height
        let cellPositions: [CGPoint] = [CGPoint(x: w * 0.35, y: h * 0.7), CGPoint(x: w * 0.45, y: h * 0.7), CGPoint(x: w * 0.55, y: h * 0.7), CGPoint(x: w * 0.65, y: h * 0.7)]
        
        if defaults.object(forKey: Key.speed.rawValue) == nil {
            defaults.set(2, forKey: Key.speed.rawValue)
        }
        
        for pos in cellPositions {
            let cell = SKSpriteNode(imageNamed: "cell")
            cell.position = pos
            cell.size = CGSize(width: size.width * 0.075, height: size.width * 0.1)
            cell.zPosition = Position.front.rawValue
            cells.append(cell)
            addChild(cell)
        }
        updateCells()
    }
    
    func buildCheckBox() {
        
        let w = frame.width
        let h = frame.height
        
        if defaults.object(forKey: Key.fun.rawValue) == nil {
            defaults.set(false, forKey: Key.fun.rawValue)
        }
        if defaults.object(forKey: Key.tutorial.rawValue) == nil {
            defaults.set(true, forKey: Key.tutorial.rawValue)
        }
        
        funBox = CheckBox(withSize: CGSize(width: w * 0.15, height: w * 0.15), position: CGPoint(x: w * 0.3, y: h * 0.2), andBoolKey: Key.fun.rawValue)
        tutorialBox = CheckBox(withSize: CGSize(width: w * 0.15, height: w * 0.15), position: CGPoint(x: w * 0.7, y: h * 0.2), andBoolKey: Key.tutorial.rawValue)
        
        addChild(funBox)
        addChild(tutorialBox)
    }
    
    func updateCells() {
        
        if let val = defaults.object(forKey: Key.speed.rawValue) as? Int {
            for i in 0..<val {
                cells[i].texture = SKTexture(imageNamed: "fullCell")
            }
            for i in val..<4 {
                cells[i].texture = SKTexture(imageNamed: "cell")
            }
        }
    }
    
    func touchPlus(_ button: Button) {
        
        if let val = defaults.object(forKey: Key.speed.rawValue) as? Int {
            if val < 4 {
                defaults.set(val + 1, forKey: Key.speed.rawValue)
                updateCells()
            }
        }
    }
    
    func touchMinus(_ button: Button) {
        
        if let val = defaults.object(forKey: Key.speed.rawValue) as? Int {
            if val > 1 {
                defaults.set(val - 1, forKey: Key.speed.rawValue)
                updateCells()
            }
        }
    }
}
