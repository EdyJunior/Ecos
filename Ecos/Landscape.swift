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
        
        var i = 0
        
        var posR = CGPoint.zero
        let sizeR = CGSize(width: sceneSize.width * 3, height: sceneSize.height)
        let offset = sizeR.width
        
        let tapPosition = CGPoint(x: -sizeR.width * 0.3, y: sizeR.height * 0.35)
        
        for _ in 0...2 {
            waterTaps.append(createWaterTap(tapPosition: tapPosition))
        }
        
        //Cômodo 1
        let room1 = Room(imageNamed: "Room1")
        room1.initialize(size: sizeR, position: posR)
        
        for trash in createTrash() {
            room1.addChild(trash)
        }
        
        posR.x += offset
        rooms.append(room1)
        
        //Cômodo 2
        let room2 = Room(imageNamed: "Room2")
        room2.initialize(size: sizeR, position: posR)
        
        room2.addChild(waterTaps[i])
        i += 1
        
        posR.x += offset
        rooms.append(room2)
        
        //Cômodo 3
        let room3 = Room(imageNamed: "Room3")
        room3.initialize(size: sizeR, position: posR)
        posR.x += offset
        rooms.append(room3)
        
        //Cômodo 4
        let room4 = Room(imageNamed: "Room4")
        room4.initialize(size: sizeR, position: posR)
        
        room4.addChild(waterTaps[i])
        i += 1
        
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
        let room10 = Room(imageNamed: "Room10")
        room10.initialize(size: sizeR, position: posR)
        
        room10.addChild(waterTaps[i])
        i += 1
        
        posR.x += offset
        rooms.append(room10)
        
        for i in 1..<rooms.count {
            for trash in createTrash() {
                rooms[i].addChild(trash)
            }
        }
        
        //Inicia renderizando apenas 2 dos 10 cômodos
        self.addChild(rooms[0])
        self.addChild(rooms[1])
    }
    
    func createWaterTap(tapPosition: CGPoint) -> Button {
        
        let sizeTap = CGSize(width: sceneSize.width * 0.1, height: sceneSize.height * 0.2)
        
        let waterTap = Button(defaultButtonImage: "WaterTap0", activeButtonImage: "WaterTap0", buttonAction: touchWaterTap)
        waterTap.setSizeAndPosition(sizeTap, position: tapPosition, areaFactor: 1.5)
        waterTap.animate("WaterTaps", imgName: "WaterTap")
        waterTap.zPosition = Position.before.rawValue
        return waterTap
    }
    
    func touchWaterTap(waterTap: Button) {
        
        let gameScene = self.scene as! GameScene
        gameScene.updateScore(scoreToAdd: ScoreTable.waterTap)
        waterTap.action = nil
    }
    
    func createTrash() -> [Button] {

        var trashSizeTable: Dictionary = [Int : [CGFloat]]()
        trashSizeTable[0] = [0.03, 0.06]
        trashSizeTable[1] = [0.03, 0.09]
        trashSizeTable[2] = [0.02, 0.02]
        
        var trashNameTable: Dictionary = [Int : String]()
        trashNameTable[0] = "Can"
        trashNameTable[1] = "Bottle"
        trashNameTable[2] = "PaperBall"
        
        let quantity = Int(arc4random_uniform(3))
        var trashArray = [Button]()
        
        for _ in 0...quantity {
            let key = Int(arc4random_uniform(2))
            let sizeTrash = CGSize(width: sceneSize.width * trashSizeTable[key]![0] , height: sceneSize.width * trashSizeTable[key]![1])
            let garbagePosition = CGPoint(x: sceneSize.width * (CGFloat(arc4random_uniform(10)) / 10.0 - 0.45), y: -sceneSize.height * 0.1)
            let image: String = trashNameTable[key]!
            
            let garbage = Button(defaultButtonImage: image, activeButtonImage: image, buttonAction: touchTrash)
            garbage.setSizeAndPosition(sizeTrash, position: garbagePosition, areaFactor: 1.5)
            garbage.zPosition = Position.before.rawValue
            
            trashArray.append(garbage)
        }
        
        return trashArray
    }
    
    func touchTrash(trash: Button) {
        
        let gameScene = self.scene as! GameScene
        gameScene.player.trashBag!.push(garbage: trash)
        gameScene.updateScore(scoreToAdd: ScoreTable.trash)
        trash.action = nil
    }
}
