//
//  GameScene.swift
//  snapz
//
//  Created by MELISSA WARREN on 2/4/18.
//  Copyright © 2018 MELISSA WARREN. All rights reserved.
//

import SpriteKit
import Alamofire


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
    var countdownLabel = SKLabelNode(fontNamed: "HelveticaNeue-Bold ")
    var gameCountdownLabel =  SKLabelNode(fontNamed: "HelveticaNeue-Bold ")
    var gameCount: Int = 15 {
        didSet {
            gameCountdownLabel.text = "\(gameCount)"
        }
    }
    var scoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-Bold ")
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var gameOverLabel = SKLabelNode(fontNamed: "HelveticaNeue-Bold ")
    var endCount: Int = 5
    var youWinLabel = SKLabelNode(fontNamed: "HelveticaNeue-Bold ")
  

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
        touchdown!.physicsBody = SKPhysicsBody(rectangleOf: (touchdown!.size))
        touchdown!.physicsBody?.affectedByGravity = false

        
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
            if score < 3 {
            print("game over")
            gameOverLabel.horizontalAlignmentMode = .center
            gameOverLabel.verticalAlignmentMode = .baseline
            gameOverLabel.position = CGPoint(x: 0, y: -600)
            gameOverLabel.fontColor = SKColor.white
            gameOverLabel.fontSize = 80
            gameOverLabel.zPosition = 100
            gameOverLabel.numberOfLines = 0
            gameOverLabel.text = "Game\nOver"
            addChild(gameOverLabel)
            
            let fadeText = SKAction.fadeIn(withDuration: 0.9)
            let moveGameOverLabel = SKAction.move(to: CGPoint(x: 0, y: -50), duration: 0.1)
            
            let sequence = SKAction.sequence([moveGameOverLabel, fadeText])
            gameOverLabel.run(sequence)
            
            let timeBeforeLevelPage = SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.run(countdownTime)])
            run(SKAction.sequence([SKAction.repeat(timeBeforeLevelPage, count: 5), SKAction.run(backToLevels)]))
            }
        }
        
    
        func countdownTime () {
            endCount = endCount - 1
        }
        
        func backToLevels() {
            let scene = SKScene(fileNamed: "LevelsScene")
            scene!.scaleMode = .aspectFill
            view.presentScene(scene)
        }
        

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
            let dt: CGFloat = 0.4

            let distance = CGVector(dx: touchPoint.x-football!.position.x, dy: touchPoint.y-football!.position.y)
            let velocity = CGVector(dx: distance.dx/dt, dy: distance.dy/dt)
            football!.physicsBody!.velocity=velocity
        }
    }
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
      //  print("BARRRRRRRRRR")
      // print(contact.bodyA, separator: "-------------", terminator: "CONTACTaaaaaaaaa")
      // print(contact.bodyB, separator: "-------------", terminator: "CONTACTbbbbbbbbbbbbbbbbb")

       
        if contact.bodyA.node?.name == "touchdown" || contact.bodyB.node?.name == "touchdown" {
            //let contactPoint = contact.contactPoint
            
             contactCount = contactCount + 1
            if contactCount % 2 == 0 {
                print("SCCCCCCCCCCCCCCCOOOOOOOOOOOOOOOOORRRRREEEEEEEEEEEEEEEEEEE")
                score = score + 1
                if score == 3 {
                    youWin ()
                }
            }
            
        }
      
    }
    
    func youWin () {
        print("you win")
        youWinLabel.verticalAlignmentMode = .baseline
        youWinLabel.position = CGPoint(x: 0, y: -600)
        youWinLabel.fontColor = SKColor.white
        youWinLabel.fontSize = 65
        youWinLabel.zPosition = 100
        youWinLabel.numberOfLines = 0
        youWinLabel.text = "Level\nComplete"
        addChild(youWinLabel)
        
        let fadeText = SKAction.fadeIn(withDuration: 0.9)
        let moveGameOverLabel = SKAction.move(to: CGPoint(x: 0, y: -50), duration: 0.1)
        
        let sequence = SKAction.sequence([moveGameOverLabel, fadeText])
        youWinLabel.run(sequence)
        
        let timeBeforeLevelPage = SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.run(countdownTime)])
        run(SKAction.sequence([SKAction.repeat(timeBeforeLevelPage, count: 5), SKAction.run(backToLevels)]))
    }
    
    
    // repeat functions!! find out why these aren't in scope when called from dig begin contact
    func countdownTime () {
        endCount = endCount - 1
    }
    
    
    func backToLevels() {
        
        // get access to gameviewcontroller...get user information passed from login
        var currentViewController: GameViewController?
        var upstreamResponder: UIResponder? = self.view
        var found = false
        
        while (found != true){
            upstreamResponder = upstreamResponder!.next
            if let viewController = upstreamResponder as? GameViewController {
                currentViewController = viewController
                found = true
            }
            if upstreamResponder == nil {
                //could not find VC, PANIC!
                break
            }
        }
        // get current user logged in from gameviewcontroller
         let userNamePassed = currentViewController?.userDataPassed! as? [[String : AnyObject]]
        let userId = userNamePassed![0]["id"] as! Int?
        // add points to user
        
        let urlString = "http://localhost:8000/users/user/:id/"
        let requestParams = ["points": 100, "id": userId]
        
        Alamofire.request(urlString,method: .post, parameters: requestParams, encoding: JSONEncoding.default, headers: [:])
            .responseJSON {response in print(response)
                
          
        // go back to levels scene
        changeScene ()
  
 
    }
    
    func changeScene() {
        
        let scene = SKScene(fileNamed: "LevelsScene")
        //pass user points
        LevelsScene.userPointsWon = 100
        scene!.scaleMode = .aspectFill
        self.view?.presentScene(scene)
        }
    }

}

