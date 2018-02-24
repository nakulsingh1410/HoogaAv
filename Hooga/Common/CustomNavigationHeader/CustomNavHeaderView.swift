//
//  CustomNavHeaderView.swift
//  Hooga
//
//  Created by Nakul Singh on 1/29/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit
enum BackButtonType:String{
    case Back = "back";
    case LeftMenu = "leftMenu"
}
@objc protocol CustomNavHeaderViewDelegate {
    @objc optional func backButtonPressed()
}
class CustomNavHeaderView: UIView {
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var titleHeader: UILabel!
    @IBOutlet weak var lblSeperatorLine: UILabel!
//    @IBOutlet weak var imgViewNavBar: UIImageView!
    
    private var nibView:UIView!
    var viewController:UIViewController?
    var navBarTitle:String?
    var isBackHandledInController = false
    var backButtonType : BackButtonType?
    var customNavHeaderViewDelegate:CustomNavHeaderViewDelegate?
    var titleColor =  UIColor.white
    var isNavBarTransparent = true
    var isBottonLineHidden = true {
        didSet{
            lblSeperatorLine.isHidden = isBottonLineHidden
        }
    }
    var isBackButtonHidden = false {
        didSet{
            leftButton.isHidden = isBackButtonHidden
        }
    }
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
    
    private func loadNib() {
        let bundle = Bundle(for: CustomPickerView.self)
        if let arrNib = bundle.loadNibNamed("CustomNavHeaderView", owner: self, options: nil)?.first as? UIView {
            self.nibView = arrNib
        }
    }
    
     func setLeftMenu() {
        if let title = navBarTitle{
            titleHeader.text = title
        }else{
            titleHeader.text = ""
        }
        titleHeader.font = Font.gillSansSemiBold(size: 19)
        
        titleHeader.textColor = titleColor
        lblSeperatorLine.isHidden = isBottonLineHidden
        if isNavBarTransparent{
            self.backgroundColor = UIColor.clear
//            imgViewNavBar.isHidden = true
        }else{
//            self.backgroundColor = UIColor.white
//            imgViewNavBar.isHidden = false
        }
        self.backgroundColor = UIColor.clear

        if let backType = backButtonType, backType == BackButtonType.LeftMenu ,let _ = viewController {
            leftButton.setTitle(nil, for: .normal)
            let  image = UIImage(named:"ic_menu_black_24dp")?.withRenderingMode(.alwaysTemplate)
            leftButton.setImage(image, for: .normal)
            leftButton.tintColor = UIColor.white
        }else  if let backType = backButtonType, backType == BackButtonType.Back {
            leftButton.setTitle(nil, for: .normal)
            let  image = UIImage(named:"back")?.withRenderingMode(.alwaysTemplate)
            leftButton.setImage(image, for: .normal)
            leftButton.tintColor = UIColor.white
            leftButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)

        }
    }
    
    @IBAction func btnLeftTapped(_ sender: Any) {
        guard let vcObj = viewController  else {return}
        if let backType = backButtonType, backType == BackButtonType.LeftMenu {
            vcObj.setLeftMenuButtonForCustomeHeader()
        }else  if let backType = backButtonType, backType == BackButtonType.Back {
            if isBackHandledInController{
                customNavHeaderViewDelegate?.backButtonPressed?()
            }else{
                vcObj.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
}
