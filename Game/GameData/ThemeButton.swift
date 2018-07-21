//
//  ThemeDisplay.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/04.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import UIKit
import SpriteKit

enum ThemeStatus : String {
    case active = "active"
    case selectable = "select"
    case purchasable = "change"
    case noStatus = "invalid status"
}

extension ThemeStatus {
    var sortIndex : Int {
        switch self {
        case .active:
            return 0
        case .selectable:
            return 1
        case .purchasable:
            return 2
        case .noStatus:
            return 3
        }
    }
}

class ThemeView : UIView {
    
    let labelDisplay = UILabel()
    var button = UIButton()
    var scene : GameScene
    
    init(in cell : UICollectionViewCell, theme : Theme, scene : GameScene) {
        self.scene = scene
        super.init(frame: CGRect(x: 0,
                                 y: 0,
                                 width: cell.frame.width,
                                 height: cell.frame.height))
        setupDisplayLabel()
        setThemeOptionfor(theme: theme, scene: scene)
        
        button = ThemeButton(in: self, theme: theme)
        button.addTarget(scene, action: #selector(scene.handleThemeSwitch(sender:)), for: .touchUpInside)
        setTagFrom(theme)
        
        self.alpha = 1
        self.clipsToBounds = true
        self.backgroundColor = UIColor(red: 0.8,
                                       green: 0.8,
                                       blue: 0.8,
                                       alpha: 0.3)
        
        let cornerRadius = Screen.width * (4/75)
        self.layer.cornerRadius = cornerRadius
        
        self.addSubview(labelDisplay)
        cell.addSubview(self)
    }
    
    private func setupDisplayLabel() {
        let buttonHeight = 0.8 * self.frame.height
        
        labelDisplay.font = UIFont(name: "AvenirNext-UltraLight", size: Screen.height * 0.04076)
        labelDisplay.textColor = .white
        labelDisplay.textAlignment = .center
        labelDisplay.frame = CGRect(x: 0,
                                    y: 0.70 * self.frame.height,
                                    width: self.frame.width,
                                    height: self.frame.height - buttonHeight)
    }
    
    private func setThemeOptionfor(theme: Theme, scene : GameScene) {
        if theme.status == .purchasable {
            changeText(to: ("• " + String(theme.price)))
        } else {
            changeText(to: theme.status.rawValue)
        }
    }
    
    private func changeText(to text : String) {
            labelDisplay.text = text
        }
    
    private func setTagFrom(_ theme : Theme) {
        button.tag = 0
        
        let allThemes = scene.settings.getAllThemes()
        for current in allThemes {
            if theme.name == current.name {
             break
            }
            button.tag += 1
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ThemeButton : UIButton {
    let theme : Theme
    
    init(in view : UIView, theme : Theme) {
        self.theme = theme
        super.init(frame : CGRect(x: 0,
                                  y: 0,
                                  width: view.frame.width,
                                  height: 0.8 * view.frame.height))
        
        view.addSubview(self)
        self.setImage(theme.buttonTexture, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        /*
        Make background color alpha 0.1
        if button alpha is mutated the background
        remains transulcent and other objects are
        at the set alpha.
        */
        //Allow to interacted with by User
        self.isUserInteractionEnabled = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
