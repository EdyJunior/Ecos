//
//  Landscape.swift
//  Ecos
//
//  Created by Edvaldo Junior on 13/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class Landscape: SKNode {

    var rooms = [Room]()
    var view = SKView()
    var currentIndex = 0
    
    init(withView view: SKView, withRooms rooms: [Room]) {
        self.view = view
        self.rooms = rooms
        
        super.init()
        
        self.addChild(rooms[0])
        self.addChild(rooms[1])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        
        if currentIndex + 2 < rooms.count {
            self.addChild(rooms[currentIndex + 2])
            currentIndex += 1
        }
        if currentIndex - 2 >= 0 {
            rooms[currentIndex - 2].removeFromParent()
        }
    }
}
