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
    var names = [String]()
    var labels = [InfoLabel]()
    var view = SKView()
    var currentIndex = 0
    
    init(withView view: SKView, withSprites sprites: [SKSpriteNode], withNames names: [String], inSprite: String = "") {
        
        self.view = view
        self.sprites = sprites
        self.names = names
        
        super.init()
        
        createGestures()
        if !inSprite.isEmpty  {
            currentIndex = names.index(of: inSprite)!
        }
        self.addChild(sprites[currentIndex])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func swipedRight(_ sender:UISwipeGestureRecognizer){
        
        //TODO: Aplicar actions para dar efeito de pickerView horizontal
        if currentIndex < sprites.count - 1 {
            currentIndex += 1
            updateSprite()
            updateLabels()
        }
    }
    
    func swipedLeft(_ sender:UISwipeGestureRecognizer){
        
        //TODO: Aplicar actions para dar efeito de pickerView horizontal
        if currentIndex > 0 {
            currentIndex -= 1
            updateSprite()
            updateLabels()
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
    
    func linkLabels(labels: [InfoLabel]) {
        self.labels = labels
    }
    
    func updateLabels() {
        
        for label in labels {
            label.text = names[currentIndex]
        }
    }
    
    func updateSprite() {
        
        self.removeAllChildren()
        self.addChild(sprites[currentIndex])
    }
}
