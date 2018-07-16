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
    
    var status : ThemeStatus {get set}
    
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
        price = 5
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



