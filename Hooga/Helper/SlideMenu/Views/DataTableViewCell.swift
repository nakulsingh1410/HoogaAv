//
//  DataTableViewCell.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/8/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

struct DataTableViewCellData {
    
    init(imageUrl: String, text: String) {
        self.imageUrl = imageUrl
        self.text = text
    }
    var imageUrl: String
    var text: String
}

class DataTableViewCell : UITableViewCell {
    
    @IBOutlet weak var dataImage: UIImageView!
    @IBOutlet weak var dataText: UILabel!
    
    override func awakeFromNib() {
//        self.dataText?.font = UIFont.italicSystemFont(ofSize: 16)
//        self.dataText?.textColor = UIColor(hex: "9E9E9E")
        selectionStyle = .none
    }
    
    
    open func setData(_ data: MenuItem) {
        self.backgroundColor = UIColor.clear
        //        self.textLabel?.font = UIFont.italicSystemFont(ofSize: 18)
        dataText.textColor = UIColor.white
        if let menuText = data.title{
            dataText.text = menuText
        }
        if let imageName = data.icon{
            dataImage.image = UIImage(named: imageName)
        }
    }
    
    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.alpha = 0.5
        } else {
            self.alpha = 1.0
        }
    }
//
//    override class func height() -> CGFloat {
//        return 80
//    }
//
//    override func setData(_ data: Any?) {
//        if let data = data as? DataTableViewCellData {
//            self.dataImage.setRandomDownloadImage(80, height: 80)
//            self.dataText.text = data.text
//        }
//    }
}
