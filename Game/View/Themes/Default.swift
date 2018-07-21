//
//  Default.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/16.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class ThemeDefault : Theme {
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
        
        name = "Default"
        price = 0
        emitterColor = UIColor(red: 140/255,
                               green: 145/255,
                               blue: 1,
                               alpha: 1)
        sceneColor = UIColor(red: 122/255,
                             green: 129/255,
                             blue: 1,
                             alpha: 1)
        
        //Core textures
        ballTexture = #imageLiteral(resourceName: "Default Ball")
        buttonTexture = #imageLiteral(resourceName: "Default Theme")
        barrierTexture = #imageLiteral(resourceName: "Default Barrier")
        darknessTexture = #imageLiteral(resourceName: "Default Darkness")
    }
}
