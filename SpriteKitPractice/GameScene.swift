//
//  GameScene.swift
//  SpriteKitPractice
//
//  Created by Yeji Seo on 10/14/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let background = SKSpriteNode(imageNamed: "skyGradient")
    let player = SKSpriteNode(imageNamed: "molang_player")
    let ground = SKSpriteNode(imageNamed: "ground")
//    let platform = SKSpriteNode(imageNamed: "skyGradient")
    
    override func didMove(to view: SKView) {
        self.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        self.anchorPoint = .zero
        
        
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = 1
        addChild(background)
        
//        ground.size = self.size
        ground.position = CGPoint(x: size.width / 2, y: 10)
        ground.zPosition = 5
//        ground.setScale(2.5)
        addChild(ground)
        
        print("Ground size: \(ground.size)")
    }

   
}
