//
//  CountryCodeView.swift
//  Hooga
//
//  Created by Nakul Singh on 2/25/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

protocol CountryCodeViewDelegate {
    
    func countryCodeSelected(code:String,index:Int)
}

class CountryCodeView: UIView {
    @IBOutlet weak var txtFCountryCode: HoogaTextField!
    
    var viewController:UIViewController?
    private var nibView:UIView!
    var countryCodeViewDelegate:CountryCodeViewDelegate?
    var arrCountryCode = [String]()
    /******************************************************/
    //MARK: Function
    /******************************************************/
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNib()
        self.nibView.frame = self.bounds
        self.addSubview(nibView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.nibView.frame = self.bounds
    }
    
    private func loadNib() {
        let bundle = Bundle(for: CountryCodeView.self)
        if let nib = bundle.loadNibNamed("CountryCodeView", owner: self, options: nil)?.first as? UIView {
            nibView = nib
            nibView.backgroundColor = .clear
            txtFCountryCode.text = "65"
        }
    }
    private func openCountryCodePicker(){
        guard let vcObj = viewController else {return}
        if let picker = CustomPickerView.loadPickerView(){
            picker.frame = vcObj.view.frame
            picker.pickerType = .countryCode
            picker.pickerDataSource = arrCountryCode
            picker.customPickerViewDelegate = self
            vcObj.view.addSubview(picker)
        }
    }
    @IBAction func btnCountryCodeTapped(_ sender: Any) {
      
        if arrCountryCode.count > 0 {
            openCountryCodePicker()
            return
        }
        if let array = appDelegate.arrCountryCode {
            arrCountryCode = array.map({$0.Code! + " - " +  $0.Country! })
            openCountryCodePicker()

        }else{
            appDelegate.getCountryCodeAPI()
        }
    }
}
/*********************************************************************************/
// MARK: CustomPickerView Deleagte
/*********************************************************************************/
extension CountryCodeView:CustomPickerViewDelegate{
    func dismissPickerView() {
        
    }
    func didSelectPickerValueAt(title: String, index: Int, pickerType: PickerType?) {
        countryCodeViewDelegate?.countryCodeSelected(code: title, index: index)

//        if let type = pickerType , type == .gendePicker {
//            txtFGender.text = title
//        }
//        if let type = pickerType , type == .cityPicker {
//            txtFCity.text = title
//        }
//        if let type = pickerType , type == .countryCode {
//            if let code = appDelegate.arrCountryCode?[index].Code{
//                txtFCountryCode.text = code
//            }
//        }
    }
}
