//
//  GameplayScene.swift
//  Cowboy runner
//
//  Created by Rus Razvan on 04/05/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    var player = Player()
    var canJump = false
    var onObstacle = false
    var isAlive = false
    var obstacles = [SKSpriteNode]()
    
    
    
    override func didMove(to view: SKView) {
        initialize()
    }
    
    func initialize() {
        physicsWorld.contactDelegate = self
        createBackgrounds()
        createGrounds()
        createPlayer()
        isAlive = true
        createObstacles()
        checkPlayerBounds()
        
        Timer.scheduledTimer(timeInterval: TimeInterval(randomBetweenNumbers(firstNumber: 2, secoundeNoumber: 6)), target: self, selector: #selector(GameplayScene.spawnObstacles), userInfo: nil, repeats: true)
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveBackgroundsAndGrounds()
        if onObstacle {
            movePlayerBack()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if canJump {
            canJump = false
            onObstacle = false
            player.jump()
        }
    }
    
    
    /// contact between physics bodyes
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secoundBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secoundBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secoundBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Player" && secoundBody.node?.name == "Ground" {
            canJump = true
        }
        
        if firstBody.node?.name == "Player" && secoundBody.node?.name == "Obstacle" {
            canJump = true
            onObstacle = true
        }
        
        if firstBody.node?.name == "Player" && secoundBody.node?.name == "Cactus" {
            // kill player
            isAlive = false
        }
    }
    
    
    
    
    
    func createPlayer() {
        player = Player(imageNamed: "Player 1")
        player.initialize()
        player.position = CGPoint(x: -10, y: 20)
        self.addChild(player)
    }
    
    
    func createBackgrounds() {
        for i in 0...2 {
            let bg = SKSpriteNode(imageNamed: "BG")
            bg.name = "BG"
            bg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            bg.position = CGPoint(x: CGFloat(i) * bg.size.width, y: 0)
            bg.zPosition = 0
            self.addChild(bg)
        }
    }
    
    
    func createGrounds() {
        for i in 0...2 {
            let ground = SKSpriteNode(imageNamed: "Ground")
            ground.name = "Ground"
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            ground.position = CGPoint(x: CGFloat(i) * ground.size.width, y: -(self.frame.size.height / 2))
            ground.zPosition = 3
            ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
            ground.physicsBody?.affectedByGravity = false
            ground.physicsBody?.isDynamic = false
            ground.physicsBody?.categoryBitMask = ColliderType.Ground
            self.addChild(ground)
        }
    }
    
    
    func moveBackgroundsAndGrounds() {
        enumerateChildNodes(withName: "BG", using: ({
            (node, error) in
            
            node.position.x -= 1;
            
            if node.position.x < -(self.frame.width) {
                node.position.x += self.frame.width * 3
            }
        }))
        
        enumerateChildNodes(withName: "Ground", using: ({
            (node, error) in
            
            //casting a node
            let groundNode = node as! SKSpriteNode
            
            groundNode.position.x -= 5
            
            if groundNode.position.x < -(self.frame.width) {
                groundNode.position.x += groundNode.size.width * 3
            }
        }))
    }
    
    func movePlayerBack() {
        player.position.x -= 5
    }
    
    func createObstacles() {
        
        for i in 0...5 {
            let obstacle = SKSpriteNode(imageNamed: "Obstacle \(i)")
            if i == 0 {
                obstacle.name = "Cactus"
                obstacle.setScale(0.15)
            } else {
                obstacle.name = "Obstacle"
                obstacle.setScale(0.6)
            }
            obstacle.setScale(0.5)
            obstacle.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            obstacle.zPosition = 1
            
            obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
            obstacle.physicsBody?.allowsRotation = false
            obstacle.physicsBody?.categoryBitMask = ColliderType.Obstacle

            obstacles.append(obstacle)
        }
        
    }
    
    func spawnObstacles() {
        
        let index = Int(arc4random_uniform(UInt32(obstacles.count)))
        let obstacle = obstacles[index].copy() as! SKSpriteNode
        
        obstacle.position = CGPoint(x: self.frame.width + obstacle.size.width, y: 50)
        
        let move = SKAction.moveTo(x: -(self.frame.size.width*2), duration: TimeInterval(14))
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([move,remove])
        
        obstacle.run(sequence)
        
        self.addChild(obstacle)
    }
    
    
    func randomBetweenNumbers(firstNumber: CGFloat,secoundeNoumber: CGFloat) -> CGFloat {
        let randomNumber = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNumber - secoundeNoumber) + min(firstNumber, secoundeNoumber)
        print(randomNumber)
        
        return randomNumber
    }
    
    func checkPlayerBounds() {
        if isAlive {
            if player.position.x < -(self.frame.size.width / 2) - 20 {
                playerDied()
            }
        }
    }
    
    func playerDied() {
        isAlive = false

    }
    
}




