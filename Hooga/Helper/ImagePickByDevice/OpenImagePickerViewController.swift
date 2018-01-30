//
//  OpenImagePickerViewController.swift
//  SongDez
//
//  Created by Nakul Singh on 1/6/17.
//  Copyright © 2017 IGT. All rights reserved.
//

import Foundation
import UIKit

class OpenImagePickerViewController : UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var callback : ((Bool,UIImage)->Void)!
    var callbackForVideo : ((Bool,URL)-> Void)!
    
    func configure(callback:@escaping (Bool,UIImage)->Void){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum){
            self.callback = callback;
            self.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum;
            self.delegate = self;
            //imag.mediaTypes = [kUTTypeImage];
            self.allowsEditing = false
            self.navigationBar.isTranslucent = false
           // self.navigationBar.barTintColor = kAppThemeColor
            self.modalPresentationStyle = .overCurrentContext
        }
    }
    
    func configureToGetVideo(callback:@escaping (Bool,URL)->Void){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            self.callbackForVideo = callback;
            self.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            self.delegate = self;
            self.mediaTypes = ["public.movie"];
            self.allowsEditing = false
            self.videoMaximumDuration = 1
            self.navigationBar.isTranslucent = false
           // self.navigationBar.barTintColor = kAppThemeColor
            self.modalPresentationStyle = .fullScreen
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            let selectedImage : UIImage = image
            let resizedImg:UIImage = selectedImage.resizeImage(targetSize: CGSize(width:250,height: 250))
            callback(true,resizedImg)
        }else if let videoURL = info["UIImagePickerControllerReferenceURL"] as? NSURL {
            print(videoURL )
            print(info)
           // callbackForVideo(true, videoURL! as URL)
        }
       
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
//    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
//        let selectedImage : UIImage = image
//        let resizedImg:UIImage = selectedImage.resizeImage(targetSize: CGSize(width:250,height: 250))
//        callback(true,resizedImg)
//        
//        picker.dismiss(animated: true, completion: nil)
//    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        callback(false,UIImage())
       // callbackForVideo(false,NSURL() as URL)
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension UIImage{
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / self.size.width
        let heightRatio = targetSize.height / self.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width:size.width * heightRatio, height:size.height * heightRatio)
        } else {
            newSize = CGSize(width:size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x:0, y:0, width:newSize.width, height:newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
