//
//  ParticipateDetailViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 2/7/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class ParticipateDetailViewController: UIViewController {
    @IBOutlet weak var navHeaderView : CustomNavHeaderView!
    @IBOutlet weak var eventTicketInfoView: EventInfoTickerView!

    @IBOutlet weak var lblParticipateName: HoogaLabel!
    @IBOutlet weak var lblLuckyDrawSequence: UILabel!
    @IBOutlet weak var lblLuckyDrawPriceNWon: HoogaLabel!
    @IBOutlet weak var lblPrizeDescription: HoogaLabel!
    @IBOutlet weak var lblPriceCollectedBy: HoogaLabel!
    @IBOutlet weak var lblCollectedOn: HoogaLabel!
    @IBOutlet weak var imgViewPrize: UIImageView!
    
    var  participateDetail: ShowMyEventLuckyDrawResult?
    var eventDetail : EventDetail?
    let fontSize:CGFloat = 17
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configoreNavigationHeader()
         loadParticiapteData()
        
        if let eventDetail =  eventDetail {
            eventTicketInfoView.loadTicketInfo(eventDetail: eventDetail, textColor: UIColor.black, backGroundColor: .white)
        }
        
    }
    func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        navHeaderView.navBarTitle = "Lucky Draw Result Details"
        navHeaderView.backButtonType = .Back
    }
    
    
    func loadParticiapteData()  {
        lblParticipateName.text = ""
        lblLuckyDrawSequence.text =  ""
        lblLuckyDrawPriceNWon.text =    ""
        lblPriceCollectedBy.text =   ""
        lblCollectedOn.text = ""
        lblPrizeDescription.text = ""
        lblLuckyDrawSequence.font = Font.gillSansSemiBold(size: 40)
        lblLuckyDrawSequence.layer.cornerRadius = 5.0
        lblLuckyDrawSequence.clipsToBounds = true
//        lblParticipateName.font = Font.gillSansSemiBold(size: fontSize)
//        lblLuckyDrawSequence.font = Font.gillSansSemiBold(size: fontSize)
//        lblLuckyDrawPriceNWon.font = Font.gillSansSemiBold(size: fontSize)
//        lblPriceCollectedBy.font = Font.gillSansSemiBold(size: fontSize)
//        lblCollectedOn.font = Font.gillSansSemiBold(size: fontSize)
//        lblPrizeDescription.font = Font.gillSansSemiBold(size: fontSize)

        if let data = participateDetail{
            if let string = data.firstName {
                lblParticipateName.text = string
            }
            if let string = data.lastName {
                lblParticipateName.text = lblParticipateName.text! + " " + string
            }
            if let string = data.luckydrawsequence {
                lblLuckyDrawSequence.text =  string
            }
            var strPriceWorth = ""
            if let string = data.luckydrawprize {
                strPriceWorth =    string
            }
            if let string = data.prizeworth {
                strPriceWorth = strPriceWorth + " - " + string
            }
            lblLuckyDrawPriceNWon.text = strPriceWorth
            
            if let string = data.collectedby {
                lblPriceCollectedBy.text =   string
            }
            if let string = data.collectedon {
                lblCollectedOn.text = string.components(separatedBy: " ").first
            }
            if let string = data.prizedescription {
                lblPrizeDescription.text = string
            }
            
            if let path = data.prizeimage {
                    let url = kAssets + path
                    imgViewPrize.kf.setImage(with: URL(string:url), placeholder: nil, options: nil, progressBlock: nil){[weak self] (image, error, cacheType, url) in
                        guard let weakSelf = self else {return}
                        if image == nil {
                            weakSelf.imgViewPrize.kf.setImage(with: placeHolderImageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
                        }
                    }
                }else{
                    imgViewPrize.kf.setImage(with: placeHolderImageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func btnHomeDidTapped(_ sender: Any) {
        NavigationManager.navigateToEvent(navigationController: navigationController)
    }
    
}
