//
//  ContactCell.swift
//  Hooga
//
//  Created by @mrendra on 28/01/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    @IBOutlet weak var labelContactInfoLabel: UILabel!

    @IBOutlet weak var labelPhoneNumber: UILabel!
    @IBOutlet weak var labelEmailAddress: UILabel!
    
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    func loadCellData(eventDetail:EventDetail)  {
        labelPhoneNumber.text = ""
        labelEmailAddress.text = ""
        var flag = true
        if let organizerphone = eventDetail.organizerphone?.trim() {
            labelPhoneNumber.text = organizerphone
            flag = false
        }
        if let organizeremail = eventDetail.organizeremail?.trim() {
            labelEmailAddress.text = " | " + organizeremail
            flag = false
        }
        if flag {
            labelContactInfoLabel.text = ""
        }
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
