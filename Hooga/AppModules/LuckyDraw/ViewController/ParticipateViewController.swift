//
//  ParticipateViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 2/6/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class ParticipateViewController: UIViewController {
    @IBOutlet weak var navHeaderView : CustomNavHeaderView!
    
    @IBOutlet weak var eventTicketInfoView: EventInfoTickerView!
    @IBOutlet weak var tableView: UITableView!
    
    var arrTicketDetails =  [ShowMyTicketDetails]()
    var generatedLuckyDrawNumber:GenerateLuckyDrawNumber?
    
    var eventDetail :EventDetail?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configoreNavigationHeader()
        configTableView()
        initializeCalls()
        
        
    }
    
    func initializeCalls()  {
        guard let evntdetail = eventDetail else{return}
        eventTicketInfoView.loadTicketInfo(eventDetail: evntdetail, textColor: UIColor.white, backGroundColor: .clear)
        if let entrytype = evntdetail.entrytype?.trim() ,entrytype == EventType.paid.rawValue{
            if let eventId =  eventDetail?.eventid,let regid =  eventDetail?.regid{
                showMyTicketDetailsAPI(eventId: eventId, regId: regid)
            }
        }else{
            // need to do for free event type
            showRegistrationDetailsAPI(eventId:evntdetail.eventid!,registrationId:evntdetail.regid!)
        }


    }
    
    func configTableView()  {
        
//        let nib =  UINib(nibName: "ParticipateTableViewCell", bundle: Bundle(for: ParticipateTableViewCell.self))
//        tableView.register(nib, forCellReuseIdentifier: "ParticipateTableViewCell")
        
        let nib =  UINib(nibName: "ParticipationTableViewCell", bundle: Bundle(for: ParticipationTableViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: "ParticipationTableViewCell")
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        navHeaderView.navBarTitle = "Participation"
        navHeaderView.backButtonType = .Back
    }
    
    func addFooter()  {
        let arrAllLuckyDraw =  arrTicketDetails.filter { (ticket) -> Bool in
            return ticket.luckydrawsequence != nil
        }
        if arrAllLuckyDraw.count > 0, arrAllLuckyDraw.count == arrTicketDetails.count {
            let bundle = Bundle(for: FilterTableFooterView.self)
            let arrNib =  bundle.loadNibNamed("FilterTableFooterView", owner: self, options: nil)
            if let filterView = arrNib?.first as? FilterTableFooterView {
                filterView.filterTableFooterViewDelegate = self
                tableView.tableFooterView = filterView
                
            }
        }
    }
}


extension ParticipateViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTicketDetails.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipationTableViewCell") as? ParticipationTableViewCell{
            cell.loadcellData(ticketDetails: arrTicketDetails[indexPath.row])
            cell.participationCellDelegate = self
            return cell
        }
        return UITableViewCell()
    }
    
}

/*********************************************************************************/
// MARK: APIs
/*********************************************************************************/

extension ParticipateViewController {
    
    func showMyTicketDetailsAPI(eventId:Int,regId:Int)  {
        tableView.backgroundView = nil

        TicketBookingService.showMyTicketDetails(eventid: eventId,registrationid:regId) {[weak self] (flag, array) in
            guard let weakSelf = self else{return}
            
            if let data = array{
                weakSelf.arrTicketDetails = data
                weakSelf.addFooter()
            }else{
                Common.EmptyMessage(message: "No data available", viewController: weakSelf, tableView: weakSelf.tableView)
            }
       
            weakSelf.tableView.reloadData()
        }
    }
    
    func generateLuckyDrawNumberAPI(eventId:Int,regId:Int,ticketId:Int)  {
        TicketBookingService.generateLuckyDrawNumber(eventid: eventId,registrationid:regId,ticketid:ticketId) {[weak self] (flag, luckyDrawNo) in
            guard let weakSelf = self else{return}
            
            if let obj = luckyDrawNo{
                weakSelf.generatedLuckyDrawNumber = obj
                let array = weakSelf.arrTicketDetails.map({ (ticket) -> ShowMyTicketDetails in
                    if let tI = ticket.ticketid ,tI == ticketId {
                        ticket.luckydrawsequence = obj.luckydrawsequence
                    }
                    return ticket
                })
                weakSelf.arrTicketDetails = array
                weakSelf.addFooter()
                weakSelf.tableView.reloadData()
            }
        }
    }
    
}

/////////////////FREE Entry////////////////

extension ParticipateViewController{
    
    func showRegistrationDetailsAPI(eventId:Int,registrationId:Int)  {
        TicketBookingService.showRegistrationDetails(eventid: eventId,registrationid:registrationId) {[weak self] (flag, array) in
            guard let weakSelf = self else{return}
            
            if let data = array{
                weakSelf.arrTicketDetails = data
                weakSelf.addFooter()
            }else{
                Common.EmptyMessage(message: "No data available", viewController: weakSelf, tableView: weakSelf.tableView)
            }
            
            weakSelf.tableView.reloadData()
            
        }
    }
    
    func generateFreeLuckyDrawNumberAPI(eventId:Int,regId:Int)    {
        TicketBookingService.generateFreeLuckyDrawNumber(eventid: eventId,registrationid:regId) {[weak self] (flag, luckyDrawNo) in
            guard let weakSelf = self else{return}
            
            
            if let obj = luckyDrawNo{
                weakSelf.generatedLuckyDrawNumber = obj
                let array = weakSelf.arrTicketDetails.map({ (ticket) -> ShowMyTicketDetails in
                    if let registrationid = ticket.registrationid ,registrationid == regId {
                        ticket.luckydrawsequence = obj.luckydrawsequence
                    }
                    return ticket
                })
                weakSelf.arrTicketDetails = array
                weakSelf.addFooter()
                weakSelf.tableView.reloadData()
            }
        }
    }
    

}
///////////////// xxxxx ////////////////



/*********************************************************************************/
// MARK: ParticipateTableViewCellDelegate
/*********************************************************************************/

extension ParticipateViewController:ParticipationTableViewCellDelegate {
    func participateDetailButtonTapped(cell: ParticipationTableViewCell) {
        //
    }
    
    
    func participateButtonTapped(cell:ParticipationTableViewCell){
       
        guard let evntdetail = eventDetail else{return}
        if let entrytype = evntdetail.entrytype?.trim() ,entrytype == EventType.paid.rawValue{
            if let eventId =  cell.ticketDetail?.eventid,let ticketId = cell.ticketDetail?.ticketid,let regid =  eventDetail?.regid{
                generateLuckyDrawNumberAPI(eventId: eventId, regId: regid, ticketId: ticketId)
            }
        }else{
            // need to do for free event type
            if let eventId =  cell.ticketDetail?.eventid,let regid = cell.ticketDetail?.registrationid{
                generateFreeLuckyDrawNumberAPI(eventId: eventId, regId: regid)
            }
        }
        
    }
    
}
/********************************************************************/
//MARK: UITableViewDelegate
/********************************************************************/
extension ParticipateViewController:FilterTableFooterViewDelegate{
    
    func applyButtonDidSelected(){
        if let eventDetailObj = eventDetail{
              NavigationManager.openResultParticipate(navigationController: navigationController, evntDetail: eventDetailObj)
        }
      
    }
    
}


