//
//  EventTitleCell.swift
//  Hooga
//
//  Created by @mrendra on 28/01/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class EventTitleCell: UITableViewCell {

    
    @IBOutlet weak var labelEvntTitle: UILabel!
    
    @IBOutlet weak var labelDateTime: UILabel!
    
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelVanue: UILabel!
    @IBOutlet weak var readMoreBtnConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnReadMore: UIButton!
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnReadMoreTapped(_ sender: Any) {
    }
}
