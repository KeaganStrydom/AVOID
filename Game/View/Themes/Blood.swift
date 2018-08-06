//
//  Blood.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/16.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit


public class ThemeBlood : Theme {
    var status: ThemeStatus
    
    var name: String
    
    var price: Int
    
    var emitterColor: UIColor
    
    var sceneColor: UIColor
    
    var ballTexture: UIImage
    
    var darknessTexture: UIImage
    
    var barrierTexture: UIImage
    
    var buttonTexture: UIImage
    
    public init() {
        status = .noStatus
        
        name = "Lost in Blood"
        price = 1000
        emitterColor = UIColor(red: 255/255,
                               green: 255/255,
                               blue: 255/255,
                               alpha: 1)
        sceneColor = UIColor(red: 45/255,
                             green: 45/255,
                             blue: 45/255,
                             alpha: 1)
        //Core textures
        ballTexture = #imageLiteral(resourceName: "Blood Ball")
        buttonTexture = #imageLiteral(resourceName: "Blood Button")
        barrierTexture = #imageLiteral(resourceName: "Blood Barrier")
        darknessTexture = #imageLiteral(resourceName: "Blood Darkness")
    }
    
}
