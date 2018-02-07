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
    let footballCategory : UInt32 =  1 << 0
    let goalCategory : UInt32 =  1 << 1
    let touchdownCategory : UInt32 =  1 << 3
    

    // declare variables
    var football: SKSpriteNode?
    var rightBar: SKSpriteNode?
    var leftBar: SKSpriteNode?
    var touchdown: SKSpriteNode?
    var touchPoint: CGPoint = CGPoint()
    var touching: Bool = false
    var contactCount : Int = 0
    var count: Int = 5
    var countdownLabel = SKLabelNode(fontNamed: "ArialMT")
    var gameCountdownLabel =  SKLabelNode(fontNamed: "ArialMT")
    var gameCount: Int = 15 {
        didSet {
            gameCountdownLabel.text = "\(gameCount)"
        }
    }
    var scoreLabel = SKLabelNode(fontNamed: "ArialMT")
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    

   // var football: SKSpriteNode!

    
    // scale controls rate object moves towards location of touch
   // let scale: CGFloat = 2.0
    
    // damping slows sprite when touch ends
    //let damping: CGFloat = 0.98


    
    override func didMove(to view: SKView) {
        

        
        // define game score label properties
        scoreLabel.fontColor = SKColor.white
        scoreLabel.fontSize = 25
        scoreLabel.position = CGPoint(x: -100, y: 245)
        scoreLabel.text = "Score: \(score)"
        addChild(scoreLabel)
    
        
       // self.football = self.childNode(withName: "//football") as? SKSpriteNode
        //football.name = "football"
        //football.position = CGPoint(x: 0, y: -207)
        //self.addChild(football)
        
        // get football node from scene and store it for use
        self.football = self.childNode(withName: "//football") as? SKSpriteNode
        football?.setScale(0.50)
        print(football!)
        self.rightBar = self.childNode(withName: "//rightBar") as? SKSpriteNode
        print(rightBar!)
        self.leftBar = self.childNode(withName: "//leftBar") as?
            SKSpriteNode
        self.touchdown = self.childNode(withName:"//touchdown") as? SKSpriteNode
        print(touchdown!, separator: "", terminator: "TOUCHDOWN")

       // self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        football!.physicsBody = SKPhysicsBody(rectangleOf: (football!.size))
       // football!.physicsBody?.contactTestBitMask = touchdownCategory
        //football!.physicsBody?.collisionBitMask = 0
        touchdown!.physicsBody = SKPhysicsBody(rectangleOf: (touchdown!.size))
       // touchdown!.physicsBody?.contactTestBitMask = footballCategory
        touchdown!.physicsBody?.affectedByGravity = false
      //  touchdown!.physicsBody?.collisionBitMask = 0
        
//        rightBar!.physicsBody = SKPhysicsBody(rectangleOf: (rightBar!.size))
//        leftBar!.physicsBody = SKPhysicsBody(rectangleOf: (leftBar!.size))
       
        
        // set physics world

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
        
        touchdown!.physicsBody?.categoryBitMask = touchdownCategory
        touchdown!.physicsBody?.contactTestBitMask = footballCategory
        touchdown!.physicsBody?.collisionBitMask = 0
       
        
        self.physicsWorld.contactDelegate = self
        
//        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
//        self.physicsBody = borderBody
//        self.physicsBody?.friction = 0
//        borderBody.contactTestBitMask = goalCategory | footballCategory
        //borderBody.categoryBitMask
    
       // football!.physicsBody?.collisionBitMask = goalCategory
        
        football!.physicsBody?.usesPreciseCollisionDetection = true
        rightBar!.physicsBody?.usesPreciseCollisionDetection = true
        leftBar!.physicsBody?.usesPreciseCollisionDetection = true
        
        
        // before game start countdown
        
        func countdown(count: Int) {
            print("in countdown....................")
            countdownLabel.horizontalAlignmentMode = .center
            countdownLabel.verticalAlignmentMode = .baseline
            countdownLabel.position = CGPoint(x: 0, y: 0)
            countdownLabel.fontColor = SKColor.white
            countdownLabel.fontSize = 150
            countdownLabel.zPosition = 100
            countdownLabel.text = "\(count)"
            
            addChild(countdownLabel)
            
            let counterDecrement = SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.run(countdownAction)])
            run(SKAction.sequence([SKAction.repeat(counterDecrement, count: 5), SKAction.run(endCountdown)]))
            
        }
        
        
        func countdownAction () {
            // fade numbers on count
            let fadeoutNumber = SKAction.fadeOut(withDuration: 0.3)
            let fadeinNumber = SKAction.fadeIn(withDuration: 0.3)
            let sequence = SKAction.sequence([fadeoutNumber, fadeinNumber])
            countdownLabel.run(sequence)
            
            count = count - 1
            countdownLabel.text = "\(count)"
        }
        
        
        func endCountdown () {
            countdownLabel.removeFromParent()
            
            // call game countdown function
            gameCountdown(gameCount: 15)
        }
        
        // call countdown function
        countdown(count: 5)
        
        
        // define game countdown label properties
        gameCountdownLabel.fontColor = SKColor.white
        gameCountdownLabel.fontSize = 50
        gameCountdownLabel.position = CGPoint(x: 115, y: 225)
        gameCountdownLabel.text = "\(gameCount)"
        gameCountdownLabel.zPosition = 100
        addChild(gameCountdownLabel)
        
        func gameCountdown(gameCount: Int) {
         //   print("in game countdown....................")
            
            let gameCounterDecrement = SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.run(gameCountdownAction)])
            run(SKAction.sequence([SKAction.repeat(gameCounterDecrement, count: 15), SKAction.run(endGame)]))
            
        }
        
        
        func gameCountdownAction () {
            gameCount = gameCount - 1
            gameCountdownLabel.text = "\(gameCount)"
        }
        
        
        func endGame () {
            print("game over")
        }
        
 
        // light!
        // light!
        
