//
//  HoogaButton.swift
//  Hooga
//
//  Created by Nakul Singh on 1/14/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class HoogaButton: UIButton {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    override func awakeFromNib() {
        
        cornerRadius()
        setbackgroundColor()
    }
    
    func cornerRadius() {
        self.layer.cornerRadius = CGFloat(self.tag)
        self.layer.masksToBounds = true
    }
    
    func setbackgroundColor()  {
        if self.titleLabel?.text != "Back"{
            self.backgroundColor = kButonBackgroundColor
        }
    }
    
    
}
