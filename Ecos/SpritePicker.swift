//
//  SpritePicker.swift
//  Ecos
//
//  Created by Edvaldo Junior on 13/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import UIKit
import SpriteKit

class SpritePicker: SKNode, UIGestureRecognizerDelegate {

    var sprites = [SKSpriteNode]()
    var view = SKView()
    var currentIndex = 0
    
    init(withView view: SKView, withSprites sprites: [SKSpriteNode]) {
        self.view = view
        self.sprites = sprites
        
        super.init()
        
        createGestures()
        self.addChild(sprites[currentIndex])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func swipedRight(_ sender:UISwipeGestureRecognizer){
        
        //Aplicar actions para dar efeito de pickerView horizontal
        if currentIndex < sprites.count - 1 {
            self.removeAllChildren()
            self.addChild(sprites[currentIndex + 1])
            currentIndex += 1
        }
    }
    
    func swipedLeft(_ sender:UISwipeGestureRecognizer){
        
        //Aplicar actions para dar efeito de pickerView horizontal
        if currentIndex > 0 {
            self.removeAllChildren()
            self.addChild(sprites[currentIndex - 1])
            currentIndex -= 1
        }
    }
    
    func createGestures() {
        
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(SpritePicker.swipedRight(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(SpritePicker.swipedLeft(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
    }
}
