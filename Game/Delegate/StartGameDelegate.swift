//
//  StartGameDelegate.swift
//  Game
//
//  Created by Keagan Strydom onssbvbggf 2018/07/14.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import UIKit
import SpriteKit

class StartDelegate {
    
    var scene : GameScene
    
    init(scene : GameScene) {
        self.scene = scene
    }
    
    @objc func beginGame(){
        scene.gameInfo.isSoundMuted = fetchSoundState()
        scene.speed = 1
        hideStart()
    }
    
    func hideStart() {
        UIView.animate(withDuration: 1, animations: {
            self.scene.UI.buttonStart.alpha = 0
        }) { (hasFinishedAnimating) in
            self.scene.gameInfo.isGameRunning = true
            self.initBall()
            _ = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.applyForceAndStartSpawner), userInfo: nil, repeats: false)
        }
    }
    
    @objc private func applyForceAndStartSpawner() {
        self.scene.UI.gameBall.applyImpulse()
        scene.activateSpawner()
    }
    
    private func fetchSoundState() -> Bool {
        let soundState = scene.settings.getMusicState()
        if  soundState == SoundOptions.unmuted || soundState == nil {
            scene.playMusic()
            return false
        }
        return true
    }
    
    func getSelectedTheme() {
        scene.gameInfo.selectedTheme = scene.settings.getSelectedTheme()
    }
    
    func initScene() {
        scene.backgroundColor = scene.gameInfo.selectedTheme.sceneColor
        scene.isUserInteractionEnabled = true
        scene.name = Name.wall
        scene.physicsWorld.contactDelegate = scene
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        
        let border = SKPhysicsBody(edgeLoopFrom: scene.frame)
        scene.addBorder(to: scene, withBody: border)
        createBackgroundParticles()
        
        initViewOverlay()
        scene.view?.addSubview(scene.UI.labelPoints)
        initLabelBest()
        initLabelRetry()
        initImageViewSound()
        initLabelStart()
        initThemeDisplay()
        initBackButton()
    }
    
    private func initBall() {
        scene.UI.gameBall = Ball.init(type: .normal, pos: CGPoint(x: 0, y: 0), textureImage: scene.gameInfo.selectedTheme.ballTexture)
        scene.addChild(scene.UI.gameBall)
    }
    
    private func initThemeDisplay() {
         scene.UI.buttonStore.alpha = 0
        scene.UI.buttonStore.setTitle("Change Theme", for: .normal)
        scene.UI.buttonStore.titleLabel?.font = UIFont(name: "AvenirNext-UltraLight", size: 35)
        let cornerRadius = Screen.width * (4/75)
        scene.UI.buttonStore.layer.cornerRadius = cornerRadius
        scene.UI.buttonStore.addTarget(scene, action: #selector(scene.handleThemeClick), for: .touchUpInside)
        scene.UI.buttonStore.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.25)
        scene.UI.buttonStore.translatesAutoresizingMaskIntoConstraints = false
        scene.view?.addSubview(scene.UI.buttonStore)
        scene.UI.buttonStore.centerXAnchor.constraint(equalTo: (scene.view?.centerXAnchor)!).isActive = true
        scene.UI.buttonStore.heightAnchor.constraint(equalTo: (scene.view?.heightAnchor)!, multiplier: 0.17).isActive = true
        scene.UI.buttonStore.widthAnchor.constraint(equalTo: (scene.view?.widthAnchor)!, multiplier: 0.8).isActive = true
        scene.UI.buttonStore.bottomAnchor.constraint(equalTo: (scene.view?.bottomAnchor)!, constant: -(Screen.height * 0.05)).isActive = true
    }    
    
    private func initImageViewSound() {
        scene.UI.buttonSound.alpha = 0
        scene.UI.buttonSound.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.4)
        scene.UI.buttonSound.contentMode = .scaleAspectFit
        scene.UI.buttonSound.layer.cornerRadius = Screen.width * (4/75)
        scene.UI.buttonSound.isUserInteractionEnabled = true
        scene.UI.buttonSound.addTarget(scene, action: #selector(scene.handleSoundInvert), for: .touchUpInside)
        scene.UI.buttonSound.translatesAutoresizingMaskIntoConstraints = false
        scene.view?.addSubview(scene.UI.buttonSound)
        scene.UI.buttonSound.centerYAnchor.constraint(equalTo: scene.UI.labelPoints.centerYAnchor).isActive = true
        scene.UI.buttonSound.heightAnchor.constraint(equalTo: (scene.view?.widthAnchor)!, multiplier: 0.14).isActive = true
        scene.UI.buttonSound.widthAnchor.constraint(equalTo: scene.UI.buttonSound.heightAnchor, multiplier: 1.8).isActive = true
        scene.UI.buttonSound.centerXAnchor.constraint(equalTo: (scene.view?.rightAnchor)!, constant: -((scene.view?.frame.width)!/6)).isActive = true
    }
    
    private func initLabelBest() {
        scene.UI.labelBest.alpha = 0
        scene.UI.labelBest.translatesAutoresizingMaskIntoConstraints = false
        scene.UI.labelBest.textColor = .white
        scene.UI.labelBest.textAlignment = .center
        scene.UI.labelBest.font = UIFont(name: "AvenirNext-UltraLight", size: 30)
        scene.view?.addSubview(scene.UI.labelBest)
        scene.UI.labelBest.centerXAnchor.constraint(equalTo: (scene.view?.centerXAnchor)!).isActive = true
        scene.UI.labelBest.widthAnchor.constraint(equalTo: (scene.view?.widthAnchor)!).isActive = true
        scene.UI.labelBest.heightAnchor.constraint(equalToConstant: 35).isActive = true
        scene.UI.labelBest.topAnchor.constraint(equalTo: scene.UI.labelPoints.bottomAnchor).isActive = true
    }
    
    private func initLabelStart() {
        scene.UI.buttonStart.alpha = 1
        scene.UI.buttonStart.translatesAutoresizingMaskIntoConstraints = false
        scene.UI.buttonStart.backgroundColor = .clear
        scene.UI.buttonStart.setTitleColor(.white, for: .normal)
        scene.UI.buttonStart.titleLabel?.font = UIFont(name: "AvenirNext-UltraLight", size: 55)
        scene.UI.buttonStart.setTitle("Start!", for: .normal)
        scene.UI.buttonStart.isUserInteractionEnabled = true
        scene.UI.buttonStart.addTarget(scene, action: #selector(scene.handleBeginGame), for: .touchUpInside)
        scene.view?.addSubview(scene.UI.buttonStart)
        scene.UI.buttonStart.centerXAnchor.constraint(equalTo: (scene.view?.centerXAnchor)!).isActive = true
        scene.UI.buttonStart.widthAnchor.constraint(equalTo: (scene.view?.widthAnchor)!).isActive = true
        scene.UI.buttonStart.heightAnchor.constraint(equalToConstant: 75).isActive = true
        scene.UI.buttonStart.centerYAnchor.constraint(equalTo: (scene.view?.centerYAnchor)!).isActive = true
    }
    
    private func initLabelRetry() {
        scene.UI.buttonRetry.alpha = 0
        scene.UI.buttonRetry.translatesAutoresizingMaskIntoConstraints = false
        scene.UI.buttonRetry.setTitleColor(.white, for: .normal)
        scene.UI.buttonRetry.titleLabel?.font = UIFont(name: "AvenirNext-UltraLight", size: 55)
        scene.UI.buttonRetry.setTitle("Tap to retry", for: .normal)
        scene.UI.buttonRetry.isUserInteractionEnabled = true
        scene.UI.buttonRetry.addTarget(scene, action: #selector(scene.handleRetry), for: .touchUpInside)
        scene.view?.addSubview(scene.UI.buttonRetry)
        scene.UI.buttonRetry.centerXAnchor.constraint(equalTo: (scene.view?.centerXAnchor)!).isActive = true
        scene.UI.buttonRetry.widthAnchor.constraint(equalTo: (scene.view?.widthAnchor)!).isActive = true
        scene.UI.buttonRetry.heightAnchor.constraint(equalToConstant: 75).isActive = true
        scene.UI.buttonRetry.centerYAnchor.constraint(equalTo: (scene.view?.centerYAnchor)!).isActive = true
    }
    
    private func initViewOverlay() {
        scene.UI.viewOverlay.backgroundColor = .black
        scene.UI.viewOverlay.alpha = 0
        scene.UI.viewOverlay.frame = (scene.view?.frame)!
        scene.view?.addSubview(scene.UI.viewOverlay)
    }
    
    
    private func initBackButton() {
        scene.UI.buttonBack.alpha = 0
        scene.UI.buttonBack.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.4)
        scene.UI.buttonBack.setImage(#imageLiteral(resourceName: "BackButton"), for: .normal)
        scene.UI.buttonBack.layer.cornerRadius = Screen.width * (4/75)
        scene.UI.buttonBack.imageView?.frame = CGRect(origin: scene.UI.buttonBack.center, size: CGSize(width: scene.UI.buttonBack.frame.height * 0.7, height: scene.UI.buttonBack.frame.height * 0.7))
        scene.UI.buttonBack.imageView?.contentMode = .scaleAspectFit
        scene.UI.buttonBack.translatesAutoresizingMaskIntoConstraints = false
        scene.UI.buttonBack.addTarget(scene, action: #selector(scene.handleBackButton), for: .touchUpInside)
        scene.view?.addSubview(scene.UI.buttonBack)
        scene.UI.buttonBack.centerYAnchor.constraint(equalTo: scene.UI.labelPoints.centerYAnchor).isActive = true
        scene.UI.buttonBack.widthAnchor.constraint(equalTo: scene.UI.buttonSound.widthAnchor, multiplier: 1).isActive = true
        scene.UI.buttonBack.heightAnchor.constraint(equalTo: scene.UI.buttonSound.heightAnchor, multiplier: 1).isActive = true
        scene.UI.buttonBack.centerXAnchor.constraint(equalTo: (scene.view?.leftAnchor)!, constant:((scene.view?.frame.width)!/6)).isActive = true
    }
    
    func createBackgroundParticles() {
        let background = SKEmitterNode(fileNamed: "Background.sks")
        background?.position = CGPoint(x: 0, y: 0)
        background?.particlePositionRange = CGVector(dx: scene.frame.width, dy: scene.frame.height)
        scene.addChild(background!
        )
    }
    
    
}
