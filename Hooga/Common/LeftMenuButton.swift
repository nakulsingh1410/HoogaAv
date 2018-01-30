//
//  LeftMenuButton.swift
//  Hooga
//
//  Created by Nakul Singh on 1/30/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class LeftMenuButton: UIButton {
    var viewController:UIViewController?
   
    override func awakeFromNib() {
        setLeftMenu()
        if  let vc = viewController {
            vc.setLeftMenuButtonForCustomeHeader()
        }
    }
    
    func setLeftMenu() {
        if  let _ = viewController {
            self.setTitle(nil, for: .normal)
            let  image = UIImage(named:"ic_menu_black_24dp")?.withRenderingMode(.alwaysTemplate)
            self.setImage(image, for: .normal)
            self.tintColor = UIColor.white
        }
    }

}
