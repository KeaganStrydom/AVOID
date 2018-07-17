//
//  GameVariables.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/12.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import Foundation
import AVKit

struct GameVariables {
    
    init(selectedTheme : Theme) {
        self.selectedTheme = selectedTheme
    }
    
    //User points in game
    var intFrame = 0
    var intPoints = 0
    var isSoundMuted = true
    var isGameRunning = false
    var darknessFrequency = 1.0
    var selectedTheme : Theme
    var timerDarkness : Timer? = Timer()
    var timerPoints : Timer? = Timer()
    var timerBallTrail : Timer? = Timer()
    
    // Audio Players
    var musicPlayer = SoundPlayer(resourceName: "GameMusic")
    var shatterPlayer = AVAudioPlayer()
}
