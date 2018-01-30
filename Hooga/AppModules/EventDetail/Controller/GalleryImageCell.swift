//
//  GalleryImageCell.swift
//  Hooga
//
//  Created by @mrendra on 29/01/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class GalleryImageCell: UICollectionViewCell {

    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var buttonPlay: UIButton!
    
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
