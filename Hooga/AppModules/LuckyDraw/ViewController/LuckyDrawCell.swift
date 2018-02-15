//
//  LuckyDrawCell.swift
//  Hooga
//
//  Created by @mrendra on 06/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class LuckyDrawCell: UICollectionViewCell {

    @IBOutlet weak var imageLucky: UIImageView!
    
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var viewBG: GradientView!
    
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

}
