//
//  SocialButton.swift
//  Hooga
//
//  Created by @mrendra on 30/01/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class SocialButton: UIButton {

    var url : String?
    
     required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.addTarget(self, action: #selector(buttonSocialMedia_didPressed(button:)), for: .touchUpInside)
    }

    @objc func buttonSocialMedia_didPressed(button : UIButton) {
        
        guard let strUrl = url, let Url = URL(string: strUrl) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(Url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(Url)
        }
    }
}
