//
//  MenuTitleAppearance.swift
//  HoogaApp
//
//  Created by @mrendra on 20/01/18.
//  Copyright © 2018 Amrendra. All rights reserved.
//

import UIKit

class DefaultAppearance: NSObject {
    
    var titleColor                          : UIColor?
    var titleSelectedColor            : UIColor?
    var selectedCellBGColor       : UIColor?
    var unselectedCellBGColor   : UIColor?
    var defualtCellBGColor         : UIColor?
    var borderColor                      : UIColor?
    var borderWidth                     : Float?
    var deviderColor                    : UIColor?
    var deviderWidth                    : Float?
    var fontTitle                           : UIFont?
    
    override init() {
        super.init()
       
        self.titleColor                            = UIColor.black
        self.titleSelectedColor              = UIColor.white
        self.selectedCellBGColor         = UIColor.blue
        self.unselectedCellBGColor     = UIColor.white
        self.defualtCellBGColor          = UIColor.white;
        self.borderWidth                      = 1.0
        self.deviderWidth                    =  1.0
        self.borderColor                      =  UIColor.lightGray
        self.deviderColor                    = UIColor.lightGray
        self.fontTitle                           = UIFont.systemFont(ofSize: 14.0)
    }
    class  func defaultAppearance() -> DefaultAppearance {
        return DefaultAppearance();
    }
}

 class Menu: DefaultAppearance {
    
    var selectedImage    : String?
    var image                 : String?
    var title                    : String?
    
    override init() {
        super.init()
    }
    init(item:[String:String]) {
        
        super.init()
        self.selectedImage = item["selected"]
        self.image              = item["unselected"]
        self.title                  = item["title"]
    }
}
