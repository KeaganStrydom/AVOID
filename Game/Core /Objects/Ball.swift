//
//  Ball.swift
//  Game
//
//  Created by Keagan Strydom on 2018/06/28.
//  Copyright © 2018 Lighthouse. All rights reserved.
//


import SpriteKit

enum ballType {
    case normal
    case trail
}

class Ball : SKSpriteNode {
    
    var type : ballType
    var ballTexture : SKTexture?
    
    init(type : ballType, pos : CGPoint, textureImage : UIImage?) {
        
        self.type = type
        
        if textureImage == nil {
            ballTexture = nil
        } else {
            ballTexture = SKTexture(image: textureImage!)
        }
        
        let sideLength = Screen.height * 0.0339
        super.init(texture: ballTexture, color: .clear, size: CGSize(width: sideLength, height: sideLength))
        
        handleType()
        
        self.position = pos
        self.name = Name.ball
    }
    
    private func handleType() {
        if type == .normal {
            addPhysics()
        } else if type == .trail {
            moveTrail()
            alpha = 0.2
        }
    }
    
    private func moveTrail() {
        let action = SKAction.moveTo(y: -(UIScreen.main.bounds.height), duration: 1.6)
        run(action) { self.removeFromParent() }
    }
    
    private func addPhysics(){
        let physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        physicsBody.isDynamic = true
        physicsBody.restitution = 1
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = true
        physicsBody.contactTestBitMask = CollisionCategory.powerupCategory
        physicsBody.categoryBitMask = CollisionCategory.ballCategory
        physicsBody.collisionBitMask = CollisionCategory.borderCategory | CollisionCategory.barrierCategory
        physicsBody.linearDamping = 0
        physicsBody.angularDamping = 0
        self.physicsBody = physicsBody
    }
    
     func applyImpulse() {
        let direction = arc4random_uniform(2) == 0 ? -1 : 1
        
        self.physicsBody?.applyImpulse(CGVector(dx: 70, dy: 0), at: position)
        self.physicsBody?.velocity = CGVector(dx: direction * 325, dy: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
