//
//  Freeze.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/21.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import SpriteKit
class Freeze : SKSpriteNode, Powerup {
    var theme: Theme
    
    var image: UIImage = #imageLiteral(resourceName: "Freeze")
    
    /* Powerup is circular object;
     therfore it requires a radius and diameter. */
    var radius: CGFloat = Screen.width * 0.07
    
    init(in scene : GameScene, at position : CGPoint) {
        let diameter = radius * 2
        self.theme = FreezeTheme(selected: scene.gameInfo.selectedTheme)
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
        PowerupDelegate.removePowerups(from: scene)
        scene.gameInfo.selectedTheme = theme
        scene.backgroundColor = theme.sceneColor
        PowerupDelegate.changeDarkness(to: theme.emitterColor, in: scene)
        scene.gameInfo.activePowerupView = ActivePowerupView(in: scene, powerupImage: image)
        _ = Timer.scheduledTimer(withTimeInterval: 8, repeats: false, block: { (success) in
            self.revert(scene)
        })
        self.removeFromParent()
    }
    
    func revert(_ scene: GameScene) {
        scene.gameInfo.selectedTheme = scene.settings.getSelectedTheme()
        scene.gameInfo.activePowerup = nil
        scene.gameInfo.activePowerupView = nil
        scene.backgroundColor = scene.gameInfo.selectedTheme.sceneColor
        let darknessColor = scene.gameInfo.selectedTheme.emitterColor
        PowerupDelegate.changeDarkness(to: darknessColor, in: scene)
    }
    
    func collision(with node: SKNode, in scene: GameScene) {
        if node.name == Name.wall {
            EndDelegate(scene: scene).endGame()
        } else if node.name == Name.darkness {
            scene.increasePoints(by: 5)
            PointsIndicator(in: scene, addend: 5, position: node.position)
            (node as? UIDarkness)?.emitter.removeFromParent()
            node.removeAllChildren()
            node.removeFromParent()
            shatter(node, in: scene)
        }
    }
    
    func shatter(_ darkness: SKNode, in scene : GameScene) {
        if !(scene.gameInfo.isSoundMuted) {
            EndDelegate(scene: scene).playShatterSound()
        }
        let shatter = SKEmitterNode(fileNamed: "DarknessShatter.sks")
        shatter?.position = darkness.position
        darkness.removeFromParent()
        scene.addChild(shatter!)
    }
}
