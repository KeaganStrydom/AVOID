//
//  PointsIndicator.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/25.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import UIKit


class PointsIndicator : UILabel {
    init(in scene: GameScene, addend : Int, position : CGPoint) {
        
        
        //Add half the screen width and height to move the origin
        var x : CGFloat
        let xOffset = 0.05 * Screen.width
        if position.x > 0 {
             x = Screen.width/2 + position.x - xOffset
        } else {
             x = Screen.width/2 + position.x + xOffset
        }
        let y = Screen.height/2 + position.y
        
        super.init(frame: CGRect(x: x,
                                 y: y,
                                 width: 100,
                                 height: 50))
        
        
        font = UIFont(name: "Futura-Bold", size: 27)
        textColor = .white
        textAlignment = .center
        alpha = 1
        text = "+" + String(addend)
        
        scene.view?.addSubview(self)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }) { (animation) in
            self.removeFromSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
