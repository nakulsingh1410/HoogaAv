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
    
    @IBOutlet weak var tableView: UITableView!
    var arrMyEventluckyDrawResult = [ShowMyEventLuckyDrawResult]()
    var eventDetail :EventDetail?

    override func viewDidLoad() {
        super.viewDidLoad()
        configoreNavigationHeader()
       configTableView()

        if let eventId =  eventDetail?.eventid,let regid =  eventDetail?.regid{
            showMyEventLuckyDrawResultAPI(eventId: eventId, regId: regid)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        navHeaderView.navBarTitle = "Participates Results"
        navHeaderView.backButtonType = .Back
    }
    func configTableView()  {
        let nib =  UINib(nibName: "ParticipateTableViewCell", bundle: Bundle(for: ParticipateTableViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: "ParticipateTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.tableFooterView = UIView()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

/*********************************************************************************/
// MARK: UITableViewDataSource
/*********************************************************************************/

extension ParticipantResultViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMyEventluckyDrawResult.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipateTableViewCell") as? ParticipateTableViewCell{
            cell.loadParticipateResultCellData(result: arrMyEventluckyDrawResult[indexPath.row])
            cell.participateTableViewCellDelegate = self
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
}

/*********************************************************************************/
// MARK: ParticipateTableViewCellDelegate
/*********************************************************************************/

extension ParticipantResultViewController:ParticipateTableViewCellDelegate {
    func participateDetailButtonTapped(cell: ParticipateTableViewCell) {
        //
        if let result = cell.showMyEventLuckyDrawResult {
             NavigationManager.participateDetail(navigationController: navigationController, participateDetail: result)
        }
        
       
    }
    
    
    func participateButtonTapped(cell:ParticipateTableViewCell){
        
        //
    }
    
}
