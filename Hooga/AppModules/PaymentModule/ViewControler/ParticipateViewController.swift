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
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrTicketDetails =  [ShowMyTicketDetails]()
    var arrMyEventluckyDrawResult = [ShowMyEventLuckyDrawResult]()
    var generatedLuckyDrawNumber:GenerateLuckyDrawNumber?
    
    var eventDetail :EventDetail?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configoreNavigationHeader()
        configTableView()
        
        if let eventId =  eventDetail?.eventid,let regid =  eventDetail?.regid{
            showMyTicketDetailsAPI(eventId: eventId, regId: regid)
        }
        
    }
    func configTableView()  {
        
        
        let nib =  UINib(nibName: "ParticipateTableViewCell", bundle: Bundle(for: ParticipateTableViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: "ParticipateTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.tableFooterView = UIView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        navHeaderView.navBarTitle = "Lucky Draw Participates"
        navHeaderView.backButtonType = .Back
    }
}


extension ParticipateViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTicketDetails.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipateTableViewCell") as? ParticipateTableViewCell{
            cell.loadcellData(ticketDetails: arrTicketDetails[indexPath.row])
            cell.participateTableViewCellDelegate = self
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
        TicketBookingService.showMyTicketDetails(eventid: eventId,registrationid:regId) {[weak self] (flag, array) in
            guard let weakSelf = self else{return}
            
            if let data = array{
                weakSelf.arrTicketDetails = data
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
                weakSelf.tableView.reloadData()
            }
        }
    }
    
    
    
    
    func showMyEventLuckyDrawResultAPI(eventId:Int,regId:Int)  {
        TicketBookingService.showMyEventLuckyDrawResult(eventid: eventId,registrationid:regId) {[weak self] (flag, array) in
            guard let weakSelf = self else{return}
            
            if let data = array{
                weakSelf.arrMyEventluckyDrawResult = data
            }
        }
    }
}



/*********************************************************************************/
// MARK: ParticipateTableViewCellDelegate
/*********************************************************************************/

extension ParticipateViewController:ParticipateTableViewCellDelegate {
    
    func participateButtonTapped(cell:ParticipateTableViewCell){
        if let eventId =  cell.ticketDetail?.eventid,let ticketId = cell.ticketDetail?.ticketid,let regid =  eventDetail?.regid{
            generateLuckyDrawNumberAPI(eventId: eventId, regId: regid, ticketId: ticketId)
        }
    }
    
}

