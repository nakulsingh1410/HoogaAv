//
//  FaqCell.swift
//  Hooga
//
//  Created by @mrendra on 30/01/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class FaqCell: UITableViewCell {

     
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelAnswer: UILabel!
    
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

}
