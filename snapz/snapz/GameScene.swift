//
//  GameScene.swift
//  snapz
//
//  Created by MELISSA WARREN on 2/4/18.
//  Copyright © 2018 MELISSA WARREN. All rights reserved.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    

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
        //football.position = CGPoint(x: -140, y: 0)
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
        let scale = SKAction.scale(to: 0.1, duration: 1.0)
        let fade = SKAction.fadeOut(withDuration: 1.0)
        let sequence = SKAction.sequence([scale, fade])
        football!.run(sequence)
        
       // football.removeFromParent()

        
//         add a new football after one is kicked
//        football = SKSpriteNode(imageNamed: "football")
//        football.position = CGPoint(x: 0, y: -122)
//        addFootball.physicsBody = SKPhysicsBody(rectangleOf: (addFootball.size))
//
//        addChild(football!)
        
//        if addFootball == addFootball  {
//            addFootball.run(sequence)
//        }
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
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print(contact.bodyA.node!)
        if contact.bodyA.node == rightBar || contact.bodyB.node == rightBar || contact.bodyA.node == leftBar || contact.bodyB.node == leftBar {
              print("BARRRRRRRRRR")
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
