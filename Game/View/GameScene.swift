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
                self.physicsWorld.contactDelegate = self
                var secondBody : SKPhysicsBody
        
                if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
                    secondBody = contact.bodyB
                } else {
                    secondBody = contact.bodyA
                }
        
                guard let secondNode = secondBody.node else {
                    return
                }

        if secondNode.name == Name.darkness || secondNode.name == Name.wall {
            if gameInfo.activePowerup == nil {
                EndDelegate(scene: self).endGame()
            } else {
                gameInfo.activePowerup?.collision(with: secondNode, in: self)
            }
        }
        else if secondNode.name == Name.barrier {
            PointsIndicator(in: self, addend: gameInfo.pointsAddend, position: secondNode.position)
            
            self.increasePoints(by: gameInfo.pointsAddend)
        }
        else if secondNode.name == Name.powerup {
            guard let powerup : Powerup = secondNode as? Powerup else {
                return
            }
            gameInfo.activePowerup = powerup
            powerup.affect(self)
        }
    }

    func increasePoints(by addend: Int) {
        gameInfo.intPoints += addend
        increasSpawnSpeedTo(getSpeedForDifficulty())
    }
    
    public func activateSpawner() {
        let wait = SKAction.wait(forDuration: gameInfo.darknessFrequency)
        let spawn = SKAction.run(spawnDarkness)
        gameInfo.darknessSpawner.run(SKAction.repeatForever(SKAction.sequence([wait,spawn])))
        addChild(gameInfo.darknessSpawner)
    }
    
    public func deactivateSpawner() {
        gameInfo.darknessSpawner.removeAllActions()
        gameInfo.darknessSpawner.removeFromParent()
    }
    
    private func increasSpawnSpeedTo(_ speed : CGFloat) {
        gameInfo.darknessSpawner.speed = speed
    }
    
    @objc func spawnDarkness(){
        if gameInfo.isGameRunning {
            let upperBound = Int(frame.width/2)
            let lowerBound = Int(-(frame.width/2))
            
            let xPosition = CGFloat(Random.generateNumber(between: lowerBound,and: upperBound))
            let darkness = Darkness.init(frame: self.frame, xPos: xPosition , scene: self, theme: gameInfo.selectedTheme)
            self.addChild(darkness)
            
            canSpawnPowerup()
            }
        }


    func canSpawnPowerup() {
        if gameInfo.activePowerup == nil {
        let randomNumber = Random.generateNumber(between: 0, and: 100)
        if Probability.inOdds(randomNumber, oddsRange: 0...60) {
            let powerupSpawnTimer = Timer.scheduledTimer(timeInterval: 0.5,
                                                         target: self,
                                                         selector: #selector(spawnPowerup),
                                                         userInfo: nil,
                                                         repeats: false)
            }
        }
    }
    
    @objc func spawnPowerup() {
        let upperBound = Int(Screen.width/2 * 0.8)
        let lowerBound = Int((Screen.width/2) * -0.8) 
        let xPosition = CGFloat(Random.generateNumber(between: lowerBound, and: upperBound))
        guard let newPowerup : Powerup = PowerupFactory.makeRandom(in: self, at: CGPoint(x: xPosition,
                                                                                         y: Screen.height)) else {
            return
        }
    }
    
   
    func playMusic() {
        gameInfo.musicPlayer?.play()
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
        if gameInfo.isGameRunning && gameInfo.canSpawnBarrier {
            delayBarrierSpawn()
            let barrier = Barrier(frame: self.frame, position: position, textureImage: gameInfo.selectedTheme.barrierTexture)
            let border = SKPhysicsBody(rectangleOf: barrier.size)
            border.categoryBitMask = CollisionCategory.barrierCategory
            addBorder(to: barrier, withBody: border)
            self.addChild(barrier)
        }
    }
    
    
    func delayBarrierSpawn() {
        gameInfo.canSpawnBarrier = false
        _ = Timer.scheduledTimer(withTimeInterval: gameInfo.barrierSpawnDelay, repeats: false, block: { (timer) in
            self.gameInfo.canSpawnBarrier = true
        })
    }
    

    public func animatePoints( target : Int, current : Int) {
        var currentNum : Int
        if (target - current) > 400 {
            currentNum = target - 400
        } else {
            currentNum = current
        }
        if current != target {
            UIView.animate(withDuration: 1, animations: {
                self.UI.labelPoints.text = "•" + String(currentNum)
                
            }) { (success) in
                if target > current {
                    self.animatePoints(target: target, current: currentNum + 1)
                } else {
                    self.animatePoints(target: target, current: currentNum - 1)
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        incFrame()
        canSpawnTrail()
        updateLabelPoints()
        handleMusicReset()
        resetYPos(ball: UI.gameBall)
    }
    
    private func resetYPos(ball : Ball) {
        if  ball.position.y != 0 {
            ball.position.y = 0
        }
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
        if !((gameInfo.musicPlayer?.isPlaying)!) && settings.getMusicState() == SoundOptions.unmuted && gameInfo.isGameRunning {
            playMusic()
        }
    }
    
    func canSpawnTrail() {
        if gameInfo.isGameRunning && gameInfo.intFrame % 5 == 0  && UI.buttonStart.alpha == 0{
            displayTrail(at: UI.gameBall.position)
        }
    }
    
    private func getSpeedForDifficulty() -> CGFloat {
        switch gameInfo.intPoints {
        case 0...10 : return (1)
        case 10...30 : return (1.5)
        case 30...40 : return (2)
        case _ where gameInfo.intPoints > 40 : return (2)
        default:
            return 2
        }
    }
    
    private func displayTrail(at pos: CGPoint) {
        let trail = Ball.init(type: .trail, pos: pos, textureImage: #imageLiteral(resourceName: "Trail ball"))
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
