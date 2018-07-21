//
//  Freeze.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/21.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import SpriteKit
class Freeze : SKSpriteNode, Powerup {
    
    /* Powerup is circular object;
     therfore it requires a radius and diameter. */
    var radius: CGFloat = Screen.width * 0.05
    
    init(in scene : GameScene, at position : CGPoint) {
        let diameter = radius * 2
        super.init(texture: nil, color: .green, size: CGSize(width: diameter, height: diameter))
        
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
        scene.backgroundColor = .red
        _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (success) in
            self.revert(scene)
        })
        self.removeFromParent()
    }
    
    func revert(_ scene: GameScene) {
        scene.gameInfo.activePowerup = nil
        scene.backgroundColor = scene.gameInfo.selectedTheme.sceneColor
    }
    
    func collision(with node: SKNode, in scene: GameScene) {
        if node.name == Name.wall {
            EndDelegate(scene: scene).endGame()
        } else if node.name == Name.darkness {
            node.removeAllChildren()
            node.removeFromParent()
        }
    }
}
