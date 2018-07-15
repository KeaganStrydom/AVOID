//
//  SoundPlayer.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/02.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import AVKit

//Sound References
//http://www.freesfx.co.uk (Glass Shatter Sound)

class SoundPlayer : AVAudioPlayer {
    init(resourceName : String) {
        
        let filePath = Bundle.main.path(forResource: resourceName, ofType: "mp3")
        let url = URL(fileURLWithPath: filePath!)
        
        do {
            try super.init(contentsOf: url, fileTypeHint: "mp3")
            self.prepareToPlay()
        } catch {
            print("Error caught")
        }
        
    }
}
