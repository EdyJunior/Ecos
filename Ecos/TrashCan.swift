//
//  TrashCan.swift
//  Ecos
//
//  Created by Edvaldo Junior on 16/08/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import UIKit

class TrashCan: Button {

    init(trashImage: String, trashCanPosition: CGPoint, sizeTrashCan: CGSize) {
        
        super.init(defaultButtonImage: trashImage, activeButtonImage: trashImage)
        self.action = self.touchTrashCan
        self.setSizeAndPosition(sizeTrashCan, position: trashCanPosition, areaFactor: 1.5)
        self.zPosition = Position.before.rawValue
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func touchTrashCan(trashCan: Button) {
        
        let gameScene = self.scene as! GameScene
        for _ in gameScene.player.trashBag!.children {
            gameScene.updateScore(scoreToAdd: ScoreTable.trash)
        }
        gameScene.player.trashBag?.throwAway(trashCan: trashCan)
        
        trashCan.enabled = false
    }
}
