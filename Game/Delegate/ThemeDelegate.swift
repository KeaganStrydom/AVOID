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
        scene.animatePoints(target: scene.settings.getTotalPoints(), current: 0)
        
        scene.UI.storeCV = ThemeStore(scene: scene)
        scene.UI.storeCV?.alpha = 0
        scene.view?.addSubview(scene.UI.storeCV!)
        
        animateThemeStoreIn()
    }
    
    func animateThemeStoreIn() {
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
            self.scene.UI.buttonRetry.alpha = 0
            self.scene.UI.labelBest.alpha = 0
            self.scene.UI.buttonSound.alpha = 0
            self.scene.UI.buttonStore.alpha = 0
            self.scene.UI.buttonShare.alpha = 0
            self.scene.UI.labelPoints.textAlignment = .right
        }) { (hasFinished) in
            UIView.animate(withDuration: 2,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: .curveEaseIn,
                           animations: {
                            self.scene.UI.labelPoints.alpha = 1
                            self.scene.UI.buttonBack.alpha = 1
                            self.scene.UI.storeCV!.alpha = 1
            })
        }
    }
    
    @objc func switchToTheme(sender: UIButton) {
        let allThemes = scene.settings.getAllThemes()
        let theme = allThemes[sender.tag] as Theme
        if isThemeBought(theme) {
            setSelectedTheme(theme)
        } else {
            if canBuyTheme(theme) {
                setSelectedTheme(theme)
            } else {
                buyError(sender: sender)
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
        scene.animatePoints(target: updatedTotalPoints, current: totalPoints)
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
    
    private func buyError(sender: UIButton) {
         if !scene.gameInfo.isSoundMuted {
        scene.gameInfo.buyErrorPlayer?.play()
        }
        UIView.animate(withDuration: 0.5, animations: {
            sender.superview?.backgroundColor = UIColor(red: 1, green: 70/255, blue: 70/255, alpha: 1)
        }) { (hasFinished) in
            UIView.animate(withDuration: 0.5, animations: {
                sender.superview?.backgroundColor = UIColor(red: 0.8,
                                                            green: 0.8,
                                                            blue: 0.8,
                                                            alpha: 0.3)
            })
        }
    }
    
    private func updateViewToTheme() {
        scene.backgroundColor = scene.gameInfo.selectedTheme.sceneColor
        scene.UI.storeCV?.removeFromSuperview()
        scene.UI.storeCV = ThemeStore(scene: scene)
        scene.view?.addSubview(scene.UI.storeCV!)
    }
}


