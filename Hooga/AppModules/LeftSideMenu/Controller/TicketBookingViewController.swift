//
//  TicketBookingViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 2/2/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class TicketBookingViewController: UIViewController {
    @IBOutlet weak var navHeaderView: CustomNavHeaderView!
    @IBOutlet weak var imgViewBanner: UIImageView!
    
    @IBOutlet weak var lblEventTitle: HoogaLabel!
    @IBOutlet weak var lblEventLocation: HoogaLabel!
    @IBOutlet weak var lblEventTime: HoogaLabel!

    var eventDetail:EventDetail?
    override func viewDidLoad() {
        super.viewDidLoad()
        configoreNavigationHeader()
        loadDefaultValues()
    }
    
    func configoreNavigationHeader()  {
            navHeaderView.viewController = self
            navHeaderView.navBarTitle = "Ticket Booking"
            navHeaderView.backButtonType = .Back
        navHeaderView.isBottonLineHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadDefaultValues()  {
        if let evetDtl = eventDetail{
            
            if let path = evetDtl.bannerimage {
                let url = kImgaeView + path
                imgViewBanner.kf.setImage(with: URL(string:url), placeholder: nil, options: nil, progressBlock: nil){[weak self] (image, error, cacheType, url) in
                    guard let weakSelf = self else {return}
                    if image == nil {
                        weakSelf.imgViewBanner.kf.setImage(with: placeHolderImageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
                    }
                }
            }else{
                imgViewBanner.kf.setImage(with: placeHolderImageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            }
            
            lblEventTitle.text = evetDtl.title
            lblEventLocation.text = evetDtl.eventlocation?.trim()
            
//            let date = getDateString(strDate:evetDtl.startdate) + " - " + getDateString(strDate:evetDtl.enddate)
//            let time = getDateString(strDate:evetDtl.starttime) + " - " + getDateString(strDate:eventDetail?.endtime)
//            lblEventTime.text =  date + " | " + time
        }
//        prefilledUsedData()
        
    }
    
}
