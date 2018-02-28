//
//  ShareCell.swift
//  Hooga
//
//  Created by @mrendra on 28/01/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

protocol ShareCellDelegate {
    func faqSelected()
    func termSelected()
    func registerBttonSelected(cell:ShareCell)
    func viewTicketDidSelected(cell:ShareCell)
    func luckyDrawDidSelected(cell:ShareCell)
    func bookMoreDidSelected(cell:ShareCell)
    
}
class ShareCell: UITableViewCell {
    
    @IBOutlet weak var lblShareLabel: HoogaLabel!
    @IBOutlet weak var btnFAQs: UIButton!
    @IBOutlet weak var btnTermsNCondition: UIButton!
    @IBOutlet weak var buttonInsta: SocialButton!
    @IBOutlet weak var buttnFaceBook: SocialButton!
    @IBOutlet weak var buttonGoogle: SocialButton!
    @IBOutlet weak var buttonTwitter: SocialButton!
    @IBOutlet weak var btnViewTicket: HoogaButton!
    @IBOutlet weak var btnLuckyTicket: HoogaButton!
    //    @IBOutlet weak var btnBookMore: HoogaButton!
    
    @IBOutlet weak var viewTicketView: UIView!
    @IBOutlet weak var viewTicketViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var socialPlatformStackviewHeightConstraint: NSLayoutConstraint!
    var delegate : ShareCellDelegate?
    var eventDetailObj : EventDetail?
    
    @IBOutlet weak var buttonregister: UIButton!
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none

    }
    
    
    func loadCellData(arrEventFlatform:[EventPlatform],eventDetail:EventDetail?,isComingFrom: ComingFromScreen,isTicketBooked:Bool)  {
        eventDetailObj = eventDetail
        cellSharePlateForm(arrEventFlatform:arrEventFlatform)
        if let eventType = eventDetail?.entrytype?.trim(), eventType == EventType.paid.rawValue{
            showShareCellForPaidEvent(isComingFrom: isComingFrom, isTicketBooked: isTicketBooked)
        }else{
            showShareCellForFreeEvent(isComingFrom: isComingFrom, isTicketBooked: isTicketBooked)

        }
//        showShareCell(isComingFrom: isComingFrom,isTicketBooked:isTicketBooked, eventType: eventDetail?.entrytype)
      
        
    }
    
    func cellSharePlateForm(arrEventFlatform:[EventPlatform])  {
        
        buttnFaceBook.isHidden = true
        buttonTwitter.isHidden = true
        buttonInsta.isHidden = true
        buttonGoogle.isHidden = true
        if arrEventFlatform.count >  0{
            socialPlatformStackviewHeightConstraint.constant = 35
            lblShareLabel.text = "Share:"
            for item in arrEventFlatform {
                if item.platform == "Facebook"{
                    buttnFaceBook.url = item.url
                    buttnFaceBook.isHidden = false
                }else if item.platform ==  "Twitter"{
                    buttonTwitter.url = item.url
                    buttonTwitter.isHidden = false
                }else if item.platform ==  "Instagram"{
                    buttonInsta.url = item.url
                    buttonInsta.isHidden = false
                }else if item.platform ==  "Goggle"{
                    buttonGoogle.url = item.url
                    buttonGoogle.isHidden = false
                }
            }
        }else{
            socialPlatformStackviewHeightConstraint.constant = 0
            lblShareLabel.text = ""
            
        }
    }
    
    
    func showShareCellForPaidEvent(isComingFrom:ComingFromScreen,isTicketBooked :Bool)  {
       
        if isComingFrom == ComingFromScreen.eventListing {
            viewTicketViewHeightConstraint.constant = 0
            if isTicketBooked{
                if let regId = eventDetailObj?.regid , regId > 0{
                    buttonregister.setTitle(RegisterButtonTitle.bookMoreTicket.rawValue, for: .normal)
                }else{
                    buttonregister.setTitle(RegisterButtonTitle.register.rawValue, for: .normal)
                }
            }else{
                if let regId = eventDetailObj?.regid , regId > 0{
                    buttonregister.setTitle(RegisterButtonTitle.bookTickets.rawValue, for: .normal)
                }else{
                    buttonregister.setTitle(RegisterButtonTitle.register.rawValue, for: .normal)
                }
            }
          
        }else{
            viewTicketViewHeightConstraint.constant = 112
            if isTicketBooked{
                btnViewTicket.isHidden = false
                btnLuckyTicket.isHidden = false
                
                buttonregister.setTitle(RegisterButtonTitle.bookMoreTicket.rawValue, for: .normal)
                btnViewTicket.setTitle(RegisterButtonTitle.viewTickets.rawValue, for: .normal)
            }else{
                btnViewTicket.isHidden = true
                btnLuckyTicket.isHidden = true
                viewTicketViewHeightConstraint.constant = 0
                
                buttonregister.setTitle(RegisterButtonTitle.bookTickets.rawValue, for: .normal)
                
            }
            
        }
    }
    func showShareCellForFreeEvent(isComingFrom:ComingFromScreen,isTicketBooked :Bool)  {
        
        if isComingFrom == ComingFromScreen.eventListing {
            viewTicketViewHeightConstraint.constant = 0
             if isTicketBooked{
                if let regId = eventDetailObj?.regid , regId > 0{
                    buttonregister.setTitle(RegisterButtonTitle.addMoreParticipants.rawValue, for: .normal)
                }else{
                    buttonregister.setTitle(RegisterButtonTitle.register.rawValue, for: .normal)
                }
            }else{
                if let regId = eventDetailObj?.regid , regId > 0{
                    buttonregister.setTitle(RegisterButtonTitle.addParticipants.rawValue, for: .normal)
                }else{
                    buttonregister.setTitle(RegisterButtonTitle.register.rawValue, for: .normal)
                }
            }
        }else{
            viewTicketViewHeightConstraint.constant = 112
            if isTicketBooked{
                btnViewTicket.isHidden = false
                btnLuckyTicket.isHidden = false
                
                buttonregister.setTitle(RegisterButtonTitle.addMoreParticipants.rawValue, for: .normal)
                btnViewTicket.setTitle(RegisterButtonTitle.viewQRCodes.rawValue, for: .normal)
                
            }else{
                btnViewTicket.isHidden = true
                btnLuckyTicket.isHidden = true
                viewTicketViewHeightConstraint.constant = 0
                
                buttonregister.setTitle(RegisterButtonTitle.addParticipants.rawValue, for: .normal)
            }
        }
    }
    
    
    @IBAction func buttonTermCondition_didPressed(_ sender: Any) {
        
        guard (delegate) != nil else {
            return
        }
        delegate?.termSelected()
    }
    @IBAction func buttonFaq_didPressed(_ sender: Any) {
        
        guard (delegate) != nil else {
            return
        }
        delegate?.faqSelected()
    }
    
    @IBAction func buttonRegister_didPressed(_ sender: Any) {
        delegate?.registerBttonSelected(cell: self)
    }
    @IBAction func btnViewTicketsTapped(_ sender: Any) {
        delegate?.viewTicketDidSelected(cell: self)
        
    }
    @IBAction func btnLuckyDrawTapped(_ sender: Any) {
        delegate?.luckyDrawDidSelected(cell: self)
        
    }
//    @IBAction func btnBookMoreTapped(_ sender: Any) {
//        delegate?.bookMoreDidSelected(cell: self)
//    }
}
