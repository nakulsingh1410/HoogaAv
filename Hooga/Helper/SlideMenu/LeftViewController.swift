//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

class MenuItem:NSObject {
    var title :String?
    var icon :String?
    
    init(titleString:String,imageIcon:String?) {
        title = titleString
        icon = imageIcon
    }
}

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
    var menus = [MenuItem]()
    var mainViewController: UIViewController!

    var contactUsViewController: UIViewController!
    var myEventViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let storyboard = UIStoryboard(name: "LeftSideMenu", bundle: nil)
//        let contactUsController = storyboard.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
//        self.contactUsViewController = UINavigationController(rootViewController: contactUsController)

        let myEventVc = storyboard.instantiateViewController(withIdentifier: "MyEventViewController") as! MyEventViewController
        self.myEventViewController = getNavigationController(viewController: myEventVc)
//
//        let goViewController = storyboard.instantiateViewController(withIdentifier: "GoViewController") as! GoViewController
//        self.goViewController = UINavigationController(rootViewController: contactUsController)
//
//        let nonMenuController = storyboard.instantiateViewController(withIdentifier: "NonMenuController") as! NonMenuController
//        nonMenuController.delegate = self
//        self.nonMenuViewController = UINavigationController(rootViewController: contactUsController)
        setUpMenu()
        setUpTableView()
       
        imgViewUser.layer.cornerRadius = imgViewUser.frame.height/2
        imgViewUser.layer.masksToBounds = true
    }
    
    private func getNavigationController(viewController:UIViewController) -> UINavigationController {
        let nvc: UINavigationController = UINavigationController(rootViewController: viewController)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        UINavigationBar.appearance().barTintColor = kBlueColor
        nvc.navigationBar.isHidden = true
        return nvc
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
    }
    
    private func setUpMenu(){
        menus.append(MenuItem(titleString: "Home", imageIcon: "home"))
        menus.append(MenuItem(titleString: "My Profile", imageIcon: "profile"))
        menus.append(MenuItem(titleString: "My Event", imageIcon: "star"))
    }
    
   private  func setUpTableView() {
    tableView.register( UINib(nibName: "DataTableViewCell", bundle: Bundle(for: LeftViewController.self)), forCellReuseIdentifier: "DataTableViewCell")
    tableView.tableFooterView = UIView()
    tableView.separatorColor = UIColor.white
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
//             self.slideMenuController()?.changeMainViewController(self.myEventViewController, close: true)
        case .contactUs:
            //self.slideMenuController()?.changeMainViewController(self.contactUsViewController, close: true)
             self.slideMenuController()?.changeMainViewController(self.myEventViewController, close: true)
        case .login:
            self.slideMenuController()?.changeMainViewController(self.myEventViewController, close: true)
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
                if let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell") as? DataTableViewCell{
                    cell.setData(menus[indexPath.row])
                    return cell
                }
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    
}
