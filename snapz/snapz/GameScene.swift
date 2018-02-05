//
//  GameScene.swift
//  snapz
//
//  Created by MELISSA WARREN on 2/4/18.
//  Copyright © 2018 MELISSA WARREN. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
    
    // declare variables
   // class football : SKSpriteNode { }
    var football: SKSpriteNode?
    var touchPoint: CGPoint = CGPoint()
    var touching: Bool = false

    
    
    override func didMove(to view: SKView) {
    
        // get football node from scene and store it for use
        self.football = self.childNode(withName: "//football") as? SKSpriteNode
        print(football!)

        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        football!.physicsBody = SKPhysicsBody(rectangleOf: (football!.size))
        
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
             let location = touch.location(in: self)
           // if (football?.frame.contains(location))! {
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
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touching = false
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        if touching {
            let dt:CGFloat = 1.0/60.0
            let distance = CGVector(dx: touchPoint.x-football!.position.x, dy: touchPoint.y-football!.position.y)
            let velocity = CGVector(dx: distance.dx/dt, dy: distance.dy/dt)
            football!.physicsBody!.velocity=velocity
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
