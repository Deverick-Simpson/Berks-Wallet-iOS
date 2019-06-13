//
//  MainViewController.swift
//  
//
//  Created by Deverick Simpson on 2/22/19.
//

import UIKit
import Foundation
import InteractiveSideMenu
import Firebase
import FirebaseAuth

class MainViewController: MenuContainerViewController, UITextFieldDelegate {
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Assign the sidebar menu
        self.menuViewController = SideMenuViewController.storyboardViewController()
        self.contentViewControllers = contentControllers()
        self.selectContentViewController(contentViewControllers.first!)
        
        
        uploadDataToDatabase()

        
    }
    
    private func contentControllers() -> [UIViewController] {

        let kittyController = MainMenu.storyboardViewController()
        let kittyController2 = BerksBucks.storyboardViewController()
        let kittyController3 = jukebox.storyboardViewController()
        let kittyController4 = SettingsUI.storyboardViewController()
        let kittyController5 = Logout.storyboardViewController()
        return [kittyController,kittyController2,kittyController3,kittyController4,kittyController5]
        
        
    }
    
    //Deprecated Test function to upload a sample barber to the barber db
    private func uploadDataToDatabase(){
        
        let instanceOfUser = Data_Access()
        instanceOfUser.uploadAda()
        
        
    }
    

    

}
