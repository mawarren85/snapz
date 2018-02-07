//
//  LoginViewController.swift
//  snapz
//
//  Created by MELISSA WARREN on 2/7/18.
//  Copyright © 2018 MELISSA WARREN. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
     // MARK: - Properties
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var passwordValidationLabel: UILabel!
    @IBOutlet weak var emailValidationLabel: UILabel!
    @IBOutlet weak var nameValidationLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up view..hide validation labels
        setupView()
        
        // register view controller as observer so it knows when text fields are valid and submit button can be clicked
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: Notification.Name.UITextFieldTextDidChange, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - View methods
    
    fileprivate func setupView() {
        // hide save button
        saveButton.isEnabled = false
        
        // hide validation labels
        passwordValidationLabel.isHidden = true
        emailValidationLabel.isHidden = true
        nameValidationLabel.isHidden = true
    }
    
     // MARK: - Helper methods
    
    fileprivate func validate(_ textField: UITextField) -> (Bool, String?) {
        guard let text = textField.text else {
            return (false, nil)
        }
        if textField == passwordTextField {
            return (text.characters.count >= 6, "Your password is too short")
        }
        if textField == emailTextField {
            print("Text field!")
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return (emailTest.evaluate(with: text) == true, "Please enter a valid email")
        }
//        if textField == nameTextField {
//            return (text.characters.count >= 6, "Your password is too short")
//        }
        return (text.characters.count > 0, "This field cannot be empty")
    }

    
    // MARK: - Notification Handling
    
    @objc private func textDidChange(_ notification: Notification) {
        var formIsValid = true
        
        for textField in textFields {
            //validate text field
            let (valid, _) = validate(textField)
            
            guard valid else {
                formIsValid = false
                break
            }
        }
        // update save button
        saveButton.isEnabled = formIsValid
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

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // when user hits return they are taken to the next text field
        switch textField {
        case nameTextField:
            // validate name field not empty
            let (valid, message) = validate(textField)
            if valid {
                emailTextField.becomeFirstResponder()
            }
            // add message to name validation label
            self.nameValidationLabel.text = message
            // show or hide email validation label
            UIView.animate(withDuration: 0.25, animations: {
                self.nameValidationLabel.isHidden = valid
            })
            
        case emailTextField:
            
            //validate email
            let (valid, message) = validate(textField)
            if valid {
                passwordTextField.becomeFirstResponder()
            }
            
            // add message to email validation label
            self.emailValidationLabel.text = message
            
            // show or hide email validation label
            UIView.animate(withDuration: 0.25, animations: {
                self.emailValidationLabel.isHidden = valid
            })
        default:
            // validate password
            let (valid, message) = validate(textField)
            if valid {
                passwordTextField.resignFirstResponder()
            }
            // update password validation label
            self.passwordValidationLabel.text = message
            
            // show or hide password validation label
            UIView.animate(withDuration: 0.25, animations: {
                self.passwordValidationLabel.isHidden = valid
            })
           
            }
        return true
        
    }
}
