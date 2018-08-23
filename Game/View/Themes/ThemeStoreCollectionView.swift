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
    
    
    init(scene : GameScene) {
        self.scene = scene
        
        let frame = CGRect(x: 0,
                           y: 0,
                           width: 0.8 * Screen.width,
                           height: 0.8 * Screen.height)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.width, height: frame.height/4)
        
        super.init(frame: frame, collectionViewLayout: layout)
        let sceneCenter = scene.view!.center
        center.x = sceneCenter.x
        center.y = Screen.height - (Screen.height * 0.4)
        dataSource = self
        delegate = self
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        backgroundColor = .clear
    }
    
    private func sortThemes() -> [Theme] {
        let sortedThemes : [Theme] = scene.settings.getAllThemes()
        return sortedThemes.sorted(by: { $0.status.sortIndex < $1.status.sortIndex})
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scene.settings.getAllThemes().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        let sortedThemes = sortThemes()
        
        _ = ThemeView(in: cell, theme: sortedThemes[indexPath.row], scene : scene)
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
