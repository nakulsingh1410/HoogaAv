//
//  HoogaTextField.swift
//  Hooga
//
//  Created by Nakul Singh on 1/14/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class HoogaTextField: UITextField ,UITextFieldDelegate{

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let frames = bounds
        return frames.insetBy(dx:10,dy:0)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let frames = bounds
        return frames.insetBy(dx:10,dy:0)
    }
}
