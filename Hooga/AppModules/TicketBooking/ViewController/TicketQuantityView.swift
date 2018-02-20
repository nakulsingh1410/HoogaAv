//
//  TicketQuantityView.swift
//  Hooga
//
//  Created by @mrendra on 03/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.


import UIKit
protocol TicketQuantityViewDelegate {
    
//    func selectedTicket(ticketView:TicketQuantityView, ticket:Int)
//    func isTicketCompleted(ticketView:TicketQuantityView, ticket:Int) -> Bool
    func didSelectRowAt(indexpath:IndexPath,ticektQuantityView:TicketQuantityView)

    
}
class TicketQuantityView: UIView {
    
    @IBOutlet var collectionQuantity : UICollectionView!
    
    @IBOutlet var widthColl : NSLayoutConstraint!
     @IBOutlet var heightColl : NSLayoutConstraint!
    
    var  delegate  : TicketQuantityViewDelegate?
    
    var qunatity = 0 {
        didSet{
            setWidth()
            collectionQuantity.reloadData()
        }
    }
    
    var indexPth : IndexPath!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configQuantityCollection()
    }
    func setWidth()  {
        
        let wdith = UIScreen.main.bounds.width - 40
        if wdith > CGFloat((80 * qunatity)){
           
            if qunatity == 1{
                
              let  wdth =  CGFloat(80 * qunatity) + 20.0
                widthColl.constant = wdth
                heightColl.constant = 50.0
                
            }else{
                
                 widthColl.constant = CGFloat(80 * qunatity)
            }
            
        }else{
            widthColl.constant = wdith
        }
    }
    func configQuantityCollection()  {

        
        collectionQuantity.register(QuantityCell.nib, forCellWithReuseIdentifier: QuantityCell.identifier)
        indexPth = IndexPath.init(row: 0, section: 0)
        collectionQuantity.delegate     = self
        collectionQuantity.dataSource = self

        if let layout = collectionQuantity.collectionViewLayout as? UICollectionViewFlowLayout {
            
            layout.scrollDirection = .horizontal
            
            layout.minimumInteritemSpacing = 0;
            layout.minimumLineSpacing        = 0;
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
}

extension TicketQuantityView : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return qunatity
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellQuantity = collectionView.dequeueReusableCell(withReuseIdentifier: QuantityCell.identifier, for: indexPath) as! QuantityCell
        
        cellQuantity.labelQuantity.text = String(indexPath.row + 1)
        
        if indexPth == indexPath {
            cellQuantity.viewBg.isHidden = false
            cellQuantity.labelQuantity.backgroundColor = UIColor.white
            
            cellQuantity.labelQuantity.textColor = UIColor.black
            cellQuantity.labelLine.isHidden = true
        }else{
            
            cellQuantity.viewBg.isHidden = true
            cellQuantity.labelLine.isHidden = false
            cellQuantity.labelQuantity.backgroundColor = UIColor.lightGray
            cellQuantity.labelQuantity.textColor = UIColor.white
           // cellQuantity.backgroundColor = UIColor.lightGray
        }
        addLayer(labelQuantity:cellQuantity.labelQuantity , frame:cellQuantity.frame)
        return cellQuantity
    }
    
    func addLayer(labelQuantity:UILabel,frame : CGRect)   {
       var frameNew = labelQuantity.frame //Frame of label
        frameNew = CGRect(x: frameNew.origin.x, y: frameNew.origin.y, width: frame.width - 3, height: 52)
        // left Layer
        let leftLayer = CALayer()
        leftLayer.frame = CGRect(x: 0, y: 0, width: 1, height: 50)
        leftLayer.backgroundColor = UIColor.black.cgColor
        labelQuantity.layer.addSublayer(leftLayer)
        
        // Top Layer
        let topLayer = CALayer()
        topLayer.frame = CGRect(x: 0, y: 0, width: frameNew.width, height: 1)
        topLayer.backgroundColor = UIColor.black.cgColor
        labelQuantity.layer.addSublayer(topLayer)
        
        // right
        // Top Layer
        let rightLayer = CALayer()
        rightLayer.frame = CGRect(x: frameNew.width  , y: 0, width: 1, height: 50)
        rightLayer.backgroundColor = UIColor.black.cgColor
        labelQuantity.layer.addSublayer(rightLayer)
    }
}

extension TicketQuantityView : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.didSelectRowAt(indexpath: indexPath,ticektQuantityView:self)

//        if delegate != nil {
//
//            let isCompleted = delegate?.isTicketCompleted(ticketView: self, ticket: indexPath.row + 1)
//
//            if isCompleted! {
//                indexPth = indexPath
//                collectionView.reloadData()
//                delegate?.selectedTicket(ticketView: self, ticket: indexPath.row + 1)
//            }
//        }
//
    }
    
}
