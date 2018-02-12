//
//  HLFont.swift
//  HappyLunch
//
//  Created by @mrendra on 29/12/16.
//  Copyright © 2016 ByteClues. All rights reserved.
//

import Foundation
import UIKit

struct Font  {
    
  static  let fontGillSans       = "GillSans"
    static  let fontGillSansLight       = "GillSans"

  static  let fontGotham           = "Gotham-Book"
    
   static  let fontLobster        = "Lobster-Regular"
    
    static  func gillSans(size : CGFloat)  -> UIFont {
        let name = loadFont(name: fontGillSans, type: "ttc")
        return UIFont(name:name, size:size)!
    }
    static  func gillSansLight(size : CGFloat)  -> UIFont {
        let name = loadFont(name: fontGillSans, type: "ttc")
        return UIFont(name:name, size:size)!
    }
    
    static  func gotham(size : CGFloat)  -> UIFont {
        
        let name = loadFont(name: fontGotham, type: "otf")
        
        return UIFont(name: name, size:size)!
        
    }
    
    static  func lobster(size : CGFloat)  -> UIFont {
        
        let name = loadFont(name: fontLobster, type: "ttf")
        
        return UIFont(name: name, size:size)!
        
    }
    
    static  func fontIcon(size : CGFloat)  -> UIFont {
        
        let name = loadFontIcon()
        
        return UIFont(name: name, size:size)!
        
    }
    
    static  func loadFont(name:String,type:String) -> String  {
        
        
        let urlPath = fileFromBundle(fileName:name, fileType: type)
        
        
        let fontDataProvider = CGDataProvider( url: urlPath as! CFURL)
        
    let uiFont = CGFont(fontDataProvider!) as! CGFont
        
        //let uiFontName = uiFont.postScriptName as! String
        
        return uiFont.postScriptName as! String
    
    }
    
   static func loadFontIcon() -> String {
    
    
    let urlPath = fileFromBundle(fileName: "icomoon", fileType: "ttf")
    
    
    let fontDataProvider = CGDataProvider( url: urlPath as! CFURL)
    
    let uiFont = CGFont(fontDataProvider!) as! CGFont
    
    //let uiFontName = uiFont.postScriptName as! String
    
    return uiFont.postScriptName as! String
    
    }
    
    //label.font = UIFont(name: "QuicksandDash-Regular", size: 35)
    
  static  func fileFromBundle(fileName: String?, fileType: String?) -> NSURL?
    {
        var url: NSURL?
        
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType)
        {
            url = NSURL.fileURL(withPath: path) as NSURL?
        }
        
        return url
    }
}
