//
//  UserDefaults.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/14.
//  Copyright © 2018 Lighthouse. All rights reserved.
//
import UIKit
class UsersDefaults : SettingsProvider {
    
    func isConfigSet() -> Bool {
        let config = UserDefaults.standard
        let isConfigSet = config.bool(forKey: SettingsKeys.configSet)
        if isConfigSet {
            return true
        } else {
            return false
        }
    }
    
    
    func getAllThemes() -> [Theme] {
        let allThemes : [Theme] = [ThemeDefault(), ThemeMinimalist()]
        return allThemes
    }
    
    func getSelectedTheme() -> Theme {
        let config = UserDefaults.standard
        var selectedTheme : Theme = ThemeDefault()
        let selectedThemeName = config.string(forKey: SettingsKeys.selectedTheme)
        let allThemes = getAllThemes()
        for theme in allThemes {
            if theme.name == selectedThemeName {
                selectedTheme = theme
            }
        }
        return selectedTheme
    }
    
    func updateSelectedThemeTo(_ theme: Theme) {
        let config = UserDefaults.standard
        config.set(theme.name, forKey: SettingsKeys.selectedTheme)
    }
    
    func initBoughtThemes() {
        let config = UserDefaults.standard
        config.set([ThemeDefault().name], forKey: SettingsKeys.boughtThemes)
    }
    
    func getBoughtThemes() -> [String] {
        let config = UserDefaults.standard
        return config.object(forKey: SettingsKeys.boughtThemes) as! [String]
    }
    
    func updateBoughtThemes(_ theme : Theme) {
        let config = UserDefaults.standard
        var boughtThemes = getBoughtThemes()
        print(boughtThemes)
        print(theme.name)
        boughtThemes.append(theme.name)
        config.set(boughtThemes, forKey: SettingsKeys.boughtThemes)
    }
    
    func getHighscore() -> Int {
        let config = UserDefaults.standard
        let highscore = config.integer(forKey: SettingsKeys.highscore)
        return highscore
    }
    
    func updateHighscoreTo(highscore : Int) {
        let config = UserDefaults.standard
        config.set(highscore, forKey: SettingsKeys.highscore)
    }
    
    func getTotalPoints() -> Int{
        let config = UserDefaults.standard
        let totalPoints = config.integer(forKey: SettingsKeys.points)
        return totalPoints
    }
    
    func updateTotalPointsTo(_ totalPoints: Int) {
        let config = UserDefaults.standard
        config.set(totalPoints, forKey: SettingsKeys.points)
    }
    
    func getMusicState() -> String? {
        let config = UserDefaults.standard
        let musicState : String? = config.string(forKey: SettingsKeys.musicState)
        return musicState
    }
    
    func updateMusicStateTo(_ musicState: String) {
        let config = UserDefaults.standard
        config.set(musicState, forKey: SettingsKeys.musicState)
    }
    
}
