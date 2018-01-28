//
//  AMHorizontalMenu.swift
//  HoogaApp
//
//  Created by @mrendra on 20/01/18.
//  Copyright © 2018 Amrendra. All rights reserved.
//

import UIKit

protocol AMMenuDelegate {
 
    func menuSelected(index:IndexPath,data:CategoryModel)
    
}
//Menu can be create with title , image only or both.
enum AMMenuType {
    case title
    case image
    case both
}

enum AMMenuImagePosition {
    case top
    case bottom
    case left
    case right
}


class AMHorizontalMenu: UIView {

    private var menuItems = [CategoryModel](){
        didSet{
            if collectionView != nil {
               collectionView?.reloadData()
            }
        }
    }
    
    private var collectionView : UICollectionView?
    
    var selectedIndexPath : IndexPath?
    
    
     var imagePosition : AMMenuImagePosition!
    
    var menuType       : AMMenuType?
    
    private let nibCell = UINib.init(nibName: "AMMenuCell", bundle: nil)
    
    private let cellId = "AMMenuCellId"
    
    var delegate : AMMenuDelegate?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        configCollectionView()
    }
    
    init(frame:CGRect , type:AMMenuType) {
        super .init(frame: frame)
        self.menuType = type
         configCollectionView()
        
    }
    
    init(frame:CGRect , both:AMMenuImagePosition) {
        super .init(frame: frame)
        self.imagePosition = both
    }
    
    init(frame:CGRect , item:[CategoryModel]) {
        super .init(frame: frame)
        self.menuItems = item
         configCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadItem()  {
        
        if collectionView != nil {
            collectionView?.reloadData()
        }
    }
    
    func setNib(index:Int)  {
        
        
         //let nibs =     nibCell.instantiate(withOwner: self, options: nil)
        
    }
    
    func cell()  {
        
        switch self.imagePosition {
        case .top: break
            
        case .bottom: break
            
        case .left: break
            
        case .right: break
           
        case .none: break
            
        case .some(_): break
        }
        
    }
    func configCollectionView()  {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal

        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing        = 5;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
       layout.estimatedItemSize = CGSize(width: 1,height: 1)
        
        collectionView = UICollectionView(frame: CGRect(x:0,y:8,width:self.frame.size.width,height:self.frame.size.height-16), collectionViewLayout: layout)
       selectedIndexPath = IndexPath.init(row: 0, section: 0)
        self.addSubview(collectionView!)
        collectionView?.register(nibCell, forCellWithReuseIdentifier: cellId)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        collectionView?.reloadData()
        }
}

extension AMHorizontalMenu : UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return menuItems.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellMenu = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AMMenuCell
        cellMenu.title.text = menuItems[indexPath.row].category?.uppercased()
        
        if selectedIndexPath != nil {
            if selectedIndexPath == indexPath{
                cellMenu.title.textColor = Color.blue
                cellMenu.backgroundColor = Color.white
            }else{
                  cellMenu.backgroundColor = Color.blue
                cellMenu.title.textColor = Color.white
            }
        }else{
            
            cellMenu.title.textColor = Color.white
            cellMenu.backgroundColor = Color.blue
        }
        return cellMenu;
    }
}

extension AMHorizontalMenu : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if delegate != nil {
            
            selectedIndexPath = indexPath
            collectionView.reloadData()
            delegate?.menuSelected(index: indexPath, data: menuItems[indexPath.row])
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//
//        return CGSize(width:50,height:50)
//
//    }

}
