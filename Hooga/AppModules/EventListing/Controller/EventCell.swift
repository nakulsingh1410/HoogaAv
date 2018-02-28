//
//  EventCell.swift
//  HoogaApp
//
//  Created by @mrendra on 21/01/18.
//  Copyright © 2018 Amrendra. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

//    @IBOutlet weak var buttonEventDetail: UIButton!
//    @IBOutlet weak var labelEventTime: UILabel!
    @IBOutlet weak var labelEventDate: UILabel!
//    @IBOutlet weak var labelEventCode: UILabel!
    @IBOutlet weak var labelEventTitle: UILabel!
    @IBOutlet weak var imageViewEvent: UIImageView!
    @IBOutlet weak var viewForShadow: UIView!
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        labelEventTitle.font = Font.gillSansBold(size: 20)
        labelEventDate.font = Font.gothamBook(size: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
