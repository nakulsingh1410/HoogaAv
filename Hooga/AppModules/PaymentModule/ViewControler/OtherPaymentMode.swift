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
    
    @IBAction func buttonSubmit_didPressed(_ sender: Any) {
        
        
        
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
        otherPayment.text = other.otherPayment
        paymentReference.text = other.payrefNumber
        ampountPaid.text = other.amountPaid
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
        otherPayments.append(payment)
        return true
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
        
        return cellUser
    }
    
    
}
extension OtherPaymentMode : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let obj =  checkPayment(uId: indexPath.row) {
            updateUser(other: obj)
           return
        }
       // currentUser = ticket - 1
          //setDetailModel(ticket: ticket - 1)
    }
    
}
