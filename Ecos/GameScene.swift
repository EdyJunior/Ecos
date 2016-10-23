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
        }
    }
    
    var backButton: MenuButton!

    var gameCamera = SKCameraNode()
    var gameOver = false
    var won = false
    var isTutoring = true
    //var gamedata: HighScore?
    
    var landscape: Landscape!
    var player: Player!
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        playerName = defaults.object(forKey: "PreviousCharacter") as! String
        buildScene()
        self.camera = self.gameCamera
        gameCamera.position.y = player.position.y
    }
    
    func buildScene() {
        
        self.backgroundColor = .black
        
        createLandscape()
        createPlayer()
        createLabels()
        createBackButton()
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
        player.trashBag?.position = CGPoint(x: size.width * 0.25, y: size.height * 0.15)
        addChild(player.trashBag!)
        
        player.walk()
    }
    
    func createLabels() {
        
        scoreLabel = InfoLabel(text: "0")
        scoreLabel.set(fontSize: size.height * 0.15, position: CGPoint(x: player.position.x + size.width * 0.4, y: player.position.y - size.height * 0.45) , fontColor: niceGreen, zPosition: Position.middle)
        addChild(scoreLabel)
        
        
        if playerName == "Gloria" {
            playerName = "Glória"
        } else if playerName == "Gloriosinho" {
            playerName = "Gloriosinho"
        }
        playerNameLabel = InfoLabel(text: playerName)
        playerNameLabel.set(fontSize: size.height * 0.1, position: CGPoint(x: player.position.x + size.width * 0.15, y: player.position.y - size.height * 0.45) , fontColor: niceGreen, zPosition: Position.middle)
        addChild(playerNameLabel)
    }
    
    func createBackButton() {
        
        //TODO: Posicionar o backButton em um lugar difícil de ser clicado acidentalmente
        
        backButton = MenuButton(defaultButtonImage: "backButton", activeButtonImage: "backButton", labelName: "Voltar", buttonAction: backToMenu)
        
        let sizeButton = CGSize(width: size.width * 0.07, height: size.width * 0.07)
        let labelSize = sizeButton.width / 3
        
        let positionButton = CGPoint(x: size.width * 0.05, y: player.position.y + size.height * 0.35)
        let labelPosition = CGPoint(x: 0, y: -sizeButton.width)
        
        backButton.setSizeAndPosition(sizeButton, position: positionButton, labelSize: labelSize, labelPosition: labelPosition, labelColor: niceGreen)
        
        backButton.zPosition = Position.front.rawValue
        addChild(backButton)
    }
    
    func backToMenu(button: Button) {
        
        let preGameScene = PreGameScene(size: size)
        view?.presentScene(preGameScene, transition: .push(with: .right, duration: 0.5))
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
    
    override func update(_ currentTime: TimeInterval) {

        gameCamera.position.x = player.position.x
        playerNameLabel.position.x = player.position.x + size.width * 0.15
        backButton.position.x = player.position.x + size.width * 0.35
        scoreLabel.position.x = player.position.x + size.width * 0.40
        player.trashBag?.position.x = player.position.x - size.width * 0.25
    }
}
