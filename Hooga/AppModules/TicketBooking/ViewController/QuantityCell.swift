//
//  QuantityCell.swift
//  Hooga
//
//  Created by @mrendra on 03/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class QuantityCell: UICollectionViewCell {

    @IBOutlet weak var viewBg: UIView!
    
    @IBOutlet weak var labelQuantity: UILabel!
    @IBOutlet weak var labelLine: UILabel!
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
     //  labelQuantity.layer.borderColor = UIColor.black.cgColor
       // labelQuantity.layer.borderWidth = 1.0
    
    }
}
