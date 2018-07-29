//
//  UserInterface.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/12.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import UIKit
import SpriteKit

struct UIGameScene {
    
    init() {}
    
    var gameBall : Ball = Ball(type: .normal,
                               pos: CGPoint(),
                               textureImage: nil)
    
    var viewOverlay = SKSpriteNode()
    
    var labelPoints = PointsLabel()
    var labelBest = UILabel()
    
    var buttonShare = UIButton()
    var buttonSound = UIButton()
    var buttonStart = UIButton()
    var buttonRetry = UIButton()
    var buttonStore = UIButton()
    var buttonBack = UIButton()
    
    var storeCV : UICollectionView? = nil
}
