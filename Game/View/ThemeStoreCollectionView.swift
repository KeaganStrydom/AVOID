//
//  ThemeStoreCollectionView.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/15.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import UIKit

class ThemeStore :  UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let identifier = "theme cell"
    var scene : GameScene
    var allThemes : [Theme]
    
    init(scene : GameScene) {
        self.scene = scene
        self.allThemes = scene.settings.getAllThemes()
        
        let frame = CGRect(x: 0,
                           y: 0,
                           width: 0.8 * Screen.width,
                           height: 0.8 * Screen.height)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.width, height: frame.height/4)
        
        super.init(frame: frame, collectionViewLayout: layout)
        let sceneCenter = scene.view!.center
        center.x = sceneCenter.x
        center.y = sceneCenter.y + (0.15 * (scene.view?.frame.height)!)
        dataSource = self
        delegate = self
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        backgroundColor = .clear
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allThemes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        _ = ThemeView(in: cell, theme: allThemes[indexPath.row], scene : scene, tag : indexPath.row)
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
