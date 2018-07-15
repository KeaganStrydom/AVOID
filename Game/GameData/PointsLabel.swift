//
//  Score Label.swift
//  Game
//
//  Created by Keagan Strydom on 2018/06/28.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import UIKit

class PointsLabel : UILabel {
    init() {
        let width = Screen.width
        let height = Screen.height / 6.67
        
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        font = UIFont(name: "AvenirNext-UltraLight", size: height / 1.6)
        textAlignment = .center
        textColor = .white
        
        let startingPoints = 0
        text = String(startingPoints)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
