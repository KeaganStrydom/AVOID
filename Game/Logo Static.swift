//
//  Logo Static.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/17.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import  UIKit

class Logo : UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = #imageLiteral(resourceName: "Lightbox logo")
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
