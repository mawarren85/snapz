//
//  LevelsScene.swift
//  snapz
//
//  Created by MELISSA WARREN on 2/6/18.
//  Copyright © 2018 MELISSA WARREN. All rights reserved.
//

import UIKit
import SpriteKit

class LevelsScene: SKScene {
    
    var level1: SKSpriteNode?
    var userName: SKLabelNode?
    var userPoints: SKLabelNode?
    var userPointCount: Int?
    static var userPointsWon = 0
    
   


    
    override func didMove(to view: SKView) {
        
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
        
        // being all kinds of difficult getting data from the user object
        let userNamePassed = currentViewController?.userDataPassed! as? [[String : AnyObject]]
        let playerName = userNamePassed![0]["name"] as? String
        let playerPointsPassed = userNamePassed![0]["points"] as? Int
       
        
        print(userNamePassed![0]["name"] as? String)
        
        // get user labels
        self.userName = self.childNode(withName: "//userName") as? SKLabelNode
        self.userPoints = self.childNode(withName: "//userPoints") as? SKLabelNode
        
        
        // set label text

        userName?.text = "Player: \(playerName!)"
        
        if playerPointsPassed == nil {
            userPoints?.text = "Points: 0"
        } else {
            let totalUserPoints = playerPointsPassed! + LevelsScene.userPointsWon
            userPoints?.text = "Points: \(totalUserPoints)"
       
        }
        
        
        
        
       
        // get level 1 image node
        self.level1 = self.childNode(withName: "//level1") as? SKSpriteNode
        print("Hello")
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("you touched")
        print(touches.first!)
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        let touchedNode = self.atPoint(touchLocation)
        
        // get level one game scene
        if (touchedNode.name == "level1") {
            let scene = SKScene(fileNamed: "GameScene")
            scene!.scaleMode = .aspectFill
            view?.presentScene(scene)
            
        }
    }
    
 
}
