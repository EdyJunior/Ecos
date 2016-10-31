//
//  GameScene.swift
//  Ecos
//
//  Created by Edvaldo Junior on 06/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: InfoLabel!
    var playerNameLabel: InfoLabel!
    var playerName = String()
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "\(score)"
            defaults.set(score, forKey: Key.lastScore.rawValue)
            guard let currentBest = defaults.object(forKey: Key.bestScore.rawValue) as? Int else {
                return
            }
            if score > currentBest {
                defaults.set(score, forKey: Key.bestScore.rawValue)
            }
        }
    }
    
    //var pauseButton: MenuButton!

    var gameCamera = SKCameraNode()
    var gameOver = false
    var won = false
    var isTutoring = true
    var landscape: Landscape!
    var player: Player!
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        playerName = defaults.object(forKey: Key.previousCharacter.rawValue) as! String
        self.camera = self.gameCamera
        buildScene()
    }
    
    func buildScene() {
        
        self.backgroundColor = .black
        
        createLandscape()
        createPlayer()
        createLabels()
        createPauseButton()
    }
    
    func createLandscape() {
    
        landscape = Landscape(sceneSize: size)
        landscape.position = CGPoint(x: size.width / 2 + size.width * 1.3, y: size.height / 2)
        landscape.zPosition = Position.deepest.rawValue
        addChild(landscape)
        landscape.createTutorials()
    }
    
    func createPlayer() {
        
        let sizePlayer = CGSize(width: size.width * 0.15, height: size.height * 0.4)
        let positonPlayer = CGPoint(x: size.width/2, y: size.height/2)
        
        player = Player(imageNamed: "\(playerName)0")
        player.initialize(sizePlayer, position: positonPlayer, zPosition: Position.middle.rawValue, scene: self, character: playerName)
        
        player.trashBag = TrashBag(sceneSize: size)
        player.trashBag?.position = CGPoint(x: -size.width * 0.25, y: -size.height * 0.35)
        gameCamera.position.y = size.height * 0.05
        player.addChild(gameCamera)
        self.gameCamera.addChild(player.trashBag!)
        
        player.walk()
    }
    
    func createLabels() {
        
        scoreLabel = InfoLabel(text: "0")
        scoreLabel.set(fontSize: size.height * 0.15, position: CGPoint(x: size.width * 0.43, y: -size.height * 0.45), fontColor: niceGreen, zPosition: Position.middle)
        self.gameCamera.addChild(scoreLabel)
        
        if playerName == "Gloria" {
            playerName = "Glória"
        } else if playerName == "Gloriosinho" {
            playerName = "Gloriosinho"
        }
        playerNameLabel = InfoLabel(text: playerName)
        playerNameLabel.set(fontSize: size.height * 0.1, position: CGPoint(x: size.width * 0.15, y: -size.height * 0.45) , fontColor: niceGreen, zPosition: Position.middle)
        self.gameCamera.addChild(playerNameLabel)
    }
    
    func createPauseButton() {
        
        //TODO: Posicionar o backButton em um lugar difícil de ser clicado acidentalmente
        
        let pauseButton = MenuButton(defaultButtonImage: "pause", activeButtonImage: "pause", labelName: "Pausar", buttonAction: pauseGame)
        
        let sizeButton = CGSize(width: size.width * 0.07, height: size.width * 0.07)
        let labelSize = sizeButton.width / 3
        
        let positionButton = CGPoint(x: size.width * 0.35, y: size.height * 0.35)
        let labelPosition = CGPoint(x: 0, y: -sizeButton.width)
        
        pauseButton.setSizeAndPosition(sizeButton, position: positionButton, labelSize: labelSize, labelPosition: labelPosition, labelColor: niceGreen)
        
        pauseButton.zPosition = Position.front.rawValue
        self.gameCamera.addChild(pauseButton)
    }
    
    func pauseGame(button: Button) {
        
        self.isPaused = true
        
        let blackBack = SKSpriteNode(imageNamed: "blackBack")
        blackBack.alpha = 0.7
        blackBack.size = size
        blackBack.position = CGPoint(x: 0, y: 0)
        blackBack.zPosition = Position.front.rawValue
        
        let sizeButton = CGSize(width: size.width * 0.6, height: size.width * 0.15)
        let resumePos = CGPoint(x: 0, y: scene!.size.height/5)
        let backPos = CGPoint(x: 0, y: -scene!.size.height/5)
        
        let back = Button(defaultButtonImage: "back", activeButtonImage: "back", buttonAction: backButton)
        back.setSizeAndPosition(sizeButton, position: backPos, areaFactor: 1)
        back.name = "Back"
        back.touchableArea.zPosition = Position.highlighted.rawValue
        
        let resume = Button(defaultButtonImage: "play3", activeButtonImage: "play3", buttonAction: resumeButton)
        resume.setSizeAndPosition(sizeButton, position: resumePos, areaFactor: 1)
        resume.name = "Resume"
        resume.touchableArea.zPosition = Position.highlighted.rawValue
        
        let container = SKNode()
        
        container.addChild(resume)
        container.addChild(back)
        container.addChild(blackBack)
        gameCamera.addChild(container)
    }
    
    func backButton(button: Button) {
        
        let preGameScene = PreGameScene(size: size)
        view?.presentScene(preGameScene, transition: .push(with: .right, duration: 0.5))
    }
    
    func resumeButton(button: Button) {
        
        let buttonParent = button.parent
        buttonParent?.removeFromParent()
        self.isPaused = false
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if firstBody.categoryBitMask == BodyType.door.rawValue && secondBody.categoryBitMask == BodyType.player.rawValue {
            firstBody.categoryBitMask = 0
            landscape.render()
        }
        if firstBody.categoryBitMask == BodyType.player.rawValue && secondBody.categoryBitMask == BodyType.door.rawValue {
            secondBody.categoryBitMask = 0
            landscape.render()
        }
        
        if firstBody.categoryBitMask == BodyType.obstacle.rawValue && secondBody.categoryBitMask == BodyType.player.rawValue {
            print("OBSTACulo")
        }
        if firstBody.categoryBitMask == BodyType.player.rawValue && secondBody.categoryBitMask == BodyType.obstacle.rawValue {
            print("OBSTACulo")
        }
        
        if (firstBody.categoryBitMask == BodyType.ground.rawValue && secondBody.categoryBitMask == BodyType.player.rawValue) ||
           (firstBody.categoryBitMask == BodyType.player.rawValue && secondBody.categoryBitMask == BodyType.ground.rawValue){
            player.jumping = false
        }
        
        //Tutorials Triggers
        
        if firstBody.categoryBitMask == BodyType.tapTrigger.rawValue && secondBody.categoryBitMask == BodyType.player.rawValue {
            print("tapTrigger")
            firstBody.categoryBitMask = 0
            landscape.tutorial?.start(button: landscape.firstBathroom.waterTap!, text: "Desligue a torneira!")
        }
        if firstBody.categoryBitMask == BodyType.player.rawValue && secondBody.categoryBitMask == BodyType.tapTrigger.rawValue {
            print("tapTrigger")
            secondBody.categoryBitMask = 0
            landscape.tutorial?.start(button: landscape.firstBathroom.waterTap!, text: "Desligue a torneira!")
        }
        
        if firstBody.categoryBitMask == BodyType.trashTrigger.rawValue && secondBody.categoryBitMask == BodyType.player.rawValue {
            print("trashTrigger")
            firstBody.categoryBitMask = 0
            landscape.tutorial?.start(button: landscape.rooms[1].firstGarbage!, text: "Apanhe o lixo!")
        }
        if firstBody.categoryBitMask == BodyType.player.rawValue && secondBody.categoryBitMask == BodyType.trashTrigger.rawValue {
            print("trashTrigger")
            secondBody.categoryBitMask = 0
            landscape.tutorial?.start(button: landscape.rooms[1].firstGarbage!, text: "Apanhe o lixo!")
        }
        
        if firstBody.categoryBitMask == BodyType.trashCanTrigger.rawValue && secondBody.categoryBitMask == BodyType.player.rawValue {
            print("trashCanTrigger")
            firstBody.categoryBitMask = 0
            landscape.tutorial?.start(button: landscape.firstBathroom.trashCan!, text: "Jogue o lixo na lixeira!")
        }
        if firstBody.categoryBitMask == BodyType.player.rawValue && secondBody.categoryBitMask == BodyType.trashCanTrigger.rawValue {
            print("trashCanTrigger")
            secondBody.categoryBitMask = 0
            landscape.tutorial?.start(button: landscape.firstBathroom.trashCan!, text: "Jogue o lixo na lixeira!")
        }
        
        if firstBody.categoryBitMask == BodyType.dogTrigger.rawValue && secondBody.categoryBitMask == BodyType.player.rawValue {
            print("dogTrigger")
            firstBody.categoryBitMask = 0
            landscape.tutorial?.start(button: landscape.dog!, text: "Pule o cachorro!")
        }
        if firstBody.categoryBitMask == BodyType.player.rawValue && secondBody.categoryBitMask == BodyType.dogTrigger.rawValue {
            print("dogTrigger")
            secondBody.categoryBitMask = 0
            landscape.tutorial?.start(button: landscape.dog!, text: "Pule o cachorro!")
        }
    }
    
    func updateScore(scoreToAdd: ScoreTable) {
        score += scoreToAdd.rawValue
    }
}
