//
//  EventListViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 1/18/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit
import Kingfisher

class EventListViewController: UIViewController,AMMenuDelegate,TagSearchDelegate ,UITextFieldDelegate{
   

    @IBOutlet weak var labelFree: UILabel!
    @IBOutlet weak var labelPay: UILabel!
    @IBOutlet weak var buttonFree: UIButton!
    @IBOutlet weak var buttonPay: UIButton!
    @IBOutlet weak var viewEventType: UIView!
    @IBOutlet weak var viewheader: UIView!
    
    @IBOutlet weak var textSearchTag: UITextField!
    @IBOutlet weak var tableViewEventList : UITableView!
    @IBOutlet weak var navHeaderView : CustomNavHeaderView!
    
    var categoryMenu : AMHorizontalMenu?
    
    var request = RequestEvent()
    
    
    var arrCategories    = [CategoryModel]()
    var arrEntryType    = [EntryTypes]()
    var arrTags             = [Tags]()
    var arrEvents          = [Events]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        textSearchTag.delegate = self
        configoreNavigationHeader()
        configTableViewForEventList()
        getCategoryList()
        getEntryTypeList()
        getTagList()
        
        buttonPay.backgroundColor = Color.lightGray
        buttonFree.backgroundColor = Color.lightGray
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

    func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        navHeaderView.navBarTitle = "Events"
        navHeaderView.backButtonType = .LeftMenu
        navHeaderView.isNavBarTransparent = true
    }

    func menuSelected(index: IndexPath, data: CategoryModel) {
        
        if data.categoryid != nil {
            request = RequestEvent()
            textSearchTag.text = ""
            buttonPay.backgroundColor  = Color.lightGray
            buttonFree.backgroundColor = Color.lightGray
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
        
        categoryMenu = AMHorizontalMenu(frame:CGRect(x:16,y:0,width:self.view.frame.size.width - 32,height:40) , item:item)
        categoryMenu?.delegate = self
        viewheader.addSubview(categoryMenu!)
    }
    
    //MARK: search delegate methods
    func selectedTag(tag: Tags) {
    
            request.tag = tag.tag?.lowercased()
            textSearchTag.text = tag.tag
            getEventList(catId: request.catId!  , entryType:  request.entryType!, tag:  request.tag!)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        textField.resignFirstResponder()
        if arrTags.count > 0 {
             let search = self.storyboard?.instantiateViewController(withIdentifier: "TagSearchVC") as! TagSearchVC
            search.arrTags  = arrTags
            search.delegate = self
            self.present(search, animated: true, completion: nil)
        }
       
        
        
        
        
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
        
//        cellEvent.labelEventCode.text =  event.eventcode
//        cellEvent.labelEventDate.text = event.startdate
        var dateStirng = ""
        if let startDate = event.startdate{
            dateStirng = startDate
        }
        if let starttime = event.starttime{
            dateStirng = dateStirng + " | " + starttime
        }
        cellEvent.labelEventDate.text = dateStirng
//        cellEvent.labelEventTime.text = event.starttime
        cellEvent.labelEventTitle.text = event.title
        cellEvent.selectionStyle = .none
        
        
        if let bnanner = event.bannerimage {
            let url = kAssets + bnanner
            cellEvent.imageViewEvent.kf.setImage(with: URL(string:url), placeholder: nil, options: nil, progressBlock: nil){ (image, error, cacheType, url) in
                if image == nil {
                    cellEvent.imageViewEvent.kf.setImage(with: placeHolderImageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
            
        }
        
//        cellEvent.buttonEventDetail.tag = indexPath.row
//        cellEvent.buttonEventDetail.addTarget(self, action:#selector(buttonDetail_Pressed(_:)), for: .touchUpInside)
//
        // cellEvent.viewForShadow.backgroundColor = UIColorFromRGB(rgbValue: 0x209624)
        return cellEvent
    }
    
     func buttonDetail_Pressed(index:Int)  {
        NavigationManager.eventDetail(navigationController: self.navigationController,evntId:arrEvents[index].eventid!, comingFrom: ComingFromScreen.eventListing)
    }
    
    
}
//
extension EventListViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        buttonDetail_Pressed(index: indexPath.row)
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
        tableViewEventList.backgroundView = nil
        EventService.getEventList(categoryid: catId, entrytype: entryType, tag: tag, callback: {[weak self] (flag, events) in
            guard let weakSelf = self else {return}
            if let array = events {
                weakSelf.arrEvents = array
                weakSelf.tableViewEventList.reloadData()
            }else{
//                Common.showAlert(message: "No data available")
                Common.EmptyMessage(message: "No data available", viewController: weakSelf, tableView: weakSelf.tableViewEventList)
            }
        })
    }
    
    
}

