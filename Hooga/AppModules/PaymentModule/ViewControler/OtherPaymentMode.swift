//
//  OtherPaymentMode.swift
//  Hooga
//
//  Created by @mrendra on 06/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class OtherPaymentMode: UIViewController {
    
    @IBOutlet weak var collectionViewUser: UICollectionView!
    @IBOutlet weak  var otherPaymentView : UIView!

    
    var bookingDetail : EventRecord?

    var arrOtherPayments = [SavePaymentDetail]()
    var savedTicketDetail : [BookingDetailResponse]?
    var  currentUser = 0
    var presentedViewIndex = 0

    var otherPayment : OtherPaymentView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addPaymentView()
        configureData()
        configCollectionView()
    }
    
    
    func configureData()  {
        if let savedTickets = savedTicketDetail{
            for index in 0 ..< savedTickets.count {
                let payment = SavePaymentDetail()
                if let paymentId = savedTickets[index].ticketid{
                    payment.ticketid = paymentId
                }
                arrOtherPayments.append(payment)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonBack_didPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    func configCollectionView()  {
        
        //collectionViewUser.register(OtherPayCell.self, forCellWithReuseIdentifier: "OtherPayCellid")
        collectionViewUser.delegate = self
        collectionViewUser.dataSource = self
        
    }
    
    func checkPayment(uId:Int)  -> SavePaymentDetail?{
        return arrOtherPayments.filter { $0.userId == uId}.first
    }
    
    func addPaymentView(tabIndex:Int = 0)  {
        let nib = UINib.init(nibName: "OtherPaymentView", bundle: nil)
        let views = nib.instantiate(withOwner: self, options: nil)
        otherPayment = views[0] as! OtherPaymentView
        otherPayment.frame = CGRect.init(x: 0, y: 0, width: otherPaymentView.frame.size.width, height: otherPaymentView.frame.size.height)
        otherPayment.delegate = self
        otherPaymentView.addSubview(otherPayment)
        presentedViewIndex = tabIndex
    }
    
    func getPaymentForTicketId(paymentId:Int)  -> SavePaymentDetail?{
        return arrOtherPayments.filter { $0.paymentId == paymentId}.first
    }
    
    func saveOtherPaymentDetailInModel(paymentId:Int)  {
       var payment = arrOtherPayments[presentedViewIndex]

        payment.amountPaid = otherPayment.ampountPaid.text
        payment.otherPayment = otherPayment.otherPayment.text
        payment.payrefNumber = otherPayment.paymentReference.text
        payment.paymentId = paymentId
        //        payment.ticketid = bookingDetail?.selectedTicketType?.tickettypeid
        payment.paidOn       = Date().dateString
        payment.createdOn = Date().dateString
        
        
        let touple =   otherPayment.validate()
        if touple.isEmpty == true , let _ = touple.message {
            payment.paymentId = -1
        }
        
       arrOtherPayments[presentedViewIndex] = payment
        
    }
    
}

extension OtherPaymentMode : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookingDetail!.bookingDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellUser = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherPayCellid", for: indexPath) as! OtherPayCell
        
        let user = bookingDetail!.bookingDetails[indexPath.row]
        cellUser.labelName.text = user.firstname
        
        if indexPath.row == currentUser {
            cellUser.backgroundColor = UIColor.init(red: 68.0/255.0, green: 114.0/255.0, blue: 195.0/255.0, alpha: 1)
        }else{
            cellUser.backgroundColor = UIColor.lightGray
        }
        return cellUser
    }
}
extension OtherPaymentMode : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if presentedViewIndex == indexPath.row {
            return
        }
        saveOtherPaymentDetailInModel(paymentId: presentedViewIndex)
        
        if let ticket = getPaymentForTicketId(paymentId: indexPath.row){
            otherPayment.removeFromSuperview()
            addPaymentView(tabIndex: indexPath.row)
            otherPayment.updateDetail(other: ticket)
            currentUser = indexPath.row
            collectionView.reloadData()
            return
        }
        
        otherPayment.removeFromSuperview()
        addPaymentView(tabIndex: indexPath.row)
        otherPayment.updateDetail(other: arrOtherPayments[indexPath.row])
        currentUser = indexPath.row
        collectionView.reloadData()
    }
    
}


extension OtherPaymentMode {
    
    func savePaymentDetail(arrPayment:[SavePaymentDetail])  {
        TicketBookingService.paymentDetails(bookingDetails: arrPayment) { (flag, data) in
            if let _ = data{
                NavigationManager.thanksController(navigationController: self.navigationController, evntDetail: EventRecord())
            }else{
                //error
            }
            
        }
    }
}
extension Date {
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
    var dateString : String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return  dateFormatterGet.string(from: self)
    }
}


extension OtherPaymentMode:OtherPaymentViewDelegate{
    func submitButtonDidTapped(otherPaymentView: OtherPaymentView) {
   
            saveOtherPaymentDetailInModel(paymentId: presentedViewIndex)
        
            let unFilledTickets = arrOtherPayments.filter({ (bookingDetail) -> Bool in
                return bookingDetail.paymentId == -1
            })
            if unFilledTickets.count > 0{
                Common.showAlert(message: "Please fill ALL Payment info completly")
            }else{
                self.savePaymentDetail(arrPayment: self.arrOtherPayments)
            }
            
        
    }
    
    func cancelButtonDidTapped(otherPaymentView: OtherPaymentView) {
        arrOtherPayments[presentedViewIndex] = SavePaymentDetail()
        otherPayment.updateDetail(other: arrOtherPayments[presentedViewIndex])

    }
    
    
}
