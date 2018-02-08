//
//  SignInViewController.swift
//  snapz
//
//  Created by MELISSA WARREN on 2/8/18.
//  Copyright © 2018 MELISSA WARREN. All rights reserved.
//

import UIKit
import Alamofire




class SignInViewController: UIViewController {
    
      // MARK: - Properties
    
    @IBOutlet weak var signInPasswordLabel: UITextField!
    @IBOutlet weak var signInEmailLabel: UITextField!
    @IBOutlet weak var logInButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     // MARK: - Actions
    
    @IBAction func logInButton(_ sender: UIButton) {
        let urlString = "http://localhost:8000/users/login/"
        let requestParams = ["email": self.signInEmailLabel.text,
                             "password": self.signInPasswordLabel.text]
        Alamofire.request(urlString,method: .post, parameters: requestParams, encoding: JSONEncoding.default, headers: [:])
            .responseJSON {response in print(response)}
        
        // load sign in scene
//        performSegue(withIdentifier: "LoginPageFromCreateAccount", sender: self)
        
//        if let scene = SKScene(fileNamed: "LevelsScene") {
//            // Set the scale mode to scale to fit the window
//            scene.scaleMode = .aspectFill
//
//            // Present the scene
//            view.presentScene(scene)
//        func didMoveToView(view: SKScene) {
//            let viewController = self.view?.window?.rootViewController
//            let scene = SKScene(fileNamed: "LevelsScene")
//            scene?.scaleMode = .aspectFill
//            view.presentScene(scene)
//        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
