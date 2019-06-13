//
//  FifthViewController.swift
//  Berks Wallet
//
//  Created by Deverick Simpson on 12/24/18.
//  Copyright © 2018 ApolloLabs. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class BerksBucks: UIViewController, SideMenuItemContent, Storyboardable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Show side menu on menu button click
    @IBAction func openMenu(_ sender: UIButton) {
        showSideMenu()
    }
    
    
}

