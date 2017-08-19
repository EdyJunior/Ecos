//
//  WaterTap.swift
//  Ecos
//
//  Created by Edvaldo Junior on 14/08/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import UIKit

class WaterTap: Button {

    init(tapPosition: CGPoint, sizeTap: CGSize) {
        
        super.init(defaultButtonImage: "WaterTap0", activeButtonImage: "WaterTap0")
        self.action = self.touchWaterTap
        super.setSizeAndPosition(sizeTap, position: tapPosition, areaFactor: 1.5)
        super.animate("WaterTaps", imgName: "WaterTap")
        super.zPosition = Position.before.rawValue
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func touchWaterTap(waterTap: Button) {
        
        let gameScene = self.scene as! GameScene
        gameScene.updateScore(scoreToAdd: ScoreTable.waterTap)
        waterTap.action = nil
        
        if let value = defaults.object(forKey: Key.nWaterTap.rawValue) {
            var number = value as! Int
            number += 1
            defaults.set(number, forKey: Key.nWaterTap.rawValue)

            let unlock = UnlockValues()
            if number >= unlock.waterTap {
                defaults.set(false, forKey: Key.waterTapCard.rawValue)
            }
        } else {
            defaults.set(Int(1), forKey: Key.nWaterTap.rawValue)
        }
        
        if let value = defaults.object(forKey: Key.waterTapInPhase.rawValue) {
            var number = value as! Int
            number += 1
            defaults.set(number, forKey: Key.waterTapInPhase.rawValue)
        } else {
            defaults.set(Int(1), forKey: Key.waterTapInPhase.rawValue)
        }
    }
}
