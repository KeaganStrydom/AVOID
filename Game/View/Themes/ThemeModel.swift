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

