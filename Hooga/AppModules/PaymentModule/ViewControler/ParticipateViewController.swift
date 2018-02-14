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
        tableView.dataSource = self
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



/*********************************************************************************/
// MARK: ParticipateTableViewCellDelegate
/*********************************************************************************/

extension ParticipateViewController:ParticipateTableViewCellDelegate {
    func participateDetailButtonTapped(cell: ParticipateTableViewCell) {
        //
    }
    
    
    func participateButtonTapped(cell:ParticipateTableViewCell){
        if let eventId =  cell.ticketDetail?.eventid,let ticketId = cell.ticketDetail?.ticketid,let regid =  eventDetail?.regid{
            generateLuckyDrawNumberAPI(eventId: eventId, regId: regid, ticketId: ticketId)
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


