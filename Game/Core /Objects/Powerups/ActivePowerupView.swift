//
//  ActivePowerupView.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/22.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import UIKit

class ActivePowerupView : UIView {
    
    init(in scene : GameScene, powerupImage : UIImage) {
        let height = Screen.height * 0.2
        let frame = CGRect(x: 0, y: (Screen.height) - height, width: Screen.width, height: height)
        super.init(frame: frame)
        
        backgroundColor = .clear
        scene.view?.addSubview(self)
        
        let activePowerImageView = UIImageView(image: powerupImage)
        activePowerImageView.backgroundColor = .clear
        activePowerImageView.contentMode = .scaleAspectFit
        activePowerImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activePowerImageView)
        
        activePowerImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activePowerImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activePowerImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45).isActive = true
        activePowerImageView.widthAnchor.constraint(equalTo: activePowerImageView.heightAnchor, multiplier: 1).isActive = true
        
        
        
        let timerView = UIView()
        timerView.backgroundColor = .white

        timerView.frame = CGRect(x: 0, y: height - (0.15 * height), width: Screen.width, height: 0.15 * height)
        self.addSubview(timerView)
        
        timerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        timerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
        timerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        animate(timerView)
        
    }
    
    private func animate(_ view : UIView) {
        let height = Screen.height * 0.2
        UIView.animate(withDuration: 8, animations: {
            view.frame = CGRect(x: 0, y: height - (0.1 * height), width: 0, height: 0.1 * height)
        }) { (completion) in
            self.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
