//
//  Obstacle.swift
//  Game
//
//  Created by Keagan Strydom on 2018/06/28.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import SpriteKit

protocol UIDarkness {
    var emitter : SKEmitterNode {get}
}

class Darkness : SKSpriteNode, UIDarkness {
    
    let inScene : GameScene
    let emitter = SKEmitterNode(fileNamed: "Darkness.sks")!
    
    init(frame : CGRect, xPos : CGFloat, scene: GameScene, theme: Theme) {
        self.inScene = scene
        
        let width = 0.25 * frame.width
        let height = 0.03 * frame.height
        
        super.init(texture: nil, color: .clear, size: CGSize(width: width, height: height))
        
        name = Name.darkness
        position = CGPoint(x: xPos, y:  frame.height + height)
        if xPos > 0 {
            anchorPoint = CGPoint(x: 1, y: 0.5)
        } else if xPos < 0 {
            anchorPoint = CGPoint(x: 0, y: 0.5)
        }
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.collisionBitMask = CollisionCategory.ballCategory
        physicsBody?.categoryBitMask = CollisionCategory.darknessCategory
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        
        
            emitter.particlePositionRange = CGVector(dx: width, dy: 0)
            emitter.position = position
            emitter.particleColorSequence = nil
            emitter.particleColorBlendFactor = 1.0
            emitter.particleColor = theme.emitterColor
            emitter.particleTexture = SKTexture(image: theme.darknessTexture)
            emitter.speed = scene.speed
            scene.addChild(emitter)
        
        let action = SKAction.moveTo(y: -(frame.height), duration: 4)
        run(action) { self.removeFromParent()}
        emitter.run(action) {self.removeFromParent()}
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
