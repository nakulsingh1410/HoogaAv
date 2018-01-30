//
//  EventListViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 1/18/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit
import Kingfisher

class EventListViewController: UIViewController,AMMenuDelegate {
    
    @IBOutlet weak var labelFree: UILabel!
    @IBOutlet weak var labelPay: UILabel!
    @IBOutlet weak var buttonFree: UIButton!
    @IBOutlet weak var buttonPay: UIButton!
    @IBOutlet weak var viewEventType: UIView!
    @IBOutlet weak var viewheader: UIView!
    
    @IBOutlet weak var textSearchTag: UITextField!
    @IBOutlet weak var tableViewEventList : UITableView!
    @IBOutlet weak var headerView : CustomNavHeaderView!
    @IBOutlet weak var btnLeftMenu: LeftMenuButton!
    
    var categoryMenu : AMHorizontalMenu?
    
    let request = RequestEvent()
    
    
    var arrCategories    = [CategoryModel]()
    var arrEntryType    = [EntryTypes]()
    var arrTags             = [Tags]()
    var arrEvents          = [Events]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        headerView.viewController = self
        btnLeftMenu.viewController = self
        configTableViewForEventList()
        getCategoryList()
        getEntryTypeList()
        getTagList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // self.setNavigationBarItem()
    }

    func menuSelected(index: IndexPath, data: CategoryModel) {
        
        if data.categoryid != nil {
            request.catId = data.categoryid
            getEventList(catId: request.catId!  , entryType:  request.entryType!, tag:  request.tag!)
        }
    }
    func configTableViewForEventList()  {
        
        tableViewEventList.register(EventCell.nib, forCellReuseIdentifier: EventCell.identifier)
        
        tableViewEventList.separatorStyle = .none
        
        tableViewEventList.rowHeight = 300
        
        tableViewEventList.estimatedRowHeight = UITableViewAutomaticDimension
        tableViewEventList.tableFooterView = UIView()
        tableViewEventList.delegate     = self
        tableViewEventList.dataSource = self
        
    }
    
    //MARK:IBAction methods
    @IBAction func buttonPay_didPressed(_ sender: UIButton) {
        
        buttonPay.backgroundColor = Color.blue
        buttonFree.backgroundColor = Color.lightGray
    
        if arrEntryType.count > 1 {
            let type = arrEntryType[0]
            request.entryType = type.entrytype
            getEventList(catId: request.catId!  , entryType:  request.entryType!, tag:  request.tag!)
            }
        }
    
    
    @IBAction func buttonFree_didPressed(_ sender: UIButton) {
        
        buttonPay.backgroundColor = Color.lightGray
        buttonFree.backgroundColor = Color.blue
        if arrEntryType.count > 1 {
            let type = arrEntryType[1]
            request.entryType = type.entrytype
            getEventList(catId: request.catId!  , entryType:  request.entryType!, tag:  request.tag!)
        }
       
    
    }
    
    
    @IBAction func textChanged_OnEdit(_ sender: UITextField) {
    
    }
    
    func configCategoryMenu(item:[CategoryModel]){
        
        categoryMenu = AMHorizontalMenu(frame:CGRect(x:16,y:5,width:self.view.frame.size.width - 32,height:40) , item:item)
        categoryMenu?.delegate = self
        viewheader.addSubview(categoryMenu!)
    }
}

/*********************************************************************************/
// MARK: TableView Delegate and DataSource
/*********************************************************************************/
extension EventListViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellEvent = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier) as! EventCell
        
        let event = arrEvents[indexPath.row]
        
        cellEvent.labelEventCode.text =  event.eventcode
        cellEvent.labelEventDate.text = event.startdate
        cellEvent.labelEventTime.text = event.starttime
        cellEvent.labelEventTitle.text = event.title
       cellEvent.selectionStyle = .none
        
      
        if let bnanner = event.bannerimage {
            let url = kImgaeView + bnanner
            cellEvent.imageViewEvent.kf.setImage(with: URL(string:url), placeholder: nil, options: nil, progressBlock: nil){ (image, error, cacheType, url) in
                if image == nil {
                    cellEvent.imageViewEvent.kf.setImage(with: placeHolderImageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
            
        }
        
        cellEvent.buttonEventDetail.tag = indexPath.row
        cellEvent.buttonEventDetail.addTarget(self, action:#selector(buttonDetail_Pressed(_:)), for: .touchUpInside)
        
       // cellEvent.viewForShadow.backgroundColor = UIColorFromRGB(rgbValue: 0x209624)
        return cellEvent
    }
 
    @objc func buttonDetail_Pressed(_ button:UIButton)  {
        NavigationManager.eventDetail(navigationController: self.navigationController,evnt:arrEvents[button.tag])
    }
}
//
extension EventListViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
}

/*********************************************************************************/
// MARK: APIs
/*********************************************************************************/
extension EventListViewController {
    
    func getCategoryList()  {
        EventService.getCategories() {[weak self]  (flag, categories) in
            guard let weakSelf = self else {return}
            if let array = categories {
                
                let catAll = CategoryModel()
                catAll.category = "All"
                catAll.categoryid = 0
                weakSelf.arrCategories = array
                weakSelf.arrCategories.insert(catAll, at: 0)
                DispatchQueue.main.async {
                   weakSelf.configCategoryMenu(item:weakSelf.arrCategories)
                }
                if (array.first?.categoryid) != nil{
                    weakSelf.getEventList(catId: 0, entryType: "", tag: "")
                }
            }else{
                //Common.showAlert(message: message)
            }
        }
    }
    func getEntryTypeList()  {
        EventService.getEntryTypes() {[weak self]  (flag, entryTypes) in
            guard let weakSelf = self else {return}
            if let array = entryTypes {
                weakSelf.arrEntryType = array
            }else{
                //Common.showAlert(message: message)
            }
        }
    }
    
    func getTagList()  {
        EventService.getFillTagsList() {[weak self]  (flag, tags) in
            guard let weakSelf = self else {return}
            if let array = tags {
                weakSelf.arrTags = array
            }else{
                //Common.showAlert(message: message)
            }
        }
    }
    
    func getEventList(catId:Int,entryType:String,tag:String)  {
         arrEvents = [Events]()
        tableViewEventList.reloadData()
        EventService.getEventList(categoryid: catId, entrytype: entryType, tag: tag, callback: {[weak self] (flag, events) in
            guard let weakSelf = self else {return}
            if let array = events {
                weakSelf.arrEvents = array
                weakSelf.tableViewEventList.reloadData()
            }else{
                Common.showAlert(message: "No data available")
                
            }
        })
    }
    
    
}
