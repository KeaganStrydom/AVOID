//
//  SlowTime.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/21.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import SpriteKit
class DoublePoints : SKSpriteNode, Powerup {
    
    /* Powerup is circular object;
     therfore it requires a radius and diameter. */
    var radius: CGFloat = Screen.width * 0.05
    
    init(in scene : GameScene, at position : CGPoint) {
        let diameter = radius * 2
        super.init(texture: nil, color: .blue, size: CGSize(width: diameter, height: diameter))
        
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
        
        self.removeFromParent()
    }
    
    func revert() {
        
    }
    
    func collision(with node: SKNode, in scene: GameScene) {
        EndDelegate(scene: scene).endGame()
    }
    

}

