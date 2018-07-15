//
//  ThemeDelegate.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/14.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import UIKit
import SpriteKit


class ThemeDelegate {
    
    var scene : GameScene
    
    init(scene : GameScene) {
        self.scene = scene
    }
    
    @objc func showThemeStore() {
        scene.UI.labelPoints.text = String(scene.settings.getTotalPoints())
        let delegate = EndDelegate(scene: scene)
        delegate.hideEndView()
        
        scene.UI.storeCV = ThemeStore(scene: scene)
        scene.view?.addSubview(scene.UI.storeCV!)
        
        UIView.animate(withDuration: 3.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: .curveEaseIn,
                       animations: {
                        self.scene.UI.buttonBack.alpha = 1
                        self.scene.UI.storeCV!.alpha = 1
        })
    }
    
    @objc func switchToTheme(sender: UIButton) {
        let allThemes = scene.settings.getAllThemes()
        let theme = allThemes[sender.tag] as Theme
        
        if isThemeBought(theme) {
            setSelectedTheme(theme)
        } else {
            switch canBuyTheme(theme) {
            case true : setSelectedTheme(theme)
            case false : buyError()
            }
        }
    }
    
    
    private func canBuyTheme(_ selected : Theme) -> Bool{
        let totalPoints = scene.settings.getTotalPoints()
        
        
        if totalPoints > selected.price {
            buyThemeWithPoints(totalPoints, theme: selected)
            return true
        } else {
            return false
        }
    }
    
    private func buyThemeWithPoints(_ totalPoints : Int, theme : Theme) {
        let updatedTotalPoints = totalPoints - theme.price
        scene.settings.updateBoughtThemes(theme)
        scene.UI.labelPoints.text = String(updatedTotalPoints)
        scene.settings.updateTotalPointsTo(updatedTotalPoints)
    }
    
    func isThemeBought(_ selected : Theme) -> Bool {
        let boughtThemes = scene.settings.getBoughtThemes()
        for themeName in boughtThemes {
            if selected.name == themeName {
                return true
            }
        }
        return false
    }
    
    private func setSelectedTheme(_ theme : Theme) {
        scene.gameInfo.selectedTheme = theme
        updateViewToTheme()
        scene.settings.updateSelectedThemeTo(theme)
    }
    
    private func buyError() {
        
    }
    
    private func updateViewToTheme() {
        scene.backgroundColor = scene.gameInfo.selectedTheme.sceneColor
    }

}


