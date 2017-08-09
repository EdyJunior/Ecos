//
//  Button.swift
//  Ecos
//
//  Created by Edvaldo Junior on 07/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import UIKit
import SpriteKit

class Button: SKNode {
    
    //TODO: Remover type (serve pra nada?)

    var defaultButton: SKSpriteNode
    var activeButton: SKSpriteNode
    var touchableArea: SKSpriteNode
    var action: ((_ button: Button) -> Void)?
    var type: BodyType?
    var enabled: Bool = true
    var pressed: Bool {
        didSet {
            activeButton.isHidden = !pressed
            defaultButton.isHidden = pressed
        }
    }
    
    init(defaultButtonImage: String, activeButtonImage: String, buttonAction: ((_ button: Button) -> Void)? = nil, Type: BodyType? = nil) {
        
        defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
        activeButton = SKSpriteNode(imageNamed: activeButtonImage)
        touchableArea = SKSpriteNode()
        activeButton.isHidden = true
        action = buttonAction
        type = Type
        pressed = false
        
        super.init()
        
        isUserInteractionEnabled = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touchableArea.contains((touches.first?.location(in: self))!) {
            if action != nil && enabled {
                pressed = !pressed
                action!(self)
            }
        }
    }
    
    func animate(_ AtlasName: String, imgName: String) {
        
        let textures = SKTextureAtlas(named: AtlasName)
        var frames = [SKTexture]()
        
        let numImages = textures.textureNames.count
        for i in 0..<numImages {
            
            let TextureName = "\(imgName)\(i)"
            frames.append(textures.textureNamed(TextureName))
        }
        
        let action = (SKAction.repeatForever(
            SKAction.animate(with: frames,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)
            )
        )
        defaultButton.run(action)
    }
    
    func setSizeAndPosition(_ size: CGSize, position: CGPoint, areaFactor factor: CGFloat) {
        
        defaultButton.size = size
        activeButton.size = size
        
        touchableArea = SKSpriteNode()
        touchableArea.size = CGSize(width: size.width * factor, height: size.height * factor)
        touchableArea.position = position
        
//        touchableArea.color = .blue
//        touchableArea.alpha = 0.5
        
        touchableArea.addChild(defaultButton)
        touchableArea.addChild(activeButton)
        addChild(touchableArea)
    }
}
