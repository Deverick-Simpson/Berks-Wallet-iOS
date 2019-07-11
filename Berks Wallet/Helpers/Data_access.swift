//
//  Data_Access.swift
//  Berks Wallet
//
//  Created by Deverick Simpson on 5/16/19.
//  Copyright © 2019 ApolloLabs. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import PhoneNumberKit

class Data_Access{
    
    /*
     * We will store email however we need a master chain for
     * validation on the network.
     *  Also do we need an id for eafch employee.  Uniq identifier
     * should probably be email.
     *  Do we need structs here as input will directly.  Object useful
     * for logic
     */
    var count: Int = 0
    let phoneNumberKit = PhoneNumberKit()
    
    
    struct barber {
        var id: String
        var first_name: String
        var last_name: String
        var email: String
        
        
        init(id: String, first_name: String, last_name: String, email: String) {
            self.id = id
            self.first_name = first_name
            self.last_name = last_name
            self.email = email
            
        }
    }
    

    
    
    /*
     *  Discuss with Cory whether we ant to store customer emails
     *  I get the initial feeling that we do not need this type of
     *  sanity check.
     */
    struct client{
        var first_name: String
        var last_name: String
        var phoneNum: Int
        var pBarber: String
        var birthday: Int
        
        init(pBarber: String, first_name: String, last_name: String, phoneNum: Int, birthday: Int) {
            self.first_name = first_name
            self.last_name = last_name
            self.pBarber = pBarber
            self.phoneNum = phoneNum
            self.birthday = birthday
        }
    }

    
    var arrayOfBarbers: [barber] = []
    var arrayOfClients: [client] = []
    
    /*
     *  Getter Methods for DB
     *
     */
    let db = Firestore.firestore()
    
    
    

    
    /*
     * Prints the local copy of the barber list from the db
     * Call on buildArray before using this function.  Could
     * consider moving buildArray within the array but there
     * may be be a duplicate run.
     *
     */
    func printBarberArray(){
        for barber in arrayOfBarbers {
            print(barber)
        }
    }


    

    /*
     * Saving user profile used for registration period but could also
     * be used for the update functionality later.  Will leave generic.
     * This function uploads data to the Google Firestore DB
     * Response:          0 -> Fail & 1 -> Pass
     */
    func saveUserProfile(firstName: String, lastName: String, phone: String,email: String, pBarber: String, birthday: Int) -> Int {
        var resp: Int = 10
        let schedule_collection = db.collection("clients")
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = schedule_collection.addDocument(data: [
            "first_name": firstName,
            "last_name": lastName,
            "phone": phone,
            "pBarber": pBarber,
            "birthday": birthday,
            "email": email
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                resp = 0
            } else {
                print("Document added with ID: \(ref!.documentID)")
                resp = 1
            }
        }
        
        return resp
    }
    
    /*
     *
     *  Here validate naming convention
     */
    
    
    func addBarber(first_name: String, last_name: String, email: String){
        let schedule_collection = db.collection("barbers")
        
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = schedule_collection.addDocument(data: [
            "first_name": first_name,
            "last_name": last_name,
            "email": email
        ]) { err in
            if let err = err {
                print("Error adding barber document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func addService(){
        
    }
    
    
    /*
     *  Getter Methods for to Populate Array from DB
     *
     */
    
    func buildAllBarbersArray(completion: @escaping () -> Void) {
        return db.collection("barbers").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let singleBarber = barber(id: document.get("id") as! String, first_name: document.get("first_name") as! String, last_name: document.get("last_name") as! String, email: document.get("email") as! String);
                    self.arrayOfBarbers.append(singleBarber)
                }
            }
            completion()
        }
    }
    


    func popBarberCount(completion: @escaping (Int) -> Void) {
        db.collection("barbers").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                self.count = -10
              
            } else {
                self.count = querySnapshot!.documents.count;
            }
             completion(1)
        }
       
    }

    func retCount()-> Int {
        return self.count
    }
    

    /* What happens when barber list is empty?  Seg faul the shit out
     * of it thats what.  Sanity check necessary.
     */
    func retBarberFromIdx(value: Int) -> String {
        if(arrayOfBarbers[value].first_name != "" && arrayOfBarbers[value].last_name != ""){
                    return arrayOfBarbers[value].first_name + " " + arrayOfBarbers[value].last_name
        }else{
            print("Barber array list found empty.")
            return ""
        }
    }
    
    func getAllApps(){
        return db.collection("appointment").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    func getAllSched(){
        db.collection("Schedule").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    func getClientList(){
        db.collection("client").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    func getServices(){
        db.collection("service").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    /*
     * Input validation methods added here to scrub user input.  Research
     * ptential phone input parameters.  Keyboard should be phone based, without
     * alphabet
     */
    //For email validation
    func isValidEmail(testStr:String) -> Bool {
        print("Validating Email-ID: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
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
    
    
    func isValidData(phone: Int) -> Bool{
        if isValidEmail(testStr: "kirit@gmail.com"){
            print("Validate EmailID")
            return true
        }
        else{
            print("invalide EmailID")
            return false
        }
    }
    
    
    func uploadAda(){
        let schedule_collection = db.collection("barbers")
        
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = schedule_collection.addDocument(data: [
            "first_name": "Ada",
            "last_name": "Lovelace",
            "id": "1815"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func parsePhone(phoneNum:String){
        do {
            let phoneNumber = try phoneNumberKit.parse(phoneNum)
//            let phoneNumberCustomDefaultRegion = try phoneNumberKit.parse(phoneNum, withRegion: "US", ignoreType: true)
//          print("Phone number: \(phoneNumber.nationalNumber)")
//          print("Phone number Region: \(phoneNumberCustomDefaultRegion.countryCode)")
//
//          let interPhone = phoneNumberKit.format(phoneNumber, toType: .international)
//          print("Phone number international format: \(interPhone)")
        }
        catch {
            print("Generic parser error")
        }
    }
    
    
    func uploadNewClient(first_name: String, last_name: String, phoneNum: Int, pBarber: String, birthday: Int){
        let client_collection = db.collection("client")
        
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = client_collection.addDocument(data: [
            "first_name": first_name,
            "last_name": last_name,
            "phoneNum": phoneNum,
            "pBarber": pBarber,
            "birthday": birthday
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    
}
