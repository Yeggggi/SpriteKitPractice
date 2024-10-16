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
    let player = SKSpriteNode(imageNamed: "hamd")
    let ground = SKSpriteNode(imageNamed: "ground")
    private var seeds: [SKSpriteNode] = []
    var coinValue = 0

    
    override func didMove(to view: SKView) {
        self.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        self.anchorPoint = .zero
        
        
        
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = 1
        addChild(background)
        
        physicsWorld.contactDelegate = self
        
        ground.position = CGPoint(x: size.width / 2, y: 40)
        ground.zPosition = 5
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.allowsRotation = false
        ground.physicsBody?.affectedByGravity = false
        
        ground.physicsBody?.categoryBitMask = 2
//        ground.physicsBody?.contactTestBitMask = 3  // ground와의 접촉을 감지하지 않는다
        ground.physicsBody?.collisionBitMask = 1 // player와 충돌 가능함
        
        addChild(ground)
        
        print("Ground size: \(ground.size)")
        
        player.anchorPoint = .init(x: 0.5, y: 1)
        player.size = CGSize(width: 200, height: 200)
        player.position = CGPoint(x: size.width / 2, y: 300)
        print("player position y: \(player.position)")
        player.zPosition = 10
        player.setScale(0.5)
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.height/2)
        player.physicsBody?.isDynamic = true // later will change true
        player.physicsBody?.restitution = 0
        player.physicsBody?.friction = 0 // 풍선...
        player.physicsBody?.angularDamping = 100
        // 물리적 세계에 함께 하기 위한 비트마스크 설정
        player.physicsBody?.categoryBitMask = 1
        player.physicsBody?.contactTestBitMask = 2
        player.physicsBody?.collisionBitMask = 2
        addChild(player)
        
        startDroppingSeeds()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchUp(atPoint: t.location(in: self))
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 터치
        for t in touches {
            let touchLocation = t.location(in: self)
            player.run(SKAction.move(to: touchLocation, duration: 0.3))
        }
    }
    
    
    func touchUp(atPoint pos: CGPoint) {
        player.run(SKAction.move(to: pos, duration: 0.3))
        jump()
    }
    
    func jump() {
        player.texture = SKTexture(imageNamed: "hamu")
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    func touchDown(atPoint pos: CGPoint) {
        player.texture = SKTexture(imageNamed: "hamd")
    }
    
    // 블루베리 떨굼
    func startDroppingSeeds() {
        let dropAction = SKAction.run { [weak self] in
            self?.createSeed()
        }
        
        let waitAction = SKAction.wait(forDuration: 1.0) // 블루베리 간격
        run(SKAction.repeatForever(SKAction.sequence([dropAction, waitAction])))
     }
    
    
    // 블루베리 생성 함수
    func createSeed() {
        let seed = SKSpriteNode(imageNamed: "seed")
        
        
        seed.size = CGSize(width: 100, height: 100)
        let randomX = CGFloat.random(in: 0...size.width)
        seed.position = CGPoint(x: randomX, y: size.height)
        
        seed.zPosition = 5 // 화면의 layer 에서 우선순위 높음을 의미하는듯 A greater zPosition will sort in front of a lesser zPosition
        seed.physicsBody = SKPhysicsBody(circleOfRadius: seed.size.width / 2)

        
        seed.physicsBody?.categoryBitMask = 2
        seed.physicsBody?.contactTestBitMask = 1
        seed.physicsBody?.collisionBitMask = 0
        seed.physicsBody?.isDynamic = true
        
        self.addChild(seed)
        seeds.append(seed)
        
        let moveAction = SKAction.moveTo(y: 0, duration: 5.0)
        seed.run(moveAction)
    }
    
    // 충돌 감지 처리
        func didBegin(_ contact: SKPhysicsContact) {
            let bodyA = contact.bodyA.node as? SKSpriteNode
            let bodyB = contact.bodyB.node as? SKSpriteNode
            
            if bodyA == ground || bodyB == ground {
                return
            }
            
            if let seed = (bodyA == player ? bodyB : bodyA) {
                coinValue = coinValue + 1
                handleSeedCollision(seed)
            }
        }

        func handleSeedCollision(_ seed: SKSpriteNode) {
            seed.removeFromParent()
            seeds.removeAll { $0 == seed }
            print("Seed collected! \(coinValue)")
        }
    
    
    
}
