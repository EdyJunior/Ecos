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
    case tap = 32
    case ground = 64
    case ceil = 65
    case trash = 128
    case menuBtn = 256
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
    
    case waterTap = 2
    case can = 1
    case tvset = 3
    case lamp = 4
}

let niceGreen = UIColor.init(red: 23/255, green: 136/255, blue: 23/255, alpha: 1)