//        let light = SKLightNode()
//        light.name = "light"
//        light.zPosition = 1
//        light.position = CGPoint(x: 150, y: 0)
//        light.categoryBitMask = 4
//        light.falloff = 0.25
//        light.ambientColor = UIColor.darkGray
//        light.lightColor = UIColor.white
//        light.shadowColor = UIColor.black
//        self.addChild(light)
        
//        football?.lightingBitMask = 4
//        rightBar?.lightingBitMask = 4
//        leftBar?.lightingBitMask = 4
        }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
             let location = touch.location(in: self)

                touchPoint = location
                touching = true
             //   print(touchPoint)
          //  }
        }


    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch!
        let location = touch!.location(in: self)
        touchPoint = location
      //  print(touchPoint, separator: "", terminator: "touchpoint in touches moved")
        
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touching = false
        
     //   print(football!, separator: "", terminator: "football in touches ended")
        
        // scale football and fadeout
     
        //let rotationLeft = SKAction.rotate(byAngle: 20.0, duration: 0.2)
        //let rotationRight = SKAction.rotate(byAngle: -8.0, duration: 0.2)
        let scale = SKAction.scale(to: 0.1, duration: 1.0)
        let fade = SKAction.fadeOut(withDuration: 0.5)
        let wait = SKAction.wait(forDuration: 0.1)
        let fadeIn = SKAction.fadeIn(withDuration: 0.1)
        let resetFootballScale = SKAction.scale(to: 0.5, duration: 0.1)
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
            let dt: CGFloat = 0.4
       //     print(football!, separator: "football in update")

            let distance = CGVector(dx: touchPoint.x-football!.position.x, dy: touchPoint.y-football!.position.y)
            let velocity = CGVector(dx: distance.dx/dt, dy: distance.dy/dt)
            football!.physicsBody!.velocity=velocity
            

        }
       // football?.removeFromParent()
       // addChild(football!)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("BARRRRRRRRRR")
       
        print(contact.bodyA, separator: "-------------", terminator: "CONTACTaaaaaaaaa")
          print(contact.bodyB, separator: "-------------", terminator: "CONTACTbbbbbbbbbbbbbbbbb")

       
        if contact.bodyA.node?.name == "touchdown" || contact.bodyB.node?.name == "touchdown" {
            //let contactPoint = contact.contactPoint
            
             contactCount = contactCount + 1
            if contactCount % 2 == 0 {
                print("SCCCCCCCCCCCCCCCOOOOOOOOOOOOOOOOORRRRREEEEEEEEEEEEEEEEEEE")
                score = score + 1
            }
            
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
