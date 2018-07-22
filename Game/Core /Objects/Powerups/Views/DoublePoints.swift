//
//  SlowTime.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/21.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import SpriteKit
class DoublePoints : SKSpriteNode, Powerup {
    var theme: Theme
    
    var image: UIImage = #imageLiteral(resourceName: "x2 Multiplier")
    
    /* Powerup is circular object;
     therfore it requires a radius and diameter. */
    var radius: CGFloat = Screen.width * 0.07
    
    init(in scene : GameScene, at position : CGPoint) {
        let diameter = radius * 2
        self.theme = DoublePointsTheme(selected: scene.gameInfo.selectedTheme)
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
        scene.gameInfo.pointsAddend = 2
        scene.gameInfo.activePowerupView = ActivePowerupView(in: scene, powerupImage: image)
        scene.gameInfo.selectedTheme = theme
        scene.backgroundColor = theme.sceneColor
        PowerupDelegate.changeDarkness(to: theme.emitterColor, in: scene)
        _ = Timer.scheduledTimer(withTimeInterval: 8, repeats: false, block: { (success) in
            self.revert(scene)
        })
        self.removeFromParent()
    }
    
    func revert(_ scene: GameScene) {
        scene.gameInfo.pointsAddend = 1
        scene.gameInfo.selectedTheme = scene.settings.getSelectedTheme()
        scene.gameInfo.activePowerup = nil
        scene.gameInfo.activePowerupView = nil
        scene.backgroundColor = scene.gameInfo.selectedTheme.sceneColor
        let darknessColor = scene.gameInfo.selectedTheme.emitterColor
        PowerupDelegate.changeDarkness(to: darknessColor, in: scene)
    }
    func collision(with node: SKNode, in scene: GameScene) {
        EndDelegate(scene: scene).endGame()
    }
    

}

