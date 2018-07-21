//
//  Powerup.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/19.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import SpriteKit

protocol Powerup {
    var radius : CGFloat {get}
    func affect(_ scene : GameScene)
    func collision(with node : SKNode, in scene: GameScene)
}

class PowerupFactory {
    static func makeRandom(in scene: GameScene, at position : CGPoint) -> Powerup? {
        let randomNumber = Random.generateNumber(between: 0, and: 100)
        
        if (0...98).contains(randomNumber) {
            return makeFreeze(in: scene, at: position)
        } else if (99...99).contains(randomNumber) {
            return makeDoublePoints(in:at:)(in: scene, at: position)
        } else if (100...100).contains(randomNumber) {
            return makeInvincibility(in: scene, at: position)
        }
        
        return nil
    }
    
    private static func makeFreeze(in scene : GameScene, at position : CGPoint) -> Powerup {
        return Freeze.init(in: scene, at: position)
    }
    private static func makeInvincibility(in scene : GameScene, at position : CGPoint) -> Powerup {
        return Invincibility.init(in: scene, at: position)
    }
    private static func makeDoublePoints(in scene : GameScene, at position : CGPoint) -> Powerup {
        return DoublePoints.init(in: scene, at: position)
    }
}

struct PowerupDelegate {
    private init() {}
    static func addMovement(to powerup: SKSpriteNode ) {
        let moveOffScreen = SKAction.moveTo(y: -Screen.height, duration: 4)
        powerup.run(moveOffScreen) {powerup.removeFromParent()}
    }
    static func addPhysics(to powerup : SKSpriteNode) {
        let radius = powerup.size.width/2
        powerup.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        powerup.physicsBody?.affectedByGravity = false
        powerup.physicsBody?.isDynamic = false
        powerup.physicsBody?.categoryBitMask = CollisionCategory.powerupCategory
        powerup.physicsBody?.collisionBitMask = CollisionCategory.ballCategory
    }
    
}

