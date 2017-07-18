//
//  Bathroom.swift
//  Ecos
//
//  Created by Edvaldo Junior on 21/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class Bathroom: Room {

    var waterTap: Button?
    var trashCan: Button?
    
    func addTap(tapPosition: CGPoint, sizeTap: CGSize) {
        self.addChild(createWaterTap(tapPosition: tapPosition, sizeTap: sizeTap))
    }
    
    func createWaterTap(tapPosition: CGPoint, sizeTap: CGSize) -> Button {
        
        waterTap = Button(defaultButtonImage: "WaterTap0", activeButtonImage: "WaterTap0", buttonAction: touchWaterTap)
        waterTap!.setSizeAndPosition(sizeTap, position: tapPosition, areaFactor: 1.5)
        waterTap!.animate("WaterTaps", imgName: "WaterTap")
        waterTap!.zPosition = Position.before.rawValue
        return waterTap!
    }
    
    func touchWaterTap(waterTap: Button) {
        
        let gameScene = self.scene as! GameScene
        gameScene.updateScore(scoreToAdd: ScoreTable.waterTap)
        waterTap.action = nil
        
        if let value = defaults.object(forKey: Key.nWaterTap.rawValue) {
            var number = value as! Int
            number += 1
            defaults.set(number, forKey: Key.nWaterTap.rawValue)
            
            print("Tap = \(number)\n")
            
            let unlock = UnlockValues()
            if number >= unlock.waterTap {
                print("DesB Tap\n")
                defaults.set(false, forKey: Key.waterTapCard.rawValue)
            }
        } else {
            defaults.set(Int(1), forKey: Key.nWaterTap.rawValue)
        }
    }
    
    func addTrashCan(trashImage: String, trashCanPosition: CGPoint, sizeTrashCan: CGSize) {
        self.addChild(createTrashCan(trashImage: trashImage, trashCanPosition: trashCanPosition, sizeTrashCan: sizeTrashCan))
    }
    
    func createTrashCan(trashImage: String, trashCanPosition: CGPoint, sizeTrashCan: CGSize) -> Button {
        
        trashCan = Button(defaultButtonImage: trashImage, activeButtonImage: trashImage, buttonAction: touchTrashCan)
        trashCan!.setSizeAndPosition(sizeTrashCan, position: trashCanPosition, areaFactor: 1.5)
        trashCan!.zPosition = Position.before.rawValue
        return trashCan!
    }
    
    func touchTrashCan(trashCan: Button) {
        
        let gameScene = self.scene as! GameScene
        for _ in gameScene.player.trashBag!.children {
            gameScene.updateScore(scoreToAdd: ScoreTable.trash)
        }
        gameScene.player.trashBag?.throwAway(trashCan: trashCan)
        
        if let value = defaults.object(forKey: Key.nTrashCan.rawValue) {
            let number = value as! Int
            defaults.set(number + 1, forKey: Key.nTrashCan.rawValue)
        } else {
            defaults.set(Int(1), forKey: Key.nTrashCan.rawValue)
        }
    }
}
