//
//  Logout.swift
//  Berks Wallet
//
//  Created by Deverick Simpson on 5/16/19.
//  Copyright © 2019 ApolloLabs. All rights reserved.
//

import Foundation
import UIKit
import InteractiveSideMenu
import Firebase
import FirebaseAuth
/**
 SideMenu is a controller relevant one of the side menu items. To indicate this it adopts `SideMenuItemContent` protocol.
 **/
class Logout: UIViewController, SideMenuItemContent, Storyboardable {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"Cancel\" alert occured.")
            //self.jumpToProfile()
            self.showSideMenu()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.");
            self.logout()
            self.jumpToLogin()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    //Logs out the current user account
    private func logout(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    //Transition to Login screen from the current
    private func jumpToLogin(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FirstView") as! FirstViewController
        self.present(newViewController, animated: true, completion: nil)
    }
}
