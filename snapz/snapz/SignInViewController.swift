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
    var userData: AnyObject?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginToLevelPage" {
            if let destinationViewController = segue.destination as? GameViewController {
            destinationViewController.userDataPassed = userData
            }
        }
    }
    
      // MARK: - Properties
    
    @IBOutlet weak var signInPasswordLabel: UITextField!
    @IBOutlet weak var signInEmailLabel: UITextField!
    @IBOutlet weak var logInButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            .responseJSON {response in switch response.result {
                
            case .success(let data):
                self.userData = data as AnyObject
                print(type(of: self.userData), separator: "", terminator: "TYPE of USER DATA" )
                
                self.performSegue(withIdentifier: "LoginToLevelPage", sender: self.logInButton)
                print(data, separator: "", terminator: "RESPONSEEEEEEEEEEEEE!!!!!!!!")
            case .failure(let error):
                print("Request failed with error: \(error)")
                }
               
                
        }
        
        
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
