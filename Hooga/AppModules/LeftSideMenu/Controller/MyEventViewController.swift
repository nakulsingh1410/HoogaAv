//
//  MyEventViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 1/29/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class MyEventViewController: UIViewController {

    @IBOutlet weak var navHeaderView: CustomNavHeaderView!
    @IBOutlet weak var tableViewEventList : UITableView!
    
    @IBOutlet weak var btnCompletedEvents: UIButton!
    @IBOutlet weak var btnOnGoingEvents: UIButton!
    
    var arrMyEvent = [MyEventModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        configoreNavigationHeader()
        configTableViewForEventList()
        isOngoingSelected(isOngoing: false)
        getOngoingEvents(isOnGoingEvents: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        navHeaderView.navBarTitle = "MY EVENTS"
        navHeaderView.backButtonType = .LeftMenu
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
    
    func isOngoingSelected(isOngoing:Bool)  {
        if isOngoing {
            btnOnGoingEvents.backgroundColor = UIColor.colorWithHexString(hex: "0080FF")
            btnOnGoingEvents.setTitleColor(UIColor.white, for: .normal)
            
            btnCompletedEvents.backgroundColor = UIColor.white
            btnCompletedEvents.setTitleColor(UIColor.colorWithHexString(hex: "0080FF"), for: .normal)
        }else{
            btnCompletedEvents.backgroundColor = UIColor.colorWithHexString(hex: "0080FF")
            btnCompletedEvents.setTitleColor(UIColor.white, for: .normal)
            
            btnOnGoingEvents.backgroundColor = UIColor.white
            btnOnGoingEvents.setTitleColor(UIColor.colorWithHexString(hex: "0080FF"), for: .normal)
        }
    }
    
    @IBAction func btnCompletedEventsTapped(_ sender: UIButton) {
          isOngoingSelected(isOngoing: false)
        getOngoingEvents(isOnGoingEvents: false)
      
    }
    @IBAction func btnOnGoingEventsTapped(_ sender: UIButton) {
        isOngoingSelected(isOngoing: true)
        getOngoingEvents(isOnGoingEvents: true)

    }
}
/*********************************************************************************/
// MARK: TableView Delegate and DataSource
/*********************************************************************************/
extension MyEventViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrMyEvent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellEvent = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier) as! EventCell
        
        let event = arrMyEvent[indexPath.row]
        
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
        NavigationManager.eventDetail(navigationController: self.navigationController,evntId:arrMyEvent[button.tag].eventid!, comingFrom: ComingFromScreen.myEvent)
    }
    
}
//
extension MyEventViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
}


/*********************************************************************************/
// MARK: APIs
/*********************************************************************************/
extension MyEventViewController {
    
    func getOngoingEvents(isOnGoingEvents:Bool)  {
        arrMyEvent.removeAll()
        tableViewEventList.reloadData()
        tableViewEventList.backgroundView = nil
        EventService.getMyEvents(isOnGoingEvents: isOnGoingEvents) { [weak self]  (flag, arrData) in
            guard let weakSelf = self else {return}
            if let array = arrData {
                weakSelf.arrMyEvent = array
            }else{
                Common.EmptyMessage(message: "No Data Available", viewController: weakSelf, tableView: weakSelf.tableViewEventList)
            }
            weakSelf.tableViewEventList.reloadData()
        }
    }
}
