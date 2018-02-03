//
//  CommonHeaderView.swift
//  Hooga
//
//  Created by @mrendra on 03/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class CommonHeaderView: UIView {

    var headerView : DetailHeaderView!
    
    @IBInspectable
    public var hidePriceDetailView: Bool = false {
        didSet {
           
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addHeaderView() 
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addHeaderView()  {
        let nib = UINib.init(nibName: "DetailHeaderView", bundle: nil)
        
        let views = nib.instantiate(withOwner: self, options: nil)
        
        headerView = views[0] as! DetailHeaderView
        headerView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        self.addSubview(headerView)
    }
    
    func hideView()  {
        
        if hidePriceDetailView {
            self.headerView.viewEventType.isHidden = hidePriceDetailView
        }
    }
}
