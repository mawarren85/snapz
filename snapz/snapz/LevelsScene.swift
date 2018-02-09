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
        
        let userNamePassed = currentViewController?.userDataPassed! as? [[String : AnyObject]]
        print(userNamePassed![0]["name"] as? String)
        
      
       // let ugh = dictionary!["name"] as? Double
                // access individual value in dictionary
               // print(ugh, separator: "", terminator: "this is ugh in the dictionary")
                userName?.text = userNamePassed![0]["name"] as? String
                addChild(userName!)
            
        
       

        
        print(userNamePassed, separator: "", terminator: "ISTHISWORKIGN?????")
        
        // get level 1
        self.level1 = self.childNode(withName: "//level1") as? SKSpriteNode
        print("Hello")
        
        // get user labels
        self.userName = self.childNode(withName: "//userName") as? SKLabelNode
        self.userPoints = self.childNode(withName: "//userPoints") as? SKLabelNode
        
        
        
//        // get user info from gameviewcontroller
//        if let userDataPassed = self.userData?.value(forKey: "userDataPassed") {
//            print("gameInfo is :\(userDataPassed)")
//            print(type(of: userDataPassed))
        
//
//        }
     
       
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("you touched")
        print(touches.first!)
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        let touchedNode = self.atPoint(touchLocation)
        
        if (touchedNode.name == "level1") {
            let scene = SKScene(fileNamed: "GameScene")
            scene!.scaleMode = .aspectFill
            view?.presentScene(scene)
            
          
        }
    }
    
 
}
