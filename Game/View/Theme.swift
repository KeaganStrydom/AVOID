//
//  Theme.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/03.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

protocol Theme {
    //Name of Theme
    var name : String {get}
    //Required points to purchase theme
    var price : Int {get}
    
    //The color of the 'darkness' emitter
    var emitterColor : UIColor {get}
    //Color of Scene
    var sceneColor : UIColor {get}
    //Texture of Core Object
    var ballTexture : UIImage {get}
    var darknessTexture : UIImage {get}
    var barrierTexture : UIImage {get}
    var buttonTexture : UIImage {get}
}

class ThemeDefault : Theme {
    var name: String
    
    var price: Int
    
    var emitterColor: UIColor
    
    var sceneColor: UIColor
    
    var ballTexture: UIImage
    
    var darknessTexture: UIImage
    
    var barrierTexture: UIImage
    
    var buttonTexture: UIImage
    
    public init () {
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

public class ThemeMinimalist : Theme {
    var name: String
    
    var price: Int
    
    var emitterColor: UIColor
    
    var sceneColor: UIColor
    
    var ballTexture: UIImage
    
    var darknessTexture: UIImage
    
    var barrierTexture: UIImage
    
    var buttonTexture: UIImage
    
    public init() {
        name = "Minimalist"
        price = 5
        emitterColor = UIColor(red: 255/255,
                               green: 255/255,
                               blue: 255/255,
                               alpha: 1)
        sceneColor = UIColor(red: 0/255,
                             green: 0/255,
                             blue: 0/255,
                             alpha: 1)
        //Core textures
        ballTexture = #imageLiteral(resourceName: "Minimalist Ball")
        buttonTexture = #imageLiteral(resourceName: "Minimalist Theme")
        barrierTexture = #imageLiteral(resourceName: "Minimalist Barrier")
        darknessTexture = #imageLiteral(resourceName: "Minimalist Darkness")
    }
    
}


public class ThemeBlue : Theme {
    var name: String
    
    var price: Int
    
    var emitterColor: UIColor
    
    var sceneColor: UIColor
    
    var ballTexture: UIImage
    
    var darknessTexture: UIImage
    
    var barrierTexture: UIImage
    
    var buttonTexture: UIImage
    
    public init() {
        name = "Lost in Blue"
        price = 5
        emitterColor = UIColor(red: 0/255,
                               green: 82/255,
                               blue: 147/255,
                               alpha: 1)
        sceneColor = UIColor(red: 0/255,
                             green: 142/255,
                             blue: 255/255,
                             alpha: 1)
        //Core textures
        ballTexture = #imageLiteral(resourceName: "Ball Texture")
        buttonTexture = #imageLiteral(resourceName: "Button Texture")
        barrierTexture = #imageLiteral(resourceName: "Barrier Texture")
        darknessTexture = #imageLiteral(resourceName: "Darkness Texture")
    }
    
}



