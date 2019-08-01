//
//  ReceiptTableViewCell.swift
//  Berks Wallet
//
//  Created by Deverick Simpson on 7/19/19.
//  Copyright © 2019 ApolloLabs. All rights reserved.
//

import UIKit

class ReceiptTableViewCell: UITableViewCell {

    //Cell Attributes
    @IBOutlet weak var receipt_amount: UILabel!
    @IBOutlet weak var haircut_image_view: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var barber_name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
