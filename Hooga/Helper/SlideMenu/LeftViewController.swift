//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

enum LeftMenu: Int {
    case main = 0
    case login
    case contactUs

}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController : UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var imgViewUser: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var menus = ["Home", "Login","Contact Us"]
    var mainViewController: UIViewController!

    var contactUsViewController: UIViewController!
    var loginViewController: UIViewController!

//    var imageHeaderView: ImageHeaderView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "LeftSideMenu", bundle: nil)
//        let contactUsController = storyboard.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
//        self.contactUsViewController = UINavigationController(rootViewController: contactUsController)

        let loginVc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.loginViewController = UINavigationController(rootViewController: loginVc)
//
//        let goViewController = storyboard.instantiateViewController(withIdentifier: "GoViewController") as! GoViewController
//        self.goViewController = UINavigationController(rootViewController: contactUsController)
//
//        let nonMenuController = storyboard.instantiateViewController(withIdentifier: "NonMenuController") as! NonMenuController
//        nonMenuController.delegate = self
//        self.nonMenuViewController = UINavigationController(rootViewController: contactUsController)
        
        
        self.tableView.registerCellClass(BaseTableViewCell.self)
        
        imgViewUser.layer.cornerRadius = imgViewUser.frame.height/2
        imgViewUser.layer.masksToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .contactUs:
            self.slideMenuController()?.changeMainViewController(self.contactUsViewController, close: true)
        case .login:
            self.slideMenuController()?.changeMainViewController(self.loginViewController, close: true)
        }
    }
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .main, .contactUs, .login:
                return BaseTableViewCell.height()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .main, .contactUs, .login:
                let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
                cell.setData(menus[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
