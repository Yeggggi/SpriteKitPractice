////
////  Player.swift
////  SpriteKitPractice
////
////  Created by Yeji Seo on 10/14/24.
////
//
//import Foundation
//import SpriteKit
//
//class Player: SKSpriteNode, SKPhysicsContactDelegate {
//
//    public var inAir = false
//
//    private let zeroFloat = CGFloat(0.0)
//
//    private static var runAnimation: SKAction {
//        get {
//            let run1 = SKTexture(imageNamed: "downPlayer")
//            let run2 = SKTexture(imageNamed: "upPlayer")
////            let run3 = SKTexture(imageNamed: "hero03")
////            let run4 = SKTexture(imageNamed: "hero04")
//
//            let runTexture = [run1, run2]
////            _ = SKAction.animate(with: runTexture, timePerFrame: 0.1, resize: false, restore: true)
//            let foreverRun = SKAction.play()
//
//            return foreverRun
//        }
//    }
//
//    private static var upJump: SKTexture {
//        get {
//            return SKTexture(imageNamed: "heroUp")
//        }
//    }
//
//    private static var downJump: SKTexture {
//        get {
//            return SKTexture(imageNamed: "heroDown")
//        }
//    }
//
////    //For ver_2: different jump texture for up and down
////    public func updateAnimation() {
////        guard let physicsBody = self.physicsBody else { return }
////
////        if physicsBody.velocity.dx < zeroFloat ||
////            physicsBody.velocity.dy < zeroFloat {
////            texture = Player.downJump
////        } else if physicsBody.velocity.dx > zeroFloat ||
////            physicsBody.velocity.dy > zeroFloat {
////            texture = Player.upJump
////        } else if physicsBody.velocity.dx == zeroFloat ||
////            physicsBody.velocity.dy == zeroFloat {
////            run(Player.runAnimation)
////        }
////    }
//
////    public func run() {
////        run(Player.runAnimation)
////    }
//
//    public func jump() {
//        removeAllActions()
//        texture = Player.upJump
//    }
//
//}
