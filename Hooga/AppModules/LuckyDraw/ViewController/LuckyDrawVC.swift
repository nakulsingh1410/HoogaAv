//
//  LuckyDrawVC.swift
//  Hooga
//
//  Created by @mrendra on 04/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class LuckyDrawVC: UIViewController {

    
    @IBOutlet weak var buttonLeft : UIButton!
    @IBOutlet weak var buttonRight : UIButton!
    @IBOutlet weak var lblEventTitle: HoogaLabel!
    @IBOutlet weak var lblEventLocation: HoogaLabel!
    @IBOutlet weak var lblEventTime: HoogaLabel!
    
    @IBOutlet weak var lblDeadLine: HoogaLabel!
    @IBOutlet weak var lblLocation: HoogaLabel!
    @IBOutlet weak var lblConductedOn: HoogaLabel!
    @IBOutlet weak var lblConductedBy: HoogaLabel!
    
    @IBOutlet weak var luckyCode: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lblLuckyDrawNo: HoogaLabel!
    @IBOutlet weak var btnParticipate: HoogaButton!
    
    @IBOutlet weak var navHeaderView : CustomNavHeaderView!
   
    @IBOutlet weak var viewQRcode: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var showMyEventLuckyDraw: ShowMyEventLuckyDraw?
    var arrShowMyEventLuckyDrawPrizes = [ShowMyEventLuckyDrawPrizes]()
    var eventDetail :EventDetail?
    
    var scrolIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLeft.isHidden = true
        buttonRight.isHidden = true
         btnParticipate.isHidden = true
        configoreNavigationHeader()
        loadDefaultValues()
        initialCalls()
        configCollectionView()
    }

    func initialCalls()  {
        guard let evntdetail = eventDetail else{return}
        showMyEventLuckyDrawStatusAPI(eventId: evntdetail.eventid!)
        showMyEventLuckyDrawAPI(eventId: evntdetail.eventid!)
        
        if let entrytype = evntdetail.entrytype?.trim() ,entrytype == EventType.paid.rawValue{
            if let eventId =  eventDetail?.eventid,let regid =  eventDetail?.regid{
                showMyTicketDetailsAPI(eventId: eventId, regId: regid)
            }
        }else{
            // need to do for free event type
            showRegistrationDetailsAPI(eventId:evntdetail.eventid!,registrationId:evntdetail.regid!)
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        navHeaderView.navBarTitle = "Lucky Draw"
        navHeaderView.backButtonType = .Back
    }
    func loadDefaultValues()  {
        
        if let evetDtl = eventDetail{
            lblEventTitle.text = evetDtl.title
            lblEventLocation.text = evetDtl.eventlocation?.trim()
            let date = Common.getDateString(strDate:evetDtl.startdate) //+ " - " + Common.getDateString(strDate:evetDtl.enddate)
            let time = Common.getDateString(strDate:evetDtl.starttime) //+ " - " + Common.getDateString(strDate:eventDetail?.endtime)
            lblEventTime.text =  date + " | " + time
        }
        lblEventTitle.font = Font.gillSansBold(size: 17)

    }
    
    
    func showLuckyDrawData()  {
        lblDeadLine.text = ""
        lblLocation.text = ""
        lblConductedOn.text = ""
        lblConductedBy.text =  ""

        if let data = showMyEventLuckyDraw{
            
            if let string = data.entrydeadline?.trim(),string.length > 0{
                lblDeadLine.text = "Deadline: " + string
            }
            if let string = data.location?.trim(),string.length > 0{
                lblLocation.text = "Location: "  + string
            }
            if let string = data.heldon?.trim(),string.length > 0{
                lblConductedOn.text = "Conducted On: " + string
            }
            if let string = data.conductedby?.trim(),string.length > 0{
                lblConductedBy.text =  "Conducted By: " + string
            }
        }
    }
    

    @IBAction func buttonParticipat_didPressed(_ sender: Any) {
        if let eventDetailObj = eventDetail{
            NavigationManager.openParticipate(navigationController: navigationController, evntDetail: eventDetailObj)
        }
    }
   

}

/*********************************************************************************/
// MARK: APIs
/*********************************************************************************/
///////////////////PAID Entry/////////////

extension LuckyDrawVC {
    
    func showMyEventLuckyDrawStatusAPI(eventId:Int)  {
        TicketBookingService.showMyEventLuckyDrawStatus(eventid: eventId) {[weak self] (flag, status) in
            guard let weakSelf = self else{return}
           
            if let statusFlag = status, statusFlag == "True" {
                 weakSelf.btnParticipate.isHidden = false
            }
            weakSelf.showMyEventLuckyDrawPrizesAPI(eventId: eventId)
        }
    }
  
    func showMyEventLuckyDrawPrizesAPI(eventId:Int)  {
        TicketBookingService.showMyEventLuckyDrawPrizes(eventid: eventId) {[weak self] (flag, array) in
            guard let weakSelf = self else{return}
            
            if let showMyEventLuckyDrawPrizes = array{
                weakSelf.arrShowMyEventLuckyDrawPrizes = showMyEventLuckyDrawPrizes
                // use collection view reload
              
                if weakSelf.arrShowMyEventLuckyDrawPrizes.count > 1 {
                    weakSelf.buttonRight.isHidden = false
                }
                weakSelf.collectionView.reloadData()
            }
        }
    }
    
