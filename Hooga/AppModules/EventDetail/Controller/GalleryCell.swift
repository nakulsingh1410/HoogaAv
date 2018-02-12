//
//  GalleryCell.swift
//  Hooga
//
//  Created by @mrendra on 28/01/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit
import AVKit

class GalleryCell: UITableViewCell {

    @IBOutlet weak var collectionViewGallery : UICollectionView!
    @IBOutlet weak var buttonLeft : UIButton!
    @IBOutlet weak var buttonRight : UIButton!
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var arrImageAssets = [EventAssets]()
    {
        didSet{
            if collectionViewGallery != nil {
                collectionViewGallery?.reloadData()
                buttonLeft.isHidden = true
                buttonRight.isHidden = true
                if arrImageAssets.count > 1 {
                    buttonRight.isHidden = false
                }
            }
        }
    }
    
    var scrolIndex = 0
   
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
        let width = UIScreen.main.bounds.size.width - 16 // / 2.5
         _flowLayout.itemSize = CGSize(width: width, height: 200)
        
        return _flowLayout
    }
    func configCollectionView()  {

        self.collectionViewGallery.collectionViewLayout = flowLayout
  
        collectionViewGallery?.register(GalleryImageCell.nib, forCellWithReuseIdentifier: GalleryImageCell.identifier)
        collectionViewGallery?.showsHorizontalScrollIndicator = false
        collectionViewGallery?.backgroundColor = UIColor.clear
        collectionViewGallery?.delegate = self
        collectionViewGallery?.dataSource = self
        collectionViewGallery?.isPagingEnabled = true
        collectionViewGallery?.reloadData()
        collectionViewGallery?.isScrollEnabled = false
        ///////////////////////////////////
       
    }
    
    @IBAction func buttonLeft_didPressed(left:UIButton){
        
        let indxPaath = collectionViewGallery.indexPathsForVisibleItems
        
        if indxPaath.count < 2 {
           let  index = indxPaath[0].row
            scrolIndex = index - 1
            if scrolIndex >= 0 {
                collectionViewGallery?.isScrollEnabled = true
                collectionViewGallery?.scrollToItem(at: IndexPath.init(row: scrolIndex, section: 0), at: .centeredHorizontally, animated: true)
                buttonRight.isHidden = false
                if  scrolIndex == 0 {
                    buttonLeft.isHidden = true
                }
            }
             collectionViewGallery?.isScrollEnabled = false
        }
        
        
        
    }
    
    @IBAction func buttonRight_didPressed(left:UIButton){
        
        let indxPaath = collectionViewGallery.indexPathsForVisibleItems
        if indxPaath.count < 2 {
            let  index = indxPaath[0].row
            scrolIndex = index + 1
            if scrolIndex <  arrImageAssets.count {
                collectionViewGallery?.isScrollEnabled = true
                collectionViewGallery?.scrollToItem(at: IndexPath.init(row: scrolIndex, section: 0), at: .centeredHorizontally, animated: true)
                 self.buttonLeft.isHidden = false
                let cnt = arrImageAssets.count - 1
                if  scrolIndex == cnt  {
                    self.buttonRight.isHidden = true
                    
                 }
            }
          }
        collectionViewGallery?.isScrollEnabled = false
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
     
          cellImage.buttonPlay.addTarget(self, action: #selector(buttonPlay_didPressed(button:)), for: .touchUpInside)
        return cellImage
    }
    
    func playVideo(rul :String)  {
        
        let url = kImgaeView + rul
        let videoURL = URL(string: url)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        if let vc = UIApplication.shared.keyWindow?.visibleViewController{
            vc.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
    }
    @objc func buttonPlay_didPressed(button:UIButton)  {
        
        let indxPaath = collectionViewGallery.indexPathsForVisibleItems
        
        if indxPaath.count < 2 {
            let indx = indxPaath[0].row
            let assest  = arrImageAssets[indx]
            if assest.mediatype?.trim() == "Video" {
                if let path = assest.path {
                    playVideo(rul: path)
                }
            }
        }
    }
}

extension GalleryCell : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let assest  = arrImageAssets[indexPath.row]
        if assest.mediatype?.trim() == "Video" {
            if let path = assest.path {
              playVideo(rul: path)
            }
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
      
        let width = UIScreen.main.bounds.size.width - 16//(collectionView.frame.size.width / 3) + 10
        return CGSize(width:width,height:160)
        
    }
}
