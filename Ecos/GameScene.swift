//
//  GameScene.swift
//  Ecos
//
//  Created by Edvaldo Junior on 06/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var scoreLabel: SKLabelNode!
    private var playerNameLabel: SKLabelNode!
    
    var backButton: MenuButton!

    var gameCamera = SKCameraNode()
    var gameOver = false
    var won = false
    var isTutoring = false
    //var gamedata: HighScore?
    
    var landscape: Landscape!
    var player: Player!
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        buildScene()
        self.camera = self.gameCamera
        gameCamera.position.y = player.position.y
    }
    
    func buildScene() {
        
        self.backgroundColor = .white
        createBackButton()
        createLandscape()
        createLabels()
        createPlayer()
    }
    
    func createBackButton() {
        
        backButton = MenuButton(defaultButtonImage: "backButton", activeButtonImage: "backButton", labelName: "Voltar", buttonAction: backToMenu)
        
        let sizeButton = CGSize(width: size.width * 0.07, height: size.width * 0.07)
        let labelSize = sizeButton.width / 3
        
        let positionButton = CGPoint(x: size.width * 0.05, y: size.height * 0.9)
        let labelPosition = CGPoint(x: 0, y: -sizeButton.width)
        
        backButton.setSizeAndPosition(sizeButton, position: positionButton, labelSize: labelSize, labelPosition: labelPosition)
        
        backButton.zPosition = Position.front.rawValue
        addChild(backButton)
    }
    
    func backToMenu(button: Button) {
        
        let preGameScene = PreGameScene(size: size)
        view?.presentScene(preGameScene, transition: .push(with: .right, duration: 0.5))
    }
    
    func createLabels() {
        
        //let
    }
    
    func createLandscape() {
        
        var rooms = [Room]()
        
        var posR = CGPoint.zero
        let sizeR = CGSize(width: size.width * 3, height: size.height)
        let offset = sizeR.width
        
        for i in 1...10 {
            let room = Room(imageNamed: "Room\(i)")
            room.initialize(size: sizeR, position: posR)
            posR.x += offset
            rooms.append(room)
        }
        
        landscape = Landscape(withView: view!, withRooms: rooms)
        landscape.position = CGPoint(x: size.width / 2, y: size.height / 2)
        landscape.zPosition = Position.deepest.rawValue
        addChild(landscape)
    }
    
    func createPlayer() {
        
        let sizePlayer = CGSize(width: size.width * 0.2, height: size.height * 0.5)
        let positonPlayer = CGPoint(x: size.width/2, y: size.height/2)
        
        player = Player(imageNamed: "Gloria0")
        player.initialize(sizePlayer, position: positonPlayer, zPosition: Position.middle.rawValue, scene: self)
        player.walk()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.jump()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if (firstBody.categoryBitMask == BodyType.door.rawValue && secondBody.categoryBitMask == BodyType.player.rawValue) {
            firstBody.categoryBitMask = 0
            print("Render")
            landscape.render()
        }
        if (firstBody.categoryBitMask == BodyType.player.rawValue && secondBody.categoryBitMask == BodyType.door.rawValue) {
            secondBody.categoryBitMask = 0
            print("Render")
            landscape.render()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {

        gameCamera.position.x = player.position.x
        backButton.position.x = size.width * 0.05 + player.position.x - size.width/2
    }
    
    
}
