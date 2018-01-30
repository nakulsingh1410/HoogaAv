//
//  CustomNavHeaderView.swift
//  Hooga
//
//  Created by Nakul Singh on 1/29/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class CustomNavHeaderView: UIView {

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var titleHeader: UILabel!
    
    var nibView:UIView!
    var viewController:UIViewController?
    
    /******************************************************/
    //MARK: Function
    /******************************************************/
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNib()
        self.nibView.frame = self.bounds
        self.addSubview(nibView)
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.nibView.frame = self.bounds
        setLeftMenu()
    }
    
    func loadNib() {
        let bundle = Bundle(for: CustomPickerView.self)
        if let arrNib = bundle.loadNibNamed("CustomNavHeaderView", owner: self, options: nil)?.first as? UIView {
            self.nibView = arrNib
        }
    }
    
    func setLeftMenu() {
         titleHeader.text = ""
         if  let _ = viewController {
            leftButton.setTitle(nil, for: .normal)
            let  image = UIImage(named:"ic_menu_black_24dp")?.withRenderingMode(.alwaysTemplate)
            leftButton.setImage(image, for: .normal)
            leftButton.tintColor = UIColor.white
        }
    }
    
    @IBAction func btnLeftTapped(_ sender: Any) {
        if  let vc = viewController {
            vc.setLeftMenuButtonForCustomeHeader()
        }
    }
    
    
}
