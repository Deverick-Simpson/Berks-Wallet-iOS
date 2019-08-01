//
//  History.swift
//  Berks Wallet
//
//  Created by Deverick Simpson on 7/19/19.
//  Copyright © 2019 ApolloLabs. All rights reserved.
//
import UIKit

class HistoryView: UIViewController, UITableViewDataSource, UITableViewDelegate{

    let db_api = Data_Access()
    

    @IBOutlet var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as! ReceiptTableViewCell
        
        let text = db_api.arrayOfClientHistory[indexPath.row]
        
        //add last name
        cell.barber_name.text = text.first_name
        
        return cell
        
        
    }

    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
}
