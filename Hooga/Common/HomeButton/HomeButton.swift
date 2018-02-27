//
//  HomeButton.swift
//  Hooga
//
//  Created by Nakul Singh on 2/27/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class HomeButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.addTarget(self, action: #selector(homeButton_didPressed(button:)), for: .touchUpInside)
    }
    
    @objc func homeButton_didPressed(button : UIButton) {
      NavigationManager.setUpSlideMenu()
    }

}
