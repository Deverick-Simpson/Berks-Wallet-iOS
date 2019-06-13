//
//  jukebox.swift
//  Berks Wallet
//
//  Created by Deverick Simpson on 3/27/19.
//  Copyright © 2019 ApolloLabs. All rights reserved.
//

import UIKit
import InteractiveSideMenu
import Foundation

/**
 Jukebox is a controller relevant one of the side menu items. To indicate this it adopts `SideMenuItemContent` protocol.
 */
class jukebox: UIViewController, SideMenuItemContent, Storyboardable{
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Show side menu on menu button click
    @IBAction func openMenu(_ sender: UIButton) {
        showSideMenu()
    }
}
