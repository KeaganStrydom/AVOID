//
//  Wall.swift
//  Game
//
//  Created by Keagan Strydom on 2018/06/28.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import SpriteKit

class Barrier : SKSpriteNode {
    
    init(frame: CGRect, position : CGPoint, textureImage : UIImage) {
        
        let width = 0.09 * frame.width
        let height = 0.15 * frame.height
        super.init(texture: SKTexture(image: textureImage), color: .white, size: CGSize(width: width, height: height))
        
        self.position = position
        self.zPosition = -5
        self.name = Name.barrier
        
        let action = SKAction.moveTo(y: -(frame.height), duration: 4)
        run(action) { self.removeFromParent() }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
