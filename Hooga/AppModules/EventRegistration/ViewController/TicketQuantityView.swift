//
//  TicketQuantityView.swift
//  Hooga
//
//  Created by @mrendra on 03/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit
protocol TicketQuantityViewDelegate {
    
    func selectedTicket(ticketView:TicketQuantityView, ticket:Int)
    
func isTicketCompleted(ticketView:TicketQuantityView, ticket:Int) -> Bool
    
}
class TicketQuantityView: UIView {
   
    @IBOutlet var collectionQuantity : UICollectionView!
    
    var  delegate  : TicketQuantityViewDelegate?
    
    var qunatity = 0 {
        didSet{
            collectionQuantity.reloadData()
        }
    }
    
    var indexPth : IndexPath!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configQuantityCollection()
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
        }else{
            
            cellQuantity.viewBg.isHidden = true
            cellQuantity.labelQuantity.backgroundColor = UIColor.lightGray
             cellQuantity.labelQuantity.textColor = UIColor.white
        }
        addLayer(labelQuantity:cellQuantity.labelQuantity , frame:cellQuantity.frame)
        return cellQuantity
    }
    
    func addLayer(labelQuantity:UILabel,frame : CGRect)   {
        let frameNew = labelQuantity.frame //Frame of label
    
        // Bottom Layer
        let leftLayer = CALayer()
        leftLayer.frame = CGRect(x: 0, y: 0, width: 1, height: 50)
        leftLayer.backgroundColor = UIColor.black.cgColor
        labelQuantity.layer.addSublayer(leftLayer)
        
        // Top Layer
        let topLayer = CALayer()
        topLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: 1)
        topLayer.backgroundColor = UIColor.black.cgColor
        labelQuantity.layer.addSublayer(topLayer)
        
        // right
        // Top Layer
        let rightLayer = CALayer()
        rightLayer.frame = CGRect(x: frame.width - 8, y: 0, width: 1, height: 50)
        rightLayer.backgroundColor = UIColor.black.cgColor
        labelQuantity.layer.addSublayer(rightLayer)
    }
}

extension TicketQuantityView : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if delegate != nil {
        
            let isCompleted = delegate?.isTicketCompleted(ticketView: self, ticket: indexPath.row + 1)
            
            if isCompleted! {
                indexPth = indexPath
                collectionView.reloadData()
                delegate?.selectedTicket(ticketView: self, ticket: indexPath.row + 1)
            }
        }
        
    }
  
}
