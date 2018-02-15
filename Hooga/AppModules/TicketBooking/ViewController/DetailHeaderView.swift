//
//  DetailHeaderView.swift
//  Hooga
//
//  Created by @mrendra on 03/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class DetailHeaderView: UIView {

    @IBInspectable
    public var hideBottomView: Bool = false {
        didSet {
            hideView()
        }
    }
    @IBOutlet weak var viewEventTitle: UIView!
   
    @IBOutlet weak var viewEventType: UIView!
    
    @IBOutlet weak var labelEventTitle: UILabel!

    @IBOutlet weak var labelDateTime: UILabel!
    
    @IBOutlet weak var labelAddress: UILabel!
    
    @IBOutlet weak var labelticketType: UILabel!
    
    @IBOutlet weak var labelPrice: UILabel!
    
    @IBOutlet weak var labelQuantity: UILabel!
    
    @IBOutlet weak var labelTotalPrice: UILabel!
    
    func hideView()  {
        if hideBottomView {
            self.viewEventType.isHidden = hideBottomView
        }
    }
}
