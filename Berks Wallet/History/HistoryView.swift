//
//  History.swift
//  Berks Wallet
//
//  Created by Deverick Simpson on 7/19/19.
//  Copyright © 2019 ApolloLabs. All rights reserved.
//
import UIKit
import Firebase
import SwiftDate
import InteractiveSideMenu

class HistoryView: UIViewController, UITableViewDataSource, UITableViewDelegate, SideMenuItemContent, Storyboardable{

    let db_api = Data_Access()
    

    @IBOutlet var tableView: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
