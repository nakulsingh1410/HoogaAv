//
//  HoogaLabel.swift
//  Hooga
//
//  Created by Nakul Singh on 1/14/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class HoogaLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        
        if let size = self.font?.pointSize{
            if self.tag == 10 {
                self.font = Font.gillSansSemiBold(size: size)
            }else{
                self.font = Font.gillSansRegular(size: size)
            }
        }
        
        if let txt = text , txt != "DOB"{
            self.text = self.text?.capitalized
        }
        
       
    }

}
