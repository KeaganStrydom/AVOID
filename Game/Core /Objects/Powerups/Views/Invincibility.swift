//
//  Invincibility.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/21.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import SpriteKit
class Invincibility : SKSpriteNode, Powerup {
    var theme: Theme
    var sound = SoundPlayer(resourceName: "Indestructible")
    var image: UIImage = #imageLiteral(resourceName: "Invincibility")
    var delay : Double
    /* Powerup is circular object;
     therfore it requires a radius and diameter. */
    var radius: CGFloat = Screen.width * 0.07
    
    init(in scene : GameScene, at position : CGPoint) {
        let diameter = radius * 2
        self.delay = scene.gameInfo.barrierSpawnDelay
        self.theme = InvincibilityTheme(selected: scene.gameInfo.selectedTheme)
        super.init(texture: SKTexture(image: image), color: .clear, size: CGSize(width: diameter, height: diameter))
        name = Name.powerup
        self.position = position
        self.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        PowerupDelegate.addMovement(to: self)
        PowerupDelegate.addPhysics(to: self)
        
        scene.addChild(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func affect(_ scene: GameScene) {
        if !scene.gameInfo.isSoundMuted {
            sound?.play()
        }
        PowerupDelegate.removePowerups(from: scene)
        PowerupDelegate.wait(in: scene)
        scene.gameInfo.selectedTheme = theme
        scene.backgroundColor = theme.sceneColor
        scene.gameInfo.activePowerupView = ActivePowerupView(in: scene, powerupImage: image)
        scene.deactivate(scene.gameInfo.darknessSpawner)
        PowerupDelegate.changeDarkness(to: theme.emitterColor, in: scene)
        scene.gameInfo.barrierSpawnDelay = 0.2
        _ = Timer.scheduledTimer(withTimeInterval: 8, repeats: false, block: { (success) in
            self.revert(scene)
        })
        self.removeFromParent()
    }
    
    func revert(_ scene: GameScene) {
        scene.gameInfo.barrierSpawnDelay = delay
        scene.activate(scene.gameInfo.darknessSpawner,
                       with: scene.gameInfo.darknessFrequency,
                       action: scene.spawnDarkness)
        scene.gameInfo.selectedTheme = scene.settings.getSelectedTheme()
        scene.gameInfo.activePowerup = nil
        scene.gameInfo.activePowerupView = nil
        scene.backgroundColor = scene.gameInfo.selectedTheme.sceneColor
        let darknessColor = scene.gameInfo.selectedTheme.emitterColor
        PowerupDelegate.changeDarkness(to: darknessColor, in: scene)
    }
    func collision(with node: SKNode, in scene: GameScene) {
    }
    
    func barrier(at position: CGPoint, in scene: GameScene) {
        if position.x < (-0.3 * Screen.width) {
            scene.spawnBarrier(at: CGPoint(x: -0.3 * Screen.width, y: 0))
        } else if position.x > (0.3 * Screen.width) {
            scene.spawnBarrier(at: CGPoint(x: 0.3 * Screen.width, y: 0))
        } else {
           scene.spawnBarrier(at: position)
        }
    }
    
}
