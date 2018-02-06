//
//  GameScene.swift
//  snapz
//
//  Created by MELISSA WARREN on 2/4/18.
//  Copyright © 2018 MELISSA WARREN. All rights reserved.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // declare collision mask categories
    let footballCategory : UInt32 =  0x1 << 1
    let goalCategory : UInt32 =  0x1 << 2



    // declare variables
    var football: SKSpriteNode?
    var rightBar: SKSpriteNode?
    var leftBar: SKSpriteNode?
    var touchPoint: CGPoint = CGPoint()
    var touching: Bool = false
    

   // var football: SKSpriteNode!

    
    // scale controls rate object moves towards location of touch
   // let scale: CGFloat = 2.0
    
    // damping slows sprite when touch ends
    //let damping: CGFloat = 0.98


    
    override func didMove(to view: SKView) {
    
       // self.football = self.childNode(withName: "//football") as? SKSpriteNode
        //football.name = "football"
        //football.position = CGPoint(x: 0, y: -207)
        //self.addChild(football)
        
        // get football node from scene and store it for use
        self.football = self.childNode(withName: "//football") as? SKSpriteNode
        print(football!)
        self.rightBar = self.childNode(withName: "//rightBar") as? SKSpriteNode
        print(rightBar!)
        self.leftBar = self.childNode(withName: "//leftBar") as?
            SKSpriteNode

       // self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        football!.physicsBody = SKPhysicsBody(rectangleOf: (football!.size))
        rightBar!.physicsBody = SKPhysicsBody(rectangleOf: (rightBar!.size))
        leftBar!.physicsBody = SKPhysicsBody(rectangleOf: (leftBar!.size))
       
        
        // set physics world
        physicsWorld.contactDelegate = self
        
        
        // MAKE SHIT BOUNCE OFF WALLLLLS
 
        football!.physicsBody?.categoryBitMask = footballCategory
        football!.physicsBody?.contactTestBitMask = goalCategory
        football!.physicsBody?.collisionBitMask = goalCategory
        
        rightBar!.physicsBody?.categoryBitMask = goalCategory
        rightBar!.physicsBody?.contactTestBitMask = footballCategory
        rightBar!.physicsBody?.collisionBitMask = footballCategory
        
        leftBar!.physicsBody?.categoryBitMask = goalCategory
        leftBar!.physicsBody?.contactTestBitMask = footballCategory
        leftBar!.physicsBody?.collisionBitMask = footballCategory
       
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = borderBody
        self.physicsBody?.friction = 0
        borderBody.contactTestBitMask = goalCategory | footballCategory
        //borderBody.categoryBitMask
        borderBody.collisionBitMask = goalCategory | footballCategory
        
        football!.physicsBody?.usesPreciseCollisionDetection = true
        rightBar!.physicsBody?.usesPreciseCollisionDetection = true
        leftBar!.physicsBody?.usesPreciseCollisionDetection = true
        
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
             let location = touch.location(in: self)

                touchPoint = location
                touching = true
                print(touchPoint)
          //  }
        }


    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch!
        let location = touch!.location(in: self)
        touchPoint = location
        print(touchPoint, separator: "", terminator: "touchpoint in touches moved")
        
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touching = false
        
        print(football!, separator: "", terminator: "football in touches ended")
        
        // scale football and fadeout
     
        //let rotationLeft = SKAction.rotate(byAngle: 20.0, duration: 0.2)
        //let rotationRight = SKAction.rotate(byAngle: -8.0, duration: 0.2)
        let scale = SKAction.scale(to: 0.1, duration: 1.0)
        let fade = SKAction.fadeOut(withDuration: 0.8)
        let wait = SKAction.wait(forDuration: 0.1)
        let fadeIn = SKAction.fadeIn(withDuration: 0.1)
        let resetFootballScale = SKAction.scale(to: 0.9, duration: 0.1)
        let resetFootballPosition = SKAction.move(to: CGPoint(x: 0, y: -200), duration: 0.1)

        let sequence = SKAction.sequence([scale, fade, wait, resetFootballPosition, resetFootballScale, fadeIn])
        football!.run(sequence)
       
        
        //addFootball.run(sequence)
        // touchpoint = nil?
    }
    
    
//    func moveNodeToPoint(football: SKSpriteNode, touchPoint: CGPoint) {
//
//    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
        
       // print(football!, separator: "", terminator: "football in update function")
        
        if touching {
            //let dt:CGFloat = 1.0/60.0
            let dt: CGFloat = 0.5
            print(football!, separator: "football in update")

            let distance = CGVector(dx: touchPoint.x-football!.position.x, dy: touchPoint.y-football!.position.y)
            let velocity = CGVector(dx: distance.dx/dt, dy: distance.dy/dt)
            football!.physicsBody!.velocity=velocity
            

        }
       // football?.removeFromParent()
       // addChild(football!)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("BARRRRRRRRRR")
        print(contact.bodyA.node!)
        if contact.bodyA.categoryBitMask == goalCategory &&  contact.bodyB.categoryBitMask == footballCategory {
            //let contactPoint = contact.contactPoint
            print("BAR HIT BAR HIT BAR HIT BAR HIT")
        }
      
    }
        
    
    
//    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
//    }

//    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
//    }
//
//    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
//    }

 //   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
        
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
//    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }

//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }

//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//

//    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
//    }
}
