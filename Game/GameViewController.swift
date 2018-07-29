//
//  GameViewController.swift
//  Game
//
//  Created by Keagan Strydom on 2018/06/26.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    let settings : SettingsProvider = SettingsProviderFactory.useUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hasConfigBeenSet()
        initGameScene()
    }
    
    private func initGameScene() {

        let scene = GameScene(settings: settings, sender: self)
            scene.scaleMode = .aspectFill
        
        if let view = self.view as! SKView? {
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
        }
    }
    
    private func hasConfigBeenSet() {
        if !(settings.isConfigSet()) {
            initConfig()
        }
    }
    
    private func initConfig() {
        settings.updateSelectedThemeTo(ThemeDefault())
        settings.initBoughtThemes()
        settings.updateMusicStateTo(SoundOptions.unmuted)
        
    }
    
    func playBassMusic() {
        let bassMusic = SoundPlayer(resourceName: "Music-Bass")
        bassMusic?.play()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
