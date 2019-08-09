//
// SideMenu.swift
//
// Copyright 2017 Handsome LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import UIKit
import Firebase
import InteractiveSideMenu

/**
 SideMenu is a controller relevant one of the side menu items. To indicate this it adopts `SideMenuItemContent` protocol.
 */
class MainMenu: UIViewController, UITableViewDataSource, UITableViewDelegate, SideMenuItemContent, Storyboardable {

    let db_api = Data_Access()
    
    @IBOutlet weak var tableView: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        db_api.buildUserHistoryList(completion: printholder)
        // This view controller itself will provide the delegate methods and row data for the table view.
    }
    
    func printholder(){
        print("Done building user history list")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db_api.userHistoryCount()
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptTableViewCell") as! ReceiptTableViewCell
        
        let text = db_api.arrayOfClientHistory[indexPath.row]
        
        //Cell First and Last name
        cell.barber_name.text = text.first_name + text.last_name
        
        //Cell Total Amount
        var totalString = String(format: "%f", text.amount)
        cell.receipt_amount.text = totalString
        
        //        text.date.dateValue()
        
        
        //        let dateformatter = DateFormatter()
        //
        //        dateformatter.dateStyle = DateFormatter.Style.short
        //
        //        dateformatter.timeStyle = DateFormatter.Style.short
        
        //        let dateString = dateformatter.string(from: text.date.dateValue())
        //cell.date.text = dateString
        
        
        return cell
        
        
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }

    
    @IBAction func Schedule_Action(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Appointment", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Appointment")
        self.present(newViewController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func History_Action(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "HistoryView", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HistoryView")
        self.present(newViewController, animated: true, completion: nil)

    }
    
}
