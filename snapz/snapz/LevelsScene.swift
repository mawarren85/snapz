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
    
    override func didMove(to view: SKView) {
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
        
        if (touchedNode.name == "level1") {
            let scene = SKScene(fileNamed: "GameScene")
            scene!.scaleMode = .aspectFill
            view?.presentScene(scene)
            
          
        }
    }
    
 
}
