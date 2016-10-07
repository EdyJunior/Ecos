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

    var defaultButton: SKSpriteNode
    var activeButton: SKSpriteNode
    var action: ((_ button: Button) -> Void)?
    var type: BodyType?
    var enabled: Bool = true
    
    init(defaultButtonImage: String, activeButtonImage: String, buttonAction: ((_ button: Button) -> Void)? = nil, Type: BodyType? = nil) {
        
        defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
        activeButton = SKSpriteNode(imageNamed: activeButtonImage)
        activeButton.isHidden = true
        action = buttonAction
        type = Type
        
        super.init()
        
        isUserInteractionEnabled = true
        addChild(defaultButton)
        addChild(activeButton)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if action != nil && enabled {
            
            activeButton.isHidden = false
            defaultButton.isHidden = true
            action!(self)
        }
    }
    
    func animate(_ AtlasName: String, imgName: String) {
        
        let textures = SKTextureAtlas(named: AtlasName)
        var frames = [SKTexture]()
        
        let numImages = textures.textureNames.count
        for i in 1...numImages {
            
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
    
    func setSizeAndPosition(_ size: CGSize, position: CGPoint) {
        
        defaultButton.size = size
        defaultButton.position = position
        activeButton.size = size
        activeButton.position = position
    }
}
