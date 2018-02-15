//
//  FilterTableFooterView.swift
//  YasMobileSDK
//
//  Created by Nakul Singh on 2/6/18.
//  Copyright © 2018 Miral. All rights reserved.
//

import UIKit


protocol FilterTableFooterViewDelegate {
   func applyButtonDidSelected()
}

class FilterTableFooterView: UIView {

    @IBOutlet weak var btnViewResults: UIButton!

    let buttonCornerRadius:CGFloat = 18.0
  
    var filterTableFooterViewDelegate:FilterTableFooterViewDelegate?
    override func awakeFromNib() {

    }
    

    
    @IBAction func btnViewResultsTapped(_ sender: Any) {
        filterTableFooterViewDelegate?.applyButtonDidSelected()
    }
}
