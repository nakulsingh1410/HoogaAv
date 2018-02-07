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
    
    @IBOutlet weak var ampountPaid: HoogaTextField!
    @IBOutlet weak var paymentReference: HoogaTextField!
    @IBOutlet weak var otherPayment: HoogaTextField!
    
    var bookingDetail : EventRecord?
    
    var otherPayments = [SavePaymentDetail]()
    
    var  currentUser = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonBack_didPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func buttonSubmit_didPressed(_ sender: Any) {
        
        if checkPayment(uId: currentUser) == nil {
            let ok =   setPayment(uId: currentUser)
        }
        if bookingDetail?.bookingDetails.count == otherPayments.count {
            
            savePaymentDetail(arrPayment: otherPayments)
            
        }else{
            
             Common.showAlert(message: "Please fill all reqiured details")
        }
        
    }
    
    func configCollectionView()  {
        
        //collectionViewUser.register(OtherPayCell.self, forCellWithReuseIdentifier: "OtherPayCellid")
        collectionViewUser.delegate = self
        collectionViewUser.dataSource = self
        
    }
    
    func checkPayment(uId:Int)  -> SavePaymentDetail?{
        return otherPayments.filter { $0.userId == uId}.first
    }
    
    func updateUser(other:SavePaymentDetail)  {
        
        otherPayment.text         = other.otherPayment
        paymentReference.text = other.payrefNumber
        ampountPaid.text          = other.amountPaid
        
    }
    
    func setPayment(uId:Int) -> Bool {
       
        if let value = otherPayment.text,value.trimmingCharacters(in: .whitespaces).isEmpty{
          Common.showAlert(message: "Please enter other payment")
            return false
        }else if let pay = paymentReference.text, pay.trimmingCharacters(in: .whitespaces).isEmpty {
                Common.showAlert(message: "Please enter  payment reference")
            return false
        }else if let paid = ampountPaid.text, paid.trimmingCharacters(in: .whitespaces).isEmpty {
                Common.showAlert(message: "Please enter paid payment")
            return false
        }
        
        let payment = SavePaymentDetail()
        payment.amountPaid = ampountPaid.text
        payment.otherPayment = otherPayment.text
        payment.payrefNumber = paymentReference.text
        payment.ticketid = bookingDetail?.selectedTicketType?.tickettypeid
       payment.paidOn       = Date().dateString
        payment.createdOn = Date().dateString
        otherPayments.append(payment)
        return true
    }
    
    func updateChanges(save:SavePaymentDetail,index:Int)  {
        save.amountPaid = ampountPaid.text
        save.otherPayment = otherPayment.text
        save.payrefNumber = paymentReference.text
        
        otherPayments[index] = save
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
        //68 114 195
        
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
        
        if let obj =  checkPayment(uId: indexPath.row) {
            currentUser = indexPath.row
            updateUser(other: obj)
           return
        }
        if let obj =  checkPayment(uId: currentUser) {
            updateChanges(save: obj, index: currentUser)
        }
       let isDone =    setPayment(uId: indexPath.row)
        if isDone {
            currentUser = indexPath.row
            collectionView.reloadData()
        }
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
