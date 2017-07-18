

//
//  SoundManager.swift
//  Ecos
//
//  Created by Edvaldo Junior on 17/07/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import UIKit
import AVFoundation

class SoundManager: NSObject {
    
    static var player: AVAudioPlayer?
    
    static func playSound(withName name: String, withLoop loop: Bool = true) {
        
        let url = Bundle.main.url(forResource: name, withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.numberOfLoops = loop ? -1 : 0
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    static func stopPlayer() {
        player?.stop()
    }
}
