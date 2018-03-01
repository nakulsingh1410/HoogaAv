//
//  ParticipantResultViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 2/7/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class ParticipantResultViewController: UIViewController {
    @IBOutlet weak var navHeaderView : CustomNavHeaderView!
    @IBOutlet weak var eventTicketInfoView: EventInfoTickerView!

    @IBOutlet weak var tableView: UITableView!
    var arrMyEventluckyDrawResult = [ShowMyEventLuckyDrawResult]()
    var eventDetail :EventDetail?

    var heldon:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        configoreNavigationHeader()
       configTableView()
        initializeCalls()
      
    }
    func initializeCalls()  {
        guard let evntdetail = eventDetail else{return}
        eventTicketInfoView.loadTicketInfo(eventDetail: evntdetail, textColor: UIColor.black, backGroundColor: .white)
        showMyEventLuckyDrawAPI(eventId: evntdetail.eventid!)


        if let entrytype = evntdetail.entrytype?.trim() ,entrytype == EventType.paid.rawValue{
            if let eventId =  eventDetail?.eventid,let regid =  eventDetail?.regid{
                showMyEventLuckyDrawResultAPI(eventId: eventId, regId: regid)
            }
        }else{
            // need to do for free event type
            if let eventId =  eventDetail?.eventid,let regid =  eventDetail?.regid{
                showMyFreeEventLuckyDrawResultAPI(eventId: eventId, regId: regid)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        navHeaderView.navBarTitle = "Lucky Draw Results"
        navHeaderView.backButtonType = .Back
    }
    func configTableView()  {
        let nib =  UINib(nibName: "ParticipationTableViewCell", bundle: Bundle(for: ParticipationTableViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: "ParticipationTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.tableFooterView = UIView()
        
    }
}

/*********************************************************************************/
// MARK: UITableViewDataSource
/*********************************************************************************/

extension ParticipantResultViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMyEventluckyDrawResult.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipationTableViewCell") as? ParticipationTableViewCell{
            cell.loadParticipateResultCellData(result: arrMyEventluckyDrawResult[indexPath.row], heldOn: heldon, eventDetail: eventDetail)
            cell.participationCellDelegate = self
            return cell
        }
        return UITableViewCell()
    }
    
}


extension ParticipantResultViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


/*********************************************************************************/
// MARK: APIs
/*********************************************************************************/

extension ParticipantResultViewController {
    func showMyEventLuckyDrawResultAPI(eventId:Int,regId:Int)  {
        tableView.backgroundView = nil

        TicketBookingService.showMyEventLuckyDrawResult(eventid: eventId,registrationid:regId) {[weak self] (flag, array) in
            guard let weakSelf = self else{return}
            
            if let data = array{
                weakSelf.arrMyEventluckyDrawResult = data
                weakSelf.tableView.reloadData()
            }else{
                Common.EmptyMessage(message: "No data available", viewController: weakSelf, tableView: weakSelf.tableView)
            }
        }
    }
    
    func showMyFreeEventLuckyDrawResultAPI(eventId:Int,regId:Int)  {
        TicketBookingService.showMyFreeEventLuckyDrawResult(eventid: eventId,registrationid:regId) {[weak self] (flag, array) in
            guard let weakSelf = self else{return}
            
            if let data = array{
                weakSelf.arrMyEventluckyDrawResult = data
                weakSelf.tableView.reloadData()
            }else{
                Common.EmptyMessage(message: "No data available", viewController: weakSelf, tableView: weakSelf.tableView)
            }
        }
    }
    
    
    func showMyEventLuckyDrawAPI(eventId:Int)  {
        TicketBookingService.showMyEventLuckyDraw(eventid: eventId) {[weak self] (flag, showMyEventLuckyDraw) in
            guard let weakSelf = self else{return}
            if let obj = showMyEventLuckyDraw {
                weakSelf.heldon = obj.heldon
//                weakSelf.showMyEventLuckyDraw = obj
                //weakSelf.showLuckyDrawData()
            }
        }
    }

    
}

/*********************************************************************************/
// MARK: ParticipateTableViewCellDelegate
/*********************************************************************************/

extension ParticipantResultViewController:ParticipationTableViewCellDelegate {
    func refershResultlButtonTapped(cell: ParticipationTableViewCell) {
        initializeCalls()
    }
    
    func participateDetailButtonTapped(cell: ParticipationTableViewCell) {
        //
        if let result = cell.showMyEventLuckyDrawResult {
            NavigationManager.participateDetail(navigationController: navigationController, participateDetail: result,eventDetail:eventDetail!)
        }
    }
    func participateButtonTapped(cell:ParticipationTableViewCell){
        //
    }
    
    
    
    
}
