//
//  ProfileSetupViewController.swift
//  Berks Wallet
//
//  Created by Deverick Simpson on 12/24/18.
//  Copyright © 2018 ApolloLabs. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth

class ProfileSetupViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let db_api = Data_Access()
    var count2: Int = -1
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var userbirthday: UIDatePicker!
    @IBOutlet weak var barberMenu: UIPickerView!
    let pickerData = ["Mozzarella","Gorgonzola","Provolone","Brie","Maytag Blue","Sharp Cheddar","Monterrey Jack","Stilton","Gouda","Goat Cheese", "Asiago"]

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // Capture the picker view selection
//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        // This method is triggered whenever the user makes a change to the picker selection.
//        // The parameter named row and component represents what was selected.
//        if db_api.grabBarberCount() != nil {
//            return db_api.mapAndReturn(row: row)
//        }
//
//    }
    
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        userbirthday.setValue(UIColor.white, forKeyPath: "textColor")
        userbirthday.setValue(false, forKey: "highlightsToday")
        count2 = db_api.returnCount()
        print("Here comes the count\(count2)")
        print("Help")
        db_api.buildAllBarbersArray()
        print("I made it")
        print("Testing teh value\(db_api.retBarWIdx(row: 1))")
        //DB Check
        //db_api.uploadAda()
        
        // Connect barber list dataset:
        barberMenu.delegate = self
        barberMenu.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.

        
        //Load barber Data from DB
        if Auth.auth().currentUser != nil {
            // User is signed in.
            // ...
            let user = Auth.auth().currentUser
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                let uid = user.uid
                let email = user.email
                let photoURL = user.photoURL
            }
        } else {
            // No user is signed in.
            // Kick the user out
            // ...
        }
    }
    
    override func viewDidAppear(_ animated: Bool){
//        super.viewDidAppear(animated)
//        if Auth.auth().currentUser != nil {
//            self.performSegue(withIdentifier: "home", sender: nil)
//        }
    }


    @IBAction func submitProfile(_ sender: Any) {
        if isValidEmail(testStr: "kirit@gmail.com"){
            print("Validate EmailID")
        }
        else{
            print("invalide EmailID")
        }
    }
    
    
    
    //For mobile number validation
    func isValidPhone(phone: String) -> Bool {
        
        let phoneRegex = "^((0091)|(\\+91)|0?)[6789]{1}\\d{9}$";
        let valid = NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
        return valid
    }
    
    func validate(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    //For email validation
    func isValidEmail(testStr:String) -> Bool {
        print("Validating Email-ID: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    
}

