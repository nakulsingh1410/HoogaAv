//
//  HoogaTextField.swift
//  Hooga
//
//  Created by Nakul Singh on 1/14/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class HoogaTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        setLeftPadding()
       // self.font = Font.lobster(size: 14.0)
        self.placeholder = self.placeholder?.uppercased()
        self.changePlaceholder(placeHolderText: self.placeholder, color: kPlaceHolderColor)
        ///self.addCharacterSpacing(value: 1.2)
        if let size = self.font?.pointSize{
            self.font = Font.gillSansLight(size: size)
        }
    }
    
    func setLeftPadding()  {
       self.addLeftMargin(leftMargin: 8)
       
    }
}


