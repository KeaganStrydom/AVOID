//
//  InvinvibilityTheme.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/22.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import UIKit

class InvincibilityTheme : Theme {
    var name: String =  "Invincibility"
    
    var price: Int = 0
    
    var status: ThemeStatus = ThemeStatus.noStatus
    
    var emitterColor: UIColor = UIColor(red: 168/255,
                                        green: 101/255,
                                        blue: 168/255,
                                        alpha: 1)
    
    var sceneColor: UIColor = UIColor(red: 168/255,
                                      green: 101/255,
                                      blue: 168/255,
                                      alpha: 1)
    
    var ballTexture: UIImage
    
    var darknessTexture: UIImage
    
    var barrierTexture: UIImage = #imageLiteral(resourceName: "Invincibility Barrier")
    
    var buttonTexture: UIImage = UIImage()
    
    init(selected : Theme) {
        self.ballTexture = selected.ballTexture
        self.darknessTexture = selected.darknessTexture
    }
}
