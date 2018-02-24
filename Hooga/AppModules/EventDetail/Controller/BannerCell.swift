//  BannerCell.swift
//  Hooga
//  Created by @mrendra on 28/01/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.

import UIKit

class BannerCell: UITableViewCell {

    @IBOutlet weak var imageViewBanner: UIImageView!
    
    
    @IBOutlet weak var labelOrganizedBY: UILabel!
    
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
        //"ORGANIZED BY: " +
        labelOrganizedBY.text =  (eventDetail.organizer)
        if let bnanner = eventDetail.bannerimage {
            let url = kAssets + bnanner
            imageViewBanner.kf.setImage(with: URL(string:url), placeholder: nil, options: nil, progressBlock: nil){ (image, error, cacheType, url) in
                if image == nil {
                    self.imageViewBanner.kf.setImage(with: placeHolderImageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
