//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        self.addRightBarButtonWithImage(UIImage(named: "ic_notifications_black_24dp")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
    
    
    func loadNib<T: UIViewController>(_ type : T.Type) -> T {
        return T(nibName: T.description().className, bundle: nil)
    }
    
    func backController(sender : AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    func transparentNavBar(_ color: UIColor = kBlueColor){
        if let nav = self.navigationController {
            nav.navigationBar.setBackgroundImage(UIImage.imageFrom(color: color), for: .default)
            nav.navigationBar.shadowImage = UIImage()
            nav.navigationBar.isTranslucent = false
            nav.view.backgroundColor = .clear
        }
    }
    
    //    func setBackButton(_ tintColor: UIColor = .white){
    //        if let nav = self.navigationController {
    //            nav.navigationBar.tintColor = tintColor
    //            let back = #imageLiteral(resourceName: "back")
    //            nav.navigationBar.backIndicatorImage = back
    //            nav.navigationBar.backIndicatorTransitionMaskImage = back
    //            nav.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: nav.navigationBar.tintColor,NSAttributedStringKey.font: UIFont(name: kFontRegular, size: 18)!]
    //            let backButton = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    //            self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    //            self.navigationItem.backBarButtonItem = backButton
    //            if let parent = self.parent{
    //                parent.navigationController?.navigationBar.tintColor = tintColor
    //                parent.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    //                parent.navigationItem.backBarButtonItem = backButton
    //            }
    //        }
    //    }
    
    
}
