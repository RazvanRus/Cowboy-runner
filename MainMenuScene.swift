//
//  MainMenuScene.swift
//  Cowboy runner
//
//  Created by Rus Razvan on 05/05/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    var scoreLabel = SKLabelNode(fontNamed: "RosewoodStd-Regular")

    
    override func didMove(to view: SKView) {
        
        initialize()
        
    }
    
    func initialize() {
        createGrounds()
        createBackgrounds()
        createLabel()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveBackgroundsAndGrounds()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "Play" {
                let mainMenu = GameplayScene(fileNamed: "GameplayScene")
                mainMenu?.scaleMode = .aspectFill
                self.view?.presentScene(mainMenu!, transition: SKTransition.crossFade(withDuration: TimeInterval(0.5)))
            }
            if atPoint(location).name == "Highscore" {
                // display highscore
                displayHighscore()
            }
        }
    }
    
    func displayHighscore() {
        scoreLabel.text = "\(GameManager.instance.getHighscore()) m"
        scoreLabel.isHidden = false
    }
    
    func createLabel() {
        scoreLabel.zPosition = 8
        scoreLabel.position = CGPoint(x: 0, y: 200)
        scoreLabel.fontSize = 120
        scoreLabel.text = String(0)
        self.addChild(scoreLabel)
        scoreLabel.isHidden = true
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

    
}






















