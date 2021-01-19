//
//  PickerView.swift
//  iMozayed
//
//  Created by WVMAC1 on 10/10/18.
//  Copyright © 2018 WVMAC1. All rights reserved.
//

import UIKit

class PickerView: UIView , UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnCancel: UIButton!

    @IBOutlet weak var uiView: UIView!
    // @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pkrView: UIPickerView!
    var arrList = NSArray()

    // variable : -
    var onResult : ((NSDictionary)-> Void)!
    var isDate : Bool = false
    var strKey = String()
    
    static let instance = PickerView.initLoader()
    
    class func initLoader() -> PickerView {
        return UINib(nibName: "PickerViewXIB", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! PickerView
    }
    
    @IBAction func btnClickedOK(_ sender: UIButton){
        if arrList.count > 0 {
            let dict = arrList.object(at: pkrView.selectedRow(inComponent: 0)) as? NSDictionary
            onResult(dict!)
        }

        self.remove()
    }
    
    override func awakeFromNib() {
        //background color 0.5 transparent
        //self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        uiView.layer.cornerRadius = 6                                                                          //-->> corner radious
//        uiView.layer.borderColor = UIColor.black.cgColor//.black.cgColor // set border color
//        uiView.layer.borderWidth = 1 // set border width
        
        pkrView.delegate = self
        pkrView.dataSource = self
        pkrView.reloadAllComponents()
        pkrView.backgroundColor = UIColor.white
        uiView.backgroundColor = UIColor.white
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.checkAction(sender:)))
        self.addGestureRecognizer(gesture)
        
    }
    @objc func checkAction(sender : UITapGestureRecognizer) {
        remove()
    }
    
    func show(arr: NSArray, key:String , onCompletion: @escaping (NSDictionary)-> Void){
        arrList = NSArray()
        btnCancel.setTitle(Singleton.shared.LOCALIZED_STRING_FOR_KEY(key: "CANCEL"), for: .normal)
        btnOk.setTitle(Singleton.shared.LOCALIZED_STRING_FOR_KEY(key: "OK"), for: .normal)

        strKey = key
        arrList = arr
        print("arrList.count--->",arrList.count)
        pkrView.delegate = self
        pkrView.dataSource = self
        pkrView.reloadAllComponents()

     // current date
       /*   datePicker.date = Date()
         self.isDate = isDate
        
        if isDate{ // show date formate
            datePicker.datePickerMode = UIDatePickerMode.date
        }else{ // show date & time format
            datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        }
        
        
        if isDOB { // Dob
            // To Disable Future date :
            datePicker.maximumDate = Date()
            datePicker.minimumDate = nil
        }else{
            // To Disable past date :
            datePicker.maximumDate = nil
            datePicker.minimumDate = Date()
        }
      */
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(self)            //-->> add to subview
        self.onResult = onCompletion
        self.frame = UIScreen.main.bounds
        displayUIview()                                            //-->> Display view with animation
    }
    
    
    /*------------------------------------------------------------------------------------------------/
     MARK:  display with animation
     /------------------------------------------------------------------------------------------------*/
    
    func displayUIview() {
        pkrView.reloadAllComponents()
        uiView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
        uiView.alpha = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.uiView.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            self.uiView.alpha = 1
            
        }) { (true) in
            
            //   print("Date picker isplay: Done")
        }
    }
    
    
    // close this view when it is touch outside of black space
    @IBAction func btnCloseDOB(_ sender: UIButton) {
        remove()
    }
    
    
    
    
    /*------------------------------------------------------------------------------------------------/
     MARK:  remove animation
     /------------------------------------------------------------------------------------------------*/
    func remove(){
        
        uiView.transform = CGAffineTransform(scaleX: 1, y: 1)
        
        uiView.alpha = 1
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.uiView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            
            self.uiView.alpha = 0
            //self.uiView.frame = viewFrame
            
        }) { (true) in
            self.removeFromSuperview()
        }
    }
    
    var pickerType = ""
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1// arrList.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return arrList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let dict = arrList[row]  as! NSDictionary
        let arrKey = strKey.components(separatedBy: ",")
        var strTitle = ""
        if arrKey.count < 2 {
            if let title = dict[strKey] as? String {
                strTitle = title
                return title
            }
        }else{
            for key in arrKey {
                if let title = dict[key] as? String {
                    strTitle = strTitle + title + " "
                }
            }
        }
        
        /*else if let title = dict["bank_name"] as? String {
         return title
         }else if let title = dict["title"] as? String {
         return title
         }
         */
        return strTitle
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont.systemFont(ofSize: 16.0)
            pickerLabel?.textAlignment = .center
            
        }
        pickerLabel?.textColor = UIColor.black
        pickerLabel?.backgroundColor = UIColor.white
        
        let dict = arrList[row]  as! NSDictionary
        
        let arrKey = strKey.components(separatedBy: ",")
        
        var strTitle = ""
        if arrKey.count < 2 {
            if let title = dict[strKey] {
                pickerLabel?.text = "\(title)"
            }
        }else{
            for key in arrKey {
                if let title = dict[key] {
                    strTitle = strTitle + "\(title)" + " "
                }
            }
            pickerLabel?.text = strTitle
            
        }
        
        
        return pickerLabel!;
    }
    
}



