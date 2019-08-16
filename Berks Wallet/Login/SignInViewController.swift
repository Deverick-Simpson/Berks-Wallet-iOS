//
//  SignInViewController.swift
//  Berks Wallet
//
//  Created by Deverick Simpson on 12/24/18.
//  Copyright © 2018 ApolloLabs. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController, UITextFieldDelegate{
    //MARK: Properties
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    /*
     * Send Request to php server for Login
     * Input: NA
     * Output: Http Response Code
     *
     */
    func signInServerFunction() {
        Auth.auth().signIn(withEmail: username.text!, password: password.text!) { (user, error) in
            if error == nil{
                self.performSegue(withIdentifier: "loginToHome", sender: self)
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true
        // Handle the text field’s user input through delegate callbacks.
        username.delegate = self
        password.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        username.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
    }
    
    
    
    //MARK: Actions
    @IBAction func LoginAttempt(_ sender: Any) {
        print("Button Pressed")
        signInServerFunction()
    }
    
    @IBAction func ForgotPass(_ sender: Any) {
        
 
    }
    
    
}
