//
//  GalleryCell.swift
//  Hooga
//
//  Created by @mrendra on 28/01/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class GalleryCell: UITableViewCell {

    @IBOutlet weak var collectionViewGallery : UICollectionView!
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var arrImageAssets = [EventAssets]()
    {
        didSet{
            if collectionViewGallery != nil {
                collectionViewGallery?.reloadData()
            }
        }
    }
    static var identifier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var flowLayout: UICollectionViewFlowLayout {
        let _flowLayout = UICollectionViewFlowLayout()
        
        // edit properties here
        _flowLayout.scrollDirection = .horizontal
        
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing        = 3;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        // edit properties here
        let width = collectionViewGallery.frame.size.width / 2.5
         _flowLayout.itemSize = CGSize(width: width, height: 160)
        
        return _flowLayout
    }
    func configCollectionView()  {

        self.collectionViewGallery.collectionViewLayout = flowLayout
  
        collectionViewGallery?.register(GalleryImageCell.nib, forCellWithReuseIdentifier: GalleryImageCell.identifier)
        collectionViewGallery?.showsHorizontalScrollIndicator = false
        collectionViewGallery?.backgroundColor = UIColor.clear
        collectionViewGallery?.delegate = self
        collectionViewGallery?.dataSource = self
        
        collectionViewGallery?.reloadData()
    }
    
}

extension GalleryCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImageAssets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellImage = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryImageCell.identifier, for: indexPath) as! GalleryImageCell
        let assest  = arrImageAssets[indexPath.row]
        if assest.mediatype?.trim() == "Image" {
            cellImage.buttonPlay.isHidden = true
        }else{
         cellImage.buttonPlay.isHidden = false
        }
        if  cellImage.buttonPlay.isHidden == true{
            if let path = assest.path {
                let url = kImgaeView + path
                cellImage.image.kf.setImage(with: URL(string:url), placeholder: nil, options: nil, progressBlock: nil){ (image, error, cacheType, url) in
                    if image == nil {
                        cellImage.image.kf.setImage(with: placeHolderImageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
                    }
                }
            }else{
                cellImage.image.kf.setImage(with: placeHolderImageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
   
        return cellImage
    }
    
    
    
}

extension GalleryCell : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
      
        let width = (collectionView.frame.size.width / 3) + 10
        return CGSize(width:width,height:160)
        
    }
}
