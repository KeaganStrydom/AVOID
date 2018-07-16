//
//  Blue.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/16.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit


public class ThemeBlue : Theme {
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
        
        name = "Lost in Blue"
        price = 25
        emitterColor = UIColor(red: 80/255,
                               green: 177/255,
                               blue: 255/255,
                               alpha: 1)
        sceneColor = UIColor(red: 80/255,
                             green: 177/255,
                             blue: 255/255,
                             alpha: 1)
        //Core textures
        ballTexture = #imageLiteral(resourceName: "Blue Ball")
        buttonTexture = #imageLiteral(resourceName: "Blue Button")
        barrierTexture = #imageLiteral(resourceName: "Blue Barrier")
        darknessTexture = #imageLiteral(resourceName: "Blue Darkness")
    }
    
}



