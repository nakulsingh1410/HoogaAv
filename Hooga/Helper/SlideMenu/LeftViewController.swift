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

enum LeftMenu: String {
    case home = "Home"
    case myEvents = "My Events"
    case myProfile = "My Profile"
    case logout = "Logout"
    
}

class LeftViewController : UIViewController {
    
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
        menus.append(MenuItem(titleString: LeftMenu.home.rawValue, imageIcon: "home"))
        menus.append(MenuItem(titleString: LeftMenu.myEvents.rawValue, imageIcon: "star"))
        menus.append(MenuItem(titleString: LeftMenu.myProfile.rawValue, imageIcon: "profile"))
        menus.append(MenuItem(titleString: LeftMenu.logout.rawValue, imageIcon: "logout"))
        
    }
    
    private  func setUpTableView() {
        tableView.register( UINib(nibName: "DataTableViewCell", bundle: Bundle(for: LeftViewController.self)), forCellReuseIdentifier: "DataTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor.white
    }
    
    func changeViewController(_ menu: MenuItem) {
        if let title = menu.title {
            switch title {
            case LeftMenu.home.rawValue:
                self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
            case LeftMenu.myEvents.rawValue:
                self.slideMenuController()?.changeMainViewController(self.myEventViewController, close: true)
            case LeftMenu.myProfile.rawValue:
                myProfile()
            case LeftMenu.logout.rawValue:
                logoutFromApp()
            default:
                break
            }
        }
       
    }
    private func myProfile(){
        NavigationManager.userRegistration(navigationController: self.navigationController, screenShown: .myProfile)

    }
    private func logoutFromApp()  {
        NavigationManager.logout()
    }
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BaseTableViewCell.height()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menu = menus[indexPath.row]
            self.changeViewController(menu)
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell") as? DataTableViewCell{
            cell.setData(menus[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
}