    func showMyEventLuckyDrawAPI(eventId:Int)  {
        TicketBookingService.showMyEventLuckyDraw(eventid: eventId) {[weak self] (flag, showMyEventLuckyDraw) in
            guard let weakSelf = self else{return}
            if let obj = showMyEventLuckyDraw {
                weakSelf.showMyEventLuckyDraw = obj
                weakSelf.showLuckyDrawData()
            }
        }
    }
    
    func showRegistrationDetailsAPI(eventId:Int,registrationId:Int)  {
        TicketBookingService.showRegistrationDetails(eventid: eventId,registrationid:registrationId) {[weak self] (flag, array) in
            guard let weakSelf = self else{return}
            weakSelf.btnParticipate.setTitle(ButtonTitle.participate.rawValue, for: .normal)
            if let data = array{
                if let luckydrawsequence = data.first?.luckydrawsequence?.trim(), luckydrawsequence.length > 0 {
                    weakSelf.btnParticipate.setTitle(ButtonTitle.showLuckyDrawNumber.rawValue, for: .normal)
                }else{
                }
            }
        }
    }
    
    func showMyTicketDetailsAPI(eventId:Int,regId:Int)  {
        
        TicketBookingService.showMyTicketDetails(eventid: eventId,registrationid:regId) {[weak self] (flag, array) in
            guard let weakSelf = self else{return}
            weakSelf.btnParticipate.setTitle(ButtonTitle.participate.rawValue, for: .normal)

            if let data = array{
                var luckydrawNo : String?
                for ticket in data{
                    if let luckydrawsequence = ticket.luckydrawsequence,luckydrawsequence.length > 0{
                        luckydrawNo  = luckydrawsequence
                        break
                    }
                }
                if let _ = luckydrawNo{
                    weakSelf.btnParticipate.setTitle(ButtonTitle.showLuckyDrawNumber.rawValue, for: .normal)
                }
                
            }else{
         
            }
        
        }
    }
  
}


extension LuckyDrawVC {
    
    var flowLayout: UICollectionViewFlowLayout {
        let _flowLayout = UICollectionViewFlowLayout()
        
        // edit properties here
        _flowLayout.scrollDirection = .horizontal
        
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing        = 3;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        // edit properties here
        let width = UIScreen.main.bounds.size.width - 40 // / 2.5
        _flowLayout.itemSize = CGSize(width: width, height: collectionView.frame.size.height)
        
        return _flowLayout
    }
    
    func configCollectionView()  {
        
        
        collectionView.collectionViewLayout = flowLayout
        
        collectionView?.register(LuckyDrawCell.nib, forCellWithReuseIdentifier: LuckyDrawCell.identifier)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.isPagingEnabled = true
        collectionView?.reloadData()
        collectionView?.isScrollEnabled = false
      
    }
    
    @IBAction func buttonLeft_didPressed(left:UIButton){
        
        let indxPaath = collectionView.indexPathsForVisibleItems
        
        if indxPaath.count < 2 {
            let  index = indxPaath[0].row
            scrolIndex = index - 1
            if scrolIndex >= 0 {
                collectionView?.isScrollEnabled = true
                collectionView?.scrollToItem(at: IndexPath.init(row: scrolIndex, section: 0), at: .centeredHorizontally, animated: true)
                buttonRight.isHidden = false
                if  scrolIndex == 0 {
                    buttonLeft.isHidden = true
                }
            }
            collectionView?.isScrollEnabled = false
        }
    }
    
    @IBAction func buttonRight_didPressed(left:UIButton){
        
        let indxPaath = collectionView.indexPathsForVisibleItems
        if indxPaath.count < 2 {
            let  index = indxPaath[0].row
            scrolIndex = index + 1
            if scrolIndex <  arrShowMyEventLuckyDrawPrizes.count {
                collectionView?.isScrollEnabled = true
                collectionView?.scrollToItem(at: IndexPath.init(row: scrolIndex, section: 0), at: .centeredHorizontally, animated: true)
                self.buttonLeft.isHidden = false
                let cnt = arrShowMyEventLuckyDrawPrizes.count - 1
                if  scrolIndex == cnt  {
                    self.buttonRight.isHidden = true
                }
            }
        }
        collectionView?.isScrollEnabled = false
    }
}


extension LuckyDrawVC : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrShowMyEventLuckyDrawPrizes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellImage = collectionView.dequeueReusableCell(withReuseIdentifier: LuckyDrawCell.identifier, for: indexPath) as! LuckyDrawCell
        let obj = arrShowMyEventLuckyDrawPrizes[indexPath.row]
        if let price = obj.prizeworth{
            cellImage.labelPrice.text =  "$" + price
        }else{
            cellImage.labelPrice.text = ""
        }
        cellImage.labelTitle.text = obj.prizetitle
        cellImage.labelDescription.text = obj.prizedescription
        
        if let path = obj.prizeimage {
            let url = kPrice + path
            cellImage.imageLucky.kf.setImage(with: URL(string:url), placeholder: nil, options: nil, progressBlock: nil){ (image, error, cacheType, url) in
                if image == nil {
                    cellImage.imageLucky.kf.setImage(with: placeHolderImageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
        }else{
            cellImage.imageLucky.kf.setImage(with: placeHolderImageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        }

        return cellImage
    }
}

extension LuckyDrawVC : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let width = UIScreen.main.bounds.size.width - 16//(collectionView.frame.size.width / 3) + 10
        return CGSize(width:width,height:collectionView.frame.size.height)
        
    }
}
