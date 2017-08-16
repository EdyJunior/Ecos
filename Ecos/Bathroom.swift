//
//  Bathroom.swift
//  Ecos
//
//  Created by Edvaldo Junior on 21/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class Bathroom: Room {
    
    var waterTap: WaterTap?
    var trashCan: TrashCan?
    
    func createWaterTap(tapPosition: CGPoint, sizeTap: CGSize) -> Button {
        
        waterTap = WaterTap(tapPosition: tapPosition, sizeTap: sizeTap)
        return waterTap!
    }
    
    func addTap(tapPosition: CGPoint, sizeTap: CGSize) {
        self.addChild(createWaterTap(tapPosition: tapPosition, sizeTap: sizeTap))
    }
    
    func createTrashCan(trashImage: String, trashCanPosition: CGPoint, sizeTrashCan: CGSize) -> Button {
        
        trashCan = TrashCan(trashImage: trashImage, trashCanPosition: trashCanPosition, sizeTrashCan: sizeTrashCan)
        return trashCan!
    }
    
    func addTrashCan(trashImage: String, trashCanPosition: CGPoint, sizeTrashCan: CGSize) {
        self.addChild(createTrashCan(trashImage: trashImage, trashCanPosition: trashCanPosition, sizeTrashCan: sizeTrashCan))
    }
}
