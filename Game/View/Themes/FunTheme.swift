//
//  FunTheme.swift
//  Game
//
//  Created by Keagan Strydom on 2018/08/22.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class ThemeFun : Theme {
    var status: ThemeStatus
    
    var name: String
    
    var price: Int
    
    var emitterColor: UIColor
    
    var sceneColor: UIColor
    
    var ballTexture: UIImage
    
    var darknessTexture: UIImage
    
    var barrierTexture: UIImage
    
    var buttonTexture: UIImage
    
    public init () {
        status = .noStatus
        
        name = "Fun"
        price = 7500
        emitterColor = UIColor(red: 3/255,
                               green: 166/255,
                               blue: 245/255,
                               alpha: 1)
        sceneColor = UIColor(red: 248/255,
                             green: 76/255,
                             blue: 100/255,
                             alpha: 1)
        
        //Core textures
        ballTexture = #imageLiteral(resourceName: "Fun Ball")
        buttonTexture = #imageLiteral(resourceName: "Fun Button")
        barrierTexture = #imageLiteral(resourceName: "Fun Barrier")
        darknessTexture = #imageLiteral(resourceName: "Fun Darkness")
    }
}

