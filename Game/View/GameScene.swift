//
//  GameScene.swift
//  Game
//
//  Created by Keagan Strydom on 2018/06/26.
//  Copyright © 2018 Lighthouse. All rights reserved.
//
import SpriteKit
import GameplayKit
import AVKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    var settings : SettingsProvider
    var gameInfo = GameVariables(selectedTheme: ThemeDefault())
    var UI = UIGameScene()
    
    init(settings : SettingsProvider) {
        self.settings = settings
        let sizeOfView =  CGSize(width: Screen.width, height: Screen.height)
        super.init(size: sizeOfView )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView){
        let delegate = StartDelegate(scene: self)
        delegate.getSelectedTheme()
        delegate.initScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let position = touch.location(in: self)
            spawnBarrier(at: position)
        }
    }

    func didBegin(_ contact: SKPhysicsContact) {
        var secondBody : SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            secondBody = contact.bodyB
        } else {
            secondBody = contact.bodyA
        }
        
        let nodeName = secondBody.node?.name
        if nodeName == Name.obstacle {
            EndDelegate(scene: self).endGame()
        } else if nodeName == Name.barrier {
            self.increasePoints()
        }
    }
    
    private func increasePoints() {
        gameInfo.intPoints += 1
    }
    
    @objc func spawnDarkness(){
        let upperBound = frame.width/2
        let lowerBound = -(frame.width/2)
        let xPos = CGFloat(arc4random_uniform(UInt32((upperBound + 1) - lowerBound + lowerBound)))
        let darkness = Darkness.init(frame: self.frame, xPos: xPos, scene: self, theme: gameInfo.selectedTheme)
        self.addChild(darkness)
    }
    
    func playMusic() {
        gameInfo.musicPlayer.play()
    }
    
    func addBorder(to object: SKNode, withBody border: SKPhysicsBody) {
        border.isDynamic = false
        border.friction = 0
        border.restitution = 1
        border.collisionBitMask = 0
        border.contactTestBitMask = CollisionCategory.ballCategory
        border.categoryBitMask = CollisionCategory.borderCategory
        object.physicsBody = border
    }
    
    func spawnBarrier(at position: CGPoint) {
        if gameInfo.isGameRunning {
            let barrier = Barrier(frame: self.frame, position: position, textureImage: gameInfo.selectedTheme.barrierTexture)
            let border = SKPhysicsBody(rectangleOf: barrier.size)
            border.categoryBitMask =  0x1 << 3
            addBorder(to: barrier, withBody: border)
            self.addChild(barrier)
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        incFrame()
        canSpawnTrail()
        canIncreaseDarkness()
        updateLabelPoints()
        handleMusicReset()
    }
    
    private func updateLabelPoints() {
        if gameInfo.isGameRunning {
            UI.labelPoints.text = String(gameInfo.intPoints)
        }
    }
    
    private func incFrame() {
        gameInfo.intFrame += 1
    }
    
    func handleMusicReset() {
        if !(gameInfo.musicPlayer.isPlaying) && settings.getMusicState() == SoundOptions.muted && gameInfo.isGameRunning {
            playMusic()
        }
    }
    
    func canSpawnTrail() {
        if gameInfo.isGameRunning && gameInfo.intFrame % 5 == 0 {
            displayTrail(at: UI.gameBall.position)
        }
    }
    
    private func canIncreaseDarkness() {
        if gameInfo.isGameRunning && gameInfo.intPoints % 10  == 0 {
            
        }
    }
    
    private func displayTrail(at pos: CGPoint) {
        let trail = Ball.init(type: .trail, pos: pos, textureImage: gameInfo.selectedTheme.ballTexture)
        self.addChild(trail)
    }
    
    @objc func handleBeginGame(){
        let delegate = StartDelegate(scene: self)
        delegate.beginGame()
    }
    @objc func handleRetry() {
        let delegate = EndDelegate(scene : self)
        delegate.dismissEndView()
    }
    @objc func handleSoundInvert() {
        let delegate = EndDelegate(scene : self)
        delegate.invertSoundOption()
    }
    @objc func handleThemeClick(){
        let delegate = ThemeDelegate(scene: self)
        delegate.showThemeStore()
    }
    @objc func handleBackButton(){
        let delegate = EndDelegate(scene : self)
        delegate.presentEndView()
    }
    @objc func handleThemeSwitch(sender: UIButton){
        let delegate = ThemeDelegate(scene: self)
        delegate.switchToTheme(sender: sender)
    }
}

