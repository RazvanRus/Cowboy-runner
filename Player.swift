//
//  Player.swift
//  Cowboy runner
//
//  Created by Rus Razvan on 04/05/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let Player: UInt32 = 1
    static let Ground: UInt32 = 2
    static let Obstacle: UInt32 = 3
}

class Player: SKSpriteNode {

    var playerWalkAnimation = [SKTexture]()
    var playerWalkAnimationAction = SKAction()
    
    
    func initialize() {
        createPlayer()
        createAnimation()
        startPlayerWalkAnimation()
    }
    
    func createAnimation() {
        for i in 1...11 {
            let name = "Player \(i)"
            playerWalkAnimation.append(SKTexture(imageNamed: name))
        }
        playerWalkAnimationAction = SKAction.animate(with: playerWalkAnimation, timePerFrame: TimeInterval(0.064), resize: true, restore: true)
    }
    
    func createPlayer() {
        self.name = "Player"
        self.zPosition = 2
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.setScale(0.5)
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 20, height: self.size.height))
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = ColliderType.Player
        self.physicsBody?.collisionBitMask = ColliderType.Ground | ColliderType.Obstacle
        self.physicsBody?.contactTestBitMask = ColliderType.Obstacle | ColliderType.Obstacle
    }
    
    func jump() {
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 220))
    }
    
    func startPlayerWalkAnimation() {
        self.run(SKAction.repeatForever(playerWalkAnimationAction))
    }
    
}




























