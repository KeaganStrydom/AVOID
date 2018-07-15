//
//  ThemeDisplay.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/04.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import UIKit
import SpriteKit

struct ThemeOptions {
    private init() {}
    
    static let select = "select"
    static let change = "change"
    static let active = "active"
}

class ThemeView : UIView {
    
    let labelDisplay = UILabel()
    var button = UIButton()
    
    init(in cell : UICollectionViewCell, theme : Theme, scene : GameScene, tag : Int) {
        
        
        super.init(frame: CGRect(x: 0,
                                 y: 0,
                                 width: cell.frame.width,
                                 height: cell.frame.height))
        setupDisplayLabel()
        setThemeOptionfor(theme: theme, scene: scene)
        
        button = ThemeButton(in: self, theme: theme)
        button.addTarget(scene, action: #selector(scene.handleThemeSwitch(sender:)), for: .touchUpInside)
        button.tag = tag
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
        labelDisplay.font = UIFont(name: "AvenirNext-UltraLight", size: 30)
        labelDisplay.textColor = .white
        labelDisplay.textAlignment = .center
        labelDisplay.frame = CGRect(x: 0,
                                    y: 0.70 * self.frame.height,
                                    width: self.frame.width,
                                    height: self.frame.height - buttonHeight)
    }
    
    private func setThemeOptionfor(theme: Theme, scene : GameScene) {
        let delegate = ThemeDelegate(scene: scene)
        let isBought : Bool = delegate.isThemeBought(theme)
        let selectedTheme = scene.settings.getSelectedTheme()
        if isBought && (selectedTheme.name == theme.name){
            changeText(to: ThemeOptions.active)
        } else if isBought && (selectedTheme.name != theme.name) {
            changeText(to: ThemeOptions.select)
        } else if !(isBought) {
            changeText(to: String(theme.price))
        }
    }
    
    private func changeText(to text : String) {
            labelDisplay.text = text
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
