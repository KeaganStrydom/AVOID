//
//  Future.swift
//  Game
//
//  Created by Keagan Strydom on 2018/08/22.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import Foundation
import Foundation
import UIKit
import SpriteKit

class ThemeFuturistic : Theme {
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
        
        name = "Futuristic"
        price = 10000
        emitterColor = UIColor(red: 3/255,
                               green: 166/255,
                               blue: 245/255,
                               alpha: 1)
        sceneColor = UIColor(red: 33/255,
                             green: 33/255,
                             blue: 33/255,
                             alpha: 1)
        
        //Core textures
        ballTexture = #imageLiteral(resourceName: "Future Ball")
        buttonTexture = #imageLiteral(resourceName: "Future Button")
        barrierTexture = #imageLiteral(resourceName: "Future Barrier")
        darknessTexture = #imageLiteral(resourceName: "Future Darkness")
    }
}
