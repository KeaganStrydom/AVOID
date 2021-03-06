//
//  GameVariables.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/12.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import Foundation
import AVKit
import SpriteKit

struct GameVariables {
    
    init(selectedTheme : Theme) {
        self.selectedTheme = selectedTheme
    }
    
    //User points in game
    var intFrame = 0
    var intPoints = 0
    var isSoundMuted = true
    var isGameRunning = false
    var barrierSpawnDelay = 0.2
    var canSpawnBarrier = true
    var darknessFrequency = 1.5
    var selectedTheme : Theme
    let darknessSpawner = SKNode()
    let trailSpawner = SKNode()
    let trailFrequency = 0.1
    var activePowerup : Powerup?
    var pointsAddend : Int = 1
    var isLeavingStore = false
    var activePowerupView : UIView?
    var ballXVelocity  = Int(Screen.width * 0.785)
    // Audio Players
    var outGamePlayer = SoundPlayer(resourceName: "OutGame")
    var inGamePlayer = SoundPlayer(resourceName: "InGame")
    var shatterPlayer = AVAudioPlayer()
    let buyErrorPlayer = SoundPlayer(resourceName: "Score More")
    let highScorePlayer = SoundPlayer(resourceName: "Personal Best")
}
