//
//  GameScene.swift
//  SpriteKitPractice
//
//  Created by Yeji Seo on 10/14/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let background = SKSpriteNode(imageNamed: "skyGradient")
    let player = SKSpriteNode(imageNamed: "molang_player")
    let ground = SKSpriteNode(imageNamed: "ground")
//    let platform = SKSpriteNode(imageNamed: "skyGradient")
    
    enum bitmasks: UInt32 {
        case player = 0b1
//        case platform = 0b10
    }
    override func didMove(to view: SKView) {
        self.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        self.anchorPoint = .zero
        
        
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = 1
        addChild(background)
        
        physicsWorld.contactDelegate = self
        
        ground.position = CGPoint(x: size.width / 2, y: 10)
        ground.zPosition = 5
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.allowsRotation = false
        ground.physicsBody?.affectedByGravity = false
        addChild(ground)
        
        print("Ground size: \(ground.size)")
        
        player.size = CGSize(width: 200, height: 200)
        player.position = CGPoint(x: size.width / 2, y: size.height / 13)
        player.zPosition = 10
        player.setScale(0.5)
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.height / 2)
        player.physicsBody?.isDynamic = true // later will change true
        player.physicsBody?.restitution = 0
        player.physicsBody?.friction = 0
        player.physicsBody?.angularDamping = 0
        addChild(player)
    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            let location = touch.location(in: self)
//            
//            player.position.x = location.x
//        
//        }
//    }
//   
////    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
////        player.physicsBody?.isDynamic = true
////        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200))
////    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//            // 터치가 끝났을 때 점프
//            if let _ = touches.first {
//                // 점프할 때마다 위치를 초기화
//                player.physicsBody?.isDynamic = true // 동적 설정
//
//                // 점프 힘 적용
//                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 300))
//                
//                // 점프 후에 플레이어를 초기 위치로 되돌리기 위해 타이머를 설정
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    // 플레이어의 위치를 초기 위치로 되돌립니다
//                    self.player.position.y = self.size.height / 13
//                    // 물리 바디를 정지 상태로 설정
//                    self.player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
//                    self.player.physicsBody?.isDynamic = false
//                }
//            }
//        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        }

        func touchDown(atPoint pos: CGPoint) {
            jump()
        }

        func jump() {
//            player?.texture = SKTexture(imageNamed: "player_jumping")
            player.texture = SKTexture(imageNamed: "upp")
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200))
        }

        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        }

        func touchUp(atPoint pos: CGPoint) {
            player.texture = SKTexture(imageNamed: "molang_player")
        }

}
