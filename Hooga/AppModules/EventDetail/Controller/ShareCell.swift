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

    
}
class ShareCell: UITableViewCell {

    @IBOutlet weak var buttonInsta: SocialButton!
    @IBOutlet weak var buttnFaceBook: SocialButton!
    @IBOutlet weak var buttonGoogle: SocialButton!
    @IBOutlet weak var buttonTwitter: SocialButton!
    @IBOutlet weak var viewTicketView: UIView!
    @IBOutlet weak var viewTicketViewHeightConstraint: NSLayoutConstraint!
    
    var delegate : ShareCellDelegate?
    
    
    @IBOutlet weak var buttonregister: UIButton!
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func showShareCell(isComingFrom:ComingFromScreen)  {
        if isComingFrom == ComingFromScreen.eventListing {
            viewTicketViewHeightConstraint.constant = 0
            buttonregister.isHidden = false

        }else{
            viewTicketViewHeightConstraint.constant = 45
            buttonregister.isHidden = true
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
}
