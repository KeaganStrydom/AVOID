//
//  StorageProvider.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/08.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import Foundation


struct SettingsKeys {
    private init() {}
    
    static let configSet = "isConfigSet"
    static let selectedTheme = "selected theme"
    static let boughtThemes = "bought themes"
    static let highscore = "highscore"
    static let points = "points"
    static let musicState = "music state"
}


protocol  SettingsProvider {
    
    func getAllThemes() -> [Theme]
    func getSelectedTheme() -> Theme
    func updateSelectedThemeTo(_ theme : Theme)
    func initBoughtThemes()
    func getBoughtThemes() -> [String]
    func updateBoughtThemes(_ theme : Theme)
    
    func getHighscore() -> Int
    func updateHighscoreTo(highscore : Int) 
    
    func getTotalPoints() -> Int
    func updateTotalPointsTo(_ totalPoints: Int)
    
    func getMusicState() -> String?
    func updateMusicStateTo(_ musicState: String)
    
    func isConfigSet() -> Bool
    
}

class SettingsProviderFactory {
    static func useUserDefaults() -> SettingsProvider {
        return UsersDefaults.init()
    }
    
    
}
