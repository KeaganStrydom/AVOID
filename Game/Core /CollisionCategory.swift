//
//  CollisionCategory.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/12.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import Foundation

struct CollisionCategory {
    private init() {}
    
    static let ballCategory : UInt32 = 0x1 << 0
    static let barrierCategory : UInt32 = 0x1 << 1
    static let borderCategory : UInt32 = 0x1 << 2
    static let powerupCategory : UInt32 = 0x1 << 3
}
