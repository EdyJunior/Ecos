//
//  Enums.swift
//  Ecos
//
//  Created by Edvaldo Junior on 06/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import SpriteKit

enum BodyType: UInt32 {
    
    case player = 1
    case obstacle = 2
    case limit = 4
    case toy = 8
    case door = 16
    case tapTrigger = 32
    case trashTrigger = 33
    case dogTrigger = 34
    case trashCanTrigger = 35
    case ground = 64
    case ceil = 65
    case trash = 128
}

enum Position: CGFloat {
    
    case deepest = 1
    case back = 2
    case before = 4
    case middle = 8
    case front = 16
    case top = 32
    case highlighted = 64
}

enum State: UInt32 {
    
    case timeOver = 1
    case obstacle = 2
}

enum ScoreTable: Int {
    
    case trashCan = 0
    case trash = 1
    case waterTap = 2
    case tvset = 3
    case lamp = 4
}

enum Key: String {
    
    case lastScore = "LastScore"
    case bestScore = "BestScore"
    case previousCharacter = "PreviousCharacter"
    
    case waterTapCard = "tapCard"
    case trashCard = "trashCard"
    case trashCanCard = "canCard"
    case tvCard = "tvCard"
    case lampCard = "lampCard"
    
    case nWaterTap = "numberOfWaterTaps"
    case nTrash = "numberOfTrash"
    case nTrashCan = "numberOfTrashCans"
}

struct Unlock {
    
    let trashCan = 9
    let trash = 100
    let waterTap = 10
    let tvset = 5
    let lamp = 10
}

let niceGreen = UIColor.init(red: 23/255, green: 136/255, blue: 23/255, alpha: 1)

let defaults = UserDefaults.standard
