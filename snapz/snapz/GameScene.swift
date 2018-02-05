//
//  GameScene.swift
//  snapz
//
//  Created by MELISSA WARREN on 2/4/18.
//  Copyright © 2018 MELISSA WARREN. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    

    // declare variables
    var football: SKSpriteNode?
    var touchPoint: CGPoint = CGPoint()
    var touching: Bool = false
    
    // scale controls rate object moves towards location of touch
   // let scale: CGFloat = 2.0
    
    // damping slows sprite when touch ends
    //let damping: CGFloat = 0.98

    
    
    override func didMove(to view: SKView) {
    
        // get football node from scene and store it for use
        self.football = self.childNode(withName: "//football") as? SKSpriteNode
        print(football!)

       // self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        football!.physicsBody = SKPhysicsBody(rectangleOf: (football!.size))
        //football!.physicsBody?.affectedByGravity = false
        
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
        
        // scale football and fadeout
        let scale = SKAction.scale(to: 0.1, duration: 0.7)
        let fade = SKAction.fadeOut(withDuration: 0.7)
        let sequence = SKAction.sequence([scale, fade])
        football!.run(sequence)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touching = false
        // touchpoint = nil?
    }
    
    
//    func moveNodeToPoint(football: SKSpriteNode, touchPoint: CGPoint) {
//
//    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
        if touching {
            //let dt:CGFloat = 1.0/60.0
            let dt: CGFloat = 1


            let distance = CGVector(dx: touchPoint.x-football!.position.x, dy: touchPoint.y-football!.position.y)
            let velocity = CGVector(dx: distance.dx/dt, dy: distance.dy)
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
