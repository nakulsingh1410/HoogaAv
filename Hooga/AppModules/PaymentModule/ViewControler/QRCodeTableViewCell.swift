//
//  QRCodeTableViewCell.swift
//  Hooga
//
//  Created by Nakul Singh on 2/6/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class QRCodeTableViewCell: UITableViewCell {
    @IBOutlet weak var qrCodeImage: UIImageView!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var eventType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
