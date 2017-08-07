//
//  Landscape.swift
//  Ecos
//
//  Created by Edvaldo Junior on 20/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class Landscape: SKNode {
    
    var rooms = [Room]()
    var waterTaps = [Button]()
    var trash = [Button]()
    var currentIndex = 0
    var sceneSize = CGSize()
    var tutorial: Tutorial?
    var firstBathroom = Bathroom()
    var dog: Dog?
    
    init(sceneSize: CGSize) {
        
        self.sceneSize = sceneSize
        
        super.init()
        
        createRooms()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        
        if currentIndex + 2 < rooms.count {
            self.addChild(rooms[currentIndex + 2])
            currentIndex += 1
        }
        if currentIndex - 1 > 0 {
            rooms[currentIndex - 2].removeFromParent()
        }
    }
    
    func createRooms() {
        
        var posR = CGPoint.zero
        let sizeR = CGSize(width: sceneSize.width * 3, height: sceneSize.height)
        let offset = sizeR.width
        
        let sizeTap = CGSize(width: sizeR.width * 0.035, height: sizeR.height * 0.2)
        let tapPosition = CGPoint(x: -sizeR.width * 0.3, y: sizeR.height * 0.35)
        
        let sizeTrashCan = CGSize(width: sizeR.width * 0.025, height: sizeR.height * 0.15)
        let trashCanPosition = CGPoint(x: sizeR.width * 0.4, y: sizeR.height * 0.06)

        //Cômodo 1
        let room1 = Room(imageNamed: "Room1")
        room1.initialize(size: sizeR, position: posR)
        
        if let val = defaults.object(forKey: Key.fun.rawValue) as? Bool {
            if val {
                let ball = Ball(defaultButtonImage: "ball", activeButtonImage: "ball")
                ball.action = ball.touchBall
                ball.setSizeAndPosition(CGSize(width: sceneSize.width * 0.07, height: sceneSize.width * 0.07), position: CGPoint(x: -sceneSize.width, y: sceneSize.height * 0.25), areaFactor: 1.8)
                ball.initialize()
                room1.addChild(ball)
            }
        }
        
        posR.x += offset
        rooms.append(room1)
        
        //Cômodo 2
        let room2 = Bathroom(imageNamed: "Room2")
        room2.initialize(size: sizeR, position: posR)
        room2.addTap(tapPosition: tapPosition, sizeTap: sizeTap)
        room2.addTrashCan(trashImage: "ChildsTrashCan", trashCanPosition: trashCanPosition, sizeTrashCan: sizeTrashCan)
        
        posR.x += offset
        rooms.append(room2)
        
        firstBathroom = room2
        
        //Cômodo 3
        let room3 = Room(imageNamed: "Room3")
        room3.initialize(size: sizeR, position: posR)
        
        dog = Dog(defaultButtonImage: "dog0", activeButtonImage: "dog0")
        dog!.action = dog!.touchDog
        dog!.setSizeAndPosition(CGSize(width: sceneSize.width * 0.1, height: sceneSize.height * 0.15), position: CGPoint(x: -sceneSize.width, y: -sceneSize.height * 0.15), areaFactor: 1.5)
        dog!.initialize()
        room3.addChild(dog!)
        
        posR.x += offset
        rooms.append(room3)
        
        //Cômodo 4
        let room4 = Bathroom(imageNamed: "Room4")
        room4.initialize(size: sizeR, position: posR)
        room4.addTap(tapPosition: tapPosition, sizeTap: sizeTap)
        room4.addTrashCan(trashImage: "ChildsTrashCan", trashCanPosition: trashCanPosition, sizeTrashCan: sizeTrashCan)
        
        posR.x += offset
        rooms.append(room4)
        
        //Cômodo 5
        let room5 = Room(imageNamed: "Room5")
        room5.initialize(size: sizeR, position: posR)
        
        posR.x += offset
        rooms.append(room5)
        
        //Cômodo 6
        let room6 = Room(imageNamed: "Room6")
        room6.initialize(size: sizeR, position: posR)
        
        let secondDog = Dog(defaultButtonImage: "dog0", activeButtonImage: "dog0")
        secondDog.action = secondDog.touchDog
        secondDog.setSizeAndPosition(CGSize(width: sceneSize.width * 0.1, height: sceneSize.height * 0.15), position: CGPoint(x: 0, y: -sceneSize.height * 0.15), areaFactor: 1.5)
        secondDog.initialize()
        room6.addChild(secondDog)
        
        posR.x += offset
        rooms.append(room6)
        
        //Cômodo 7
        let room7 = Room(imageNamed: "Room7")
        room7.initialize(size: sizeR, position: posR)
        
        posR.x += offset
        rooms.append(room7)
        
        //Cômodo 8
        let room8 = Room(imageNamed: "Room8")
        room8.initialize(size: sizeR, position: posR)
        
        posR.x += offset
        rooms.append(room8)
        
        //Cômodo 9
        let room9 = Room(imageNamed: "Room9")
        room9.initialize(size: sizeR, position: posR)
        
        posR.x += offset
        rooms.append(room9)
        
        //Cômodo 10
        let room10 = Bathroom(imageNamed: "Room10")
        room10.initialize(size: sizeR, position: posR)
        room10.addTap(tapPosition: tapPosition, sizeTap: sizeTap)
        room10.addTrashCan(trashImage: "GrandmasTrashCan", trashCanPosition: trashCanPosition, sizeTrashCan: sizeTrashCan)
        
        let trigger = SKSpriteNode()
        trigger.size = CGSize(width: sceneSize.width * 0.01, height: sceneSize.height)
        let endPos = CGPoint(x: sizeR.width * 0.5, y: sizeR.height * 0.06)
        trigger.position = endPos
        trigger.zPosition = Position.front.rawValue
        
        trigger.physicsBody = SKPhysicsBody(rectangleOf: trigger.size)
        trigger.physicsBody?.affectedByGravity = false
        trigger.physicsBody?.allowsRotation = false
        trigger.physicsBody?.categoryBitMask = BodyType.endTrigger.rawValue
        trigger.physicsBody?.contactTestBitMask = BodyType.player.rawValue
        trigger.physicsBody?.collisionBitMask = 0
        
        room10.addChild(trigger)
        
        posR.x += offset
        rooms.append(room10)
        
        for i in 1..<rooms.count {
            rooms[i].addTrash()
        }
        
        //Inicia renderizando apenas 2 dos 10 cômodos
        self.addChild(rooms[0])
        self.addChild(rooms[1])
    }
    
    func createTutorials() {
        
        let waterTapPosition = firstBathroom.waterTap!.touchableArea.position
        let waterTapTrigger = CGPoint(x: waterTapPosition.x - sceneSize.width * 0.15, y: 0)
        
        tutorial = Tutorial(withScene: self.scene as! GameScene)
        tutorial?.tutorialTrigger(triggerPosition: waterTapTrigger, buttonType: .tapTrigger, room: firstBathroom)
        
        let garbagePosition = rooms[1].firstGarbage!.touchableArea.position
        let garbageTrigger = CGPoint(x: garbagePosition.x - sceneSize.width * 0.15, y: 0)
        
        tutorial?.tutorialTrigger(triggerPosition: garbageTrigger, buttonType: .trashTrigger, room: rooms[1])
        
        let trashCanPosition = firstBathroom.trashCan!.touchableArea.position
        let trashCanTrigger = CGPoint(x: trashCanPosition.x - sceneSize.width * 0.15, y: 0)
        
        tutorial?.tutorialTrigger(triggerPosition: trashCanTrigger, buttonType: .trashCanTrigger, room: rooms[1])
        
        let dogPosition = dog!.touchableArea.position
        let dogTrigger = CGPoint(x: dogPosition.x - sceneSize.width * 0.045, y: 0)
        
        tutorial?.tutorialTrigger(triggerPosition: dogTrigger, buttonType: .dogTrigger, room: rooms[2])
    }
}
