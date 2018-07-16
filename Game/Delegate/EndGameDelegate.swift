//
//  EndGameDelegate.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/14.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import UIKit
import SpriteKit

class EndDelegate {
    
    var scene : GameScene
    
    init(scene : GameScene) {
        self.scene = scene
    }
    
    
    func endGame() {
        checkHighScore()
        shatterBall()
        stopDarkness()
        scene.gameInfo.isGameRunning = false
        addPointsToTotal()
        Timer.scheduledTimer(timeInterval: 3,
                             target: self,
                             selector: #selector(presentEndView),
                             userInfo: nil,
                             repeats: false)
    }
    
    
    private func shatterBall() {
        if !(scene.gameInfo.isSoundMuted) {
            playShatterSound()
        }
        let shatter = SKEmitterNode(fileNamed: "Shatter.sks")
        shatter?.position = scene.UI.gameBall.position
        scene.UI.gameBall.removeFromParent()
        scene.addChild(shatter!)
    }
    
    private func playShatterSound(){
        scene.gameInfo.shatterPlayer = SoundPlayer(resourceName: "Shatter Sound")!
        scene.gameInfo.shatterPlayer.play()
    }
    
    private func checkHighScore() {
        let highscore = scene.settings.getHighscore()
        if scene.gameInfo.intPoints > highscore {
            scene.settings.updateHighscoreTo(highscore : scene.gameInfo.intPoints)
            
        }
    }
    
    private func stopDarkness() {
        if scene.gameInfo.timerDarkness != nil {
            scene.gameInfo.timerDarkness?.invalidate()
            scene.gameInfo.timerDarkness = nil
        }
    }
    
    private func addPointsToTotal() {
        let totalPoints = scene.settings.getTotalPoints()
        scene.settings.updateTotalPointsTo(totalPoints + scene.gameInfo.intPoints)
    }
    
    
    @objc func presentEndView(){
        hideThemeView()
        showRetry()
        showBest()
        showSoundOptions()
        showOverlay()
        showPoints()
    }
    
    private func showPoints() {
        scene.UI.labelPoints.text = String(scene.gameInfo.intPoints)
    }
    
    
    
    private func showBest() {
        let highscore = String(scene.settings.getHighscore())
        UIView.animate(withDuration: 1.5) {
            self.scene.UI.labelBest.alpha = 1
        }
        scene.UI.labelBest.text = "Best: " + highscore
    }
    
    func showSoundOptions() {
        switch scene.gameInfo.isSoundMuted {
        case true : scene.UI.imageViewSound.image = #imageLiteral(resourceName: "Image Mute")
        case false: scene.UI.imageViewSound.image = #imageLiteral(resourceName: "Image Unmute")
        }
        UIView.animate(withDuration: 1.5) {
            self.scene.UI.imageViewSound.alpha = 0.7
        }
    }
    
    @objc func invertSoundOption() {
        var soundState : String
        if scene.gameInfo.isSoundMuted {
            turnOnSound()
            soundState = SoundOptions.unmuted
            
        } else {
            turnOffSound()
            soundState = SoundOptions.muted
        }
        
        scene.gameInfo.isSoundMuted = !(scene.gameInfo.isSoundMuted)
        scene.settings.updateMusicStateTo(soundState)
        
    }
    
    private func turnOnSound() {
        scene.playMusic()
        scene.UI.imageViewSound.image = #imageLiteral(resourceName: "Image Unmute")
    }
    
    private func turnOffSound() {
        scene.gameInfo.musicPlayer?.pause()
        scene.UI.imageViewSound.image = #imageLiteral(resourceName: "Image Mute")
    }
    
    func hideThemeView() {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: {
                        self.scene.UI.buttonBack.alpha = 0
                        self.scene.UI.storeCV?.alpha = 0
        }) { (success) in
            self.showTheme()
        }
    }
    
    func showRetry() {
        UIView.animate(withDuration: 1.5) {
            self.scene.UI.buttonRetry.alpha = 1
        }
    }
    
    func showOverlay() {
        UIView.animate(withDuration: 2.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.scene.UI.viewOverlay.alpha = 0.45
        })
        
    }
    
    private func showTheme() {
        UIView.animate(withDuration: 1.5) {
            self.scene.UI.buttonStore.alpha = 1
        }
    }
    
    func hideEndView() {
        UIView.animate(withDuration: 2.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: .curveEaseIn,
                       animations: {
                        self.scene.UI.buttonRetry.alpha = 0
                        self.scene.UI.labelBest.alpha = 0
                        self.scene.UI.imageViewSound.alpha = 0
                        self.scene.UI.buttonStore.alpha = 0
        })
    }
    
    @objc func dismissEndView() {
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: .curveEaseIn,
                       animations: {
                        self.scene.UI.buttonRetry.alpha = 0
                        self.scene.UI.labelBest.alpha = 0
                        self.scene.UI.imageViewSound.alpha = 0
                        self.scene.UI.viewOverlay.alpha = 0.0
                        self.scene.UI.buttonStore.alpha = 0
                        self.scene.UI.labelPoints.text = "0"
        }) { (success) in
            self.retryGame()
        }
    }
    
    @objc func retryGame() {
        showLabelStart()
    }
    
    func showLabelStart(){
        scene.UI.buttonStart.isUserInteractionEnabled = true
        UIView.animate(withDuration: 1.5) {
            self.scene.UI.buttonStart.alpha = 1
        }
    }
    
}

