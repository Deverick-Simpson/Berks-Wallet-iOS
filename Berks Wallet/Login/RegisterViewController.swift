//
//  RegisterViewController.swift
//  Berks Wallet
//
//  Created by Deverick Simpson on 12/24/18.
//  Copyright © 2018 ApolloLabs. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passconf: UITextField!
    
    let db_api = Data_Access()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // Handle the text field’s user input through delegate callbacks.
        username.delegate = self
        password.delegate = self
        passconf.delegate = self
        
    }
    

    

    
    //MARK: Actions
    @IBAction func createAccount(_ sender: Any) {
        if password.text != passconf.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            Auth.auth().createUser(withEmail: username.text!, password: password.text!){ (authResult, error) in
                if error != nil{
                    let nsError = (error! as NSError)
                    print("Error Code #: \(nsError.code)")
                    print("Error Description #: \(nsError.localizedDescription)")
                    print("Debug Description:  \(nsError.debugDescription)")
                    print("User Info:  \(nsError.userInfo)")
                    
                    /*
                     *
                     * Username already exists.  Please login with username or reset password.
                     *
                     */
                    if  nsError.code == 17007{
                        
                        //Example accessing variable data and type casting
                        //let email = nsError.userInfo["FIRAuthErrorUserInfoEmailKey"] as? String
                        //Instead, send to login view with username and password to attempt.
//                        Auth.auth().signIn(withEmail: self.username.text! , password: self.password.text!) { [weak self] user, error in
//                            guard let strongSelf = self else { return }
//                            // ...
//                        }
                        
                        print("email",self.username.text!)
                        print("password",self.password.text!)
                        
                    
                        let alertController = UIAlertController(title: "User Already exists.  Try logging in or reset password.", message: error?.localizedDescription, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: { action in
                            print("Yay! Lets login!"); self.performSegue(withIdentifier: "existtologin", sender: self)
                        })
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                        
                    }else if nsError.code == 17004{
                   
                        let alertController = UIAlertController(title: "User Already exists.  Try logging in or reset password.", message: error?.localizedDescription, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: { action in
                            print("Yay! Lets login!"); self.performSegue(withIdentifier: "backhome", sender: self)
                        })
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    }else{
                        
                        self.performSegue(withIdentifier: "backhome", sender: self)
                        
                        
                        //Do something for the default case.
                    }
                } else if error == nil {
                    //self.db_api.uploadNewClient()
                    self.performSegue(withIdentifier: "signtologin", sender: self)
                }

            }
        }
    }
    
    
    
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        username.resignFirstResponder()
        password.resignFirstResponder()
        passconf.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
    }
    
}
