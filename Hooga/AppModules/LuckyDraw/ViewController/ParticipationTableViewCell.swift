//
//  ParticipationTableViewCell.swift
//  Hooga
//
//  Created by Nakul Singh on 2/25/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit
protocol ParticipationTableViewCellDelegate {
    func participateButtonTapped(cell:ParticipationTableViewCell)
    func participateDetailButtonTapped(cell:ParticipationTableViewCell)
    func refershResultlButtonTapped(cell:ParticipationTableViewCell)

}

enum ParticipationButtonTitle:String{
    
    case ViewPrizeDetails = "View Prize Details"
    case Participate = "Participate"
}
class ParticipationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: HoogaLabel!
    @IBOutlet weak var lblLuckyDrawNo: UILabel!
    @IBOutlet weak var btnParticipate: HoogaButton!
    @IBOutlet weak var btnRefresh: HoogaButton!
    
    @IBOutlet weak var lblHeldOnLabel: HoogaLabel!
    @IBOutlet weak var lblHeldOn: HoogaLabel! // for particiapte result
    
    @IBOutlet weak var btnParticipateHeighConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewLuckyDraeNoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnRefreshHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnParticipateTopConstraint: NSLayoutConstraint!
    
    
    var ticketDetail:ShowMyTicketDetails?
    var  showMyEventLuckyDrawResult:ShowMyEventLuckyDrawResult?

    var participationCellDelegate:ParticipationTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        lblHeldOnLabel.text = ""
        lblHeldOn.text = ""
        btnRefreshHeightConstraint.constant = 0.0
        btnParticipateTopConstraint.constant = 0.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadcellData(ticketDetails:ShowMyTicketDetails)  {
        ticketDetail = ticketDetails
        lblName.text = ""
        if let string = ticketDetails.firstName{
            lblName.text = string
        }
        if let string = ticketDetails.lastName{
            lblName.text =  lblName.text! + " " + string
        }
        
        if let string = ticketDetails.luckydrawsequence, string.length > 0 {
            
            lblLuckyDrawNo.text = string
            lblLuckyDrawNo.backgroundColor = UIColor.gray
            lblLuckyDrawNo.textColor = UIColor.white
            //            btnParticipateHeighConstraint.isHidden = true
            lblLuckyDrawNo.font = Font.gillSansSemiBold(size: 40)
            lblLuckyDrawNo.layer.cornerRadius = 5.0
            lblLuckyDrawNo.clipsToBounds = true
            btnParticipateHeighConstraint.constant = 0
            viewLuckyDraeNoHeightConstraint.constant = 75
            
        }else{
            btnParticipate.setTitle(ParticipationButtonTitle.Participate.rawValue, for: .normal)

//            lblLuckyDrawNo.text = " Participate "
//            lblLuckyDrawNo.backgroundColor = UIColor(hex: "3F81FF")
//            lblLuckyDrawNo.textColor = UIColor.white
//            lblLuckyDrawNo.isHidden = false
            btnParticipateHeighConstraint.constant = 35
            viewLuckyDraeNoHeightConstraint.constant = 0
        }
        lblLuckyDrawNo.textAlignment = .center
    }
    
    func loadParticipateResultCellData(result:ShowMyEventLuckyDrawResult,heldOn:String?)  {
        showMyEventLuckyDrawResult = result
        lblName.text = ""
        if let string = result.firstName{
            lblName.text = string
        }
        if let string = result.lastName{
            lblName.text =  lblName.text! + " " + string
        }
        if let string = heldOn{
            lblHeldOnLabel.text = "Draw Held On"
            lblHeldOn.text = string
        }
        
        
        
        var isParticipate = false
        if let string = result.luckydrawsequence, string.length > 0 {
            lblLuckyDrawNo.text = string
            lblLuckyDrawNo.backgroundColor = UIColor.gray
            lblLuckyDrawNo.textColor = UIColor.white
            lblLuckyDrawNo.font = Font.gillSansSemiBold(size: 40)
            lblLuckyDrawNo.layer.cornerRadius = 5.0
            lblLuckyDrawNo.clipsToBounds = true
//            btnParticipateHeighConstraint.isHidden = true
            btnParticipateHeighConstraint.constant = 0
            viewLuckyDraeNoHeightConstraint.constant = 75
        }else{
            isParticipate = true
            btnParticipateHeighConstraint.constant = 35
            viewLuckyDraeNoHeightConstraint.constant = 0
        }
        
        if isParticipate == false {
            if let string = result.isprizewon, string == "True" {
                btnParticipateHeighConstraint.constant = 35
                viewLuckyDraeNoHeightConstraint.constant = 75
                btnRefreshHeightConstraint.constant = 40.0
                btnParticipateTopConstraint.constant = 15.0
                btnParticipate.setTitle(ParticipationButtonTitle.ViewPrizeDetails.rawValue, for: .normal)
                lblLuckyDrawNo.backgroundColor = UIColor(hex: "5CA430")

            }else{
                btnParticipateHeighConstraint.constant = 0
                viewLuckyDraeNoHeightConstraint.constant = 75

                lblLuckyDrawNo.backgroundColor = UIColor(hex: "F00000")
            }
        }
        lblLuckyDrawNo.textAlignment = .center
        layoutIfNeeded()
        
        
    }
    @IBAction func btnParticipateTapped(_ sender: Any) {
        if let title = btnParticipate.titleLabel?.text,title == ParticipationButtonTitle.ViewPrizeDetails.rawValue{
            participationCellDelegate?.participateDetailButtonTapped(cell: self)

        }else{
            participationCellDelegate?.participateButtonTapped(cell: self)

        }
    }
    @IBAction func btnRefreshTapped(_ sender: Any) {
        participationCellDelegate?.refershResultlButtonTapped(cell: self)
    }
    
}
