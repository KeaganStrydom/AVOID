//
//  Obstacle.swift
//  Game
//
//  Created by Keagan Strydom on 2018/06/28.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import SpriteKit

class Darkness : SKSpriteNode {
    
    let inScene : GameScene
    
    init(frame : CGRect, xPos : CGFloat, scene: GameScene, theme: Theme) {
        self.inScene = scene
        
        let width = 0.25 * frame.width
        let height = 0.03 * frame.height
        
        super.init(texture: nil, color: .clear, size: CGSize(width: width, height: height))
        
        name = Name.obstacle
        position = CGPoint(x: xPos, y:  frame.height + height)
        if xPos > 0 {
            anchorPoint = CGPoint(x: 1, y: 0.5)
        } else if xPos < 0 {
            anchorPoint = CGPoint(x: 0, y: 0.5)
        }
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        
        let emitter = SKEmitterNode(fileNamed: "Darkness.sks")!
            emitter.particlePositionRange = CGVector(dx: width, dy: 0)
            emitter.position = position
            emitter.particleColorSequence = nil
            emitter.particleColorBlendFactor = 1.0
            emitter.particleColor = theme.emitterColor
            emitter.particleTexture = SKTexture(image: theme.darknessTexture)
            scene.addChild(emitter)

        let action = SKAction.moveTo(y: -(frame.height), duration: 4)
        run(action) { self.removeFromParent()}
        emitter.run(action) {self.removeFromParent()}
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

