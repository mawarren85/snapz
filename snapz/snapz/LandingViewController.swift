//
//  LandingViewController.swift
//  snapz
//
//  Created by MELISSA WARREN on 2/8/18.
//  Copyright © 2018 MELISSA WARREN. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    // MARK- Actions
    
    @IBAction func loginButton(_ sender: UIButton) {
          performSegue(withIdentifier: "logoToLogin", sender: self)
        
    }
    
    
    
    @IBAction func signupButton(_ sender: UIButton) {
          performSegue(withIdentifier: "logoToCreate", sender: self)
    }
}
