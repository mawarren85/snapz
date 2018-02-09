//
//  GameViewController.swift
//  snapz
//
//  Created by MELISSA WARREN on 2/4/18.
//  Copyright © 2018 MELISSA WARREN. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

var userDataPassed: AnyObject!

class GameViewController: UIViewController {
    //get user info that logged in
    var userDataPassed: AnyObject?
    
    var currentGame: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
   
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "LevelsScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
            
                
            
                // allow user info to be passed to scene view
                print(userDataPassed!, separator: "", terminator: "USER DATA PASSED!!!!!!!!")
                print(type(of: userDataPassed))
//
//                scene.userData = NSMutableDictionary()
//                scene.userData?.setObject(userDataPassed ?? "", forKey: "userDataPassed" as NSCopying)
//
                // Present the scene
                view.presentScene(scene)
                
                
                
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
