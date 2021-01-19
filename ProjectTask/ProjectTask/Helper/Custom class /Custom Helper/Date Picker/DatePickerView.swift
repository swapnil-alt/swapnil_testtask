//
//  DatePickerView.swift
//  AVEX
//
//  Created by Sumit5Exceptions on 22/08/17.
//  Copyright © 2017 5Exceptions. All rights reserved.
//

import UIKit

class DatePickerView: UIView{

    /**
     View declerations
     */
    @IBOutlet weak var btnCancel: ButtonClass!
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var btnOk: ButtonClass!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // variable : -
    var onResult : ((String)-> Void)!
    var onResultWithTimeStamp : ((String, String)-> Void)!

    var isDate : Bool = false
    var isTime : Bool = false
    var isTimeStamp : Bool = false


    
   static let sharedInstance = DatePickerView.initLoader()
    
    class func initLoader() -> DatePickerView {
        return UINib(nibName: "datePickerXib", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DatePickerView
    }
    
    @IBAction func btnClicked(_ sender: UIButton){                                                              //-->>  Ok button
       
        if sender.tag == 1 { // cancel button clicked
        
        }else { // ok button clicked
          //  delegate = (UIApplication.shared.keyWindow?.rootViewController)! as! DatePickDelegate  // set delegate to current viewController
            let dateFormatter = DateFormatter()
            // Now we specify the display format, e.g. " 2000/05/02"
            
             if self.isDate{ // true :  selected date
                  dateFormatter.dateFormat = "MM/dd/yyyy"
                
            }else if self.isTime
             {
                dateFormatter.dateFormat = "HH:mm:ss"

//                dateFormatter.dateFormat = "h:mm a"
//                dateFormatter.amSymbol = "AM"
//                dateFormatter.pmSymbol = "PM"
             }
             else { // date with time
                
                // dateFormatter.dateFormat = "HH:mm,dd-MM-yyyy"
                dateFormatter.dateFormat = "dd-MM-yyyy h:mm a "
                dateFormatter.amSymbol = "AM"
                dateFormatter.pmSymbol = "PM"
            }
            
          
            // Now we get the date from the UIDatePicker and convert it to a string
            let strDate = dateFormatter.string(from: datePicker.date)
            // Finally we set the text of the label to our new string with the date
              //  print("date :\(strDate)")

            if isTimeStamp
            {
                onResultWithTimeStamp(strDate,Singleton.shared.getUnixTimeFrom(date: datePicker?.date as! NSDate)
                )
            }
            else
            {
                onResult(strDate)
            }
            
        }
        self.remove()
    }
    
    override func awakeFromNib() {
        //background color 0.5 transparent
    
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        uiView.layer.cornerRadius = 6                                                                          //-->> corner radious
        datePicker.datePickerMode = .date
        uiView.layer.borderColor = CustomColor.black.cgColor // set border color
        btnCancel.layer.cornerRadius = 0
        btnOk.layer.cornerRadius = 0
        btnCancel.backgroundColor = UIColor.black
        //btnOk.backgroundColor = AppDelegate.shared().APP_COLOR
//        uiView.layer.borderWidth = 1 // set border width
        
//        datePicker.backgroundColor = UIColor.white
//        uiView.backgroundColor = UIColor.white
//         btnOk.roundedRight()
//         btnCancel.roundedLeft()

        
    
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.checkAction(sender:)))
        self.addGestureRecognizer(gesture)
   
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        remove()
    }
    
    func show(isDOB : Bool,isDate : Bool ,viewC:UIViewController, onCompletion: @escaping (String)-> Void)
    {
        
         datePicker.date = Date() // current date
        self.isDate = isDate

        if isDate{ // show date formate
            datePicker.datePickerMode = UIDatePicker.Mode.date
        }else{ // show date & time format
            datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        }
        
        
        if isDOB { // Dob
            // To Disable Future date :
            datePicker.maximumDate = Date()
            datePicker.minimumDate = nil
        }else{
            // To Disable past date :
             datePicker.maximumDate = nil
            datePicker.minimumDate = nil
        }
        
        viewC.view.addSubview(self)            //-->> add to subview
       self.onResult = onCompletion
         self.frame = UIScreen.main.bounds
        displayUIview()                                            //-->> Display view with animation
    }
        func showAllDate(isDOB : Bool,isDate : Bool ,viewC:UIViewController, onCompletion: @escaping (String)-> Void)
    {
        
        datePicker.date = Date() // current date
        self.isDate = isDate
        
        if isDate{ // show date formate
            datePicker.datePickerMode = UIDatePicker.Mode.date
        }else{ // show date & time format
            datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        }
        
        
        if isDOB { // Dob
            // To Disable Future date :
            datePicker.maximumDate = Date()
            datePicker.minimumDate = nil
        }else{
            // To Disable past date :
            datePicker.maximumDate = nil
            //datePicker.minimumDate = Date()
        }
        
        viewC.view.addSubview(self)            //-->> add to subview
        self.onResult = onCompletion
        self.frame = UIScreen.main.bounds
        displayUIview()                                            //-->> Display view with animation
    }

    func showAllDateWithTimestampFormat(isDOB : Bool,isDate : Bool ,viewC:UIViewController, onCompletion: @escaping (String, String)-> Void)
       {
            
        
           datePicker.date = Date() // current date
           self.isDate = isDate
           
           if isDate{ // show date formate
               datePicker.datePickerMode = UIDatePicker.Mode.date
           }else{ // show date & time format
               datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
            
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
        
           isTime = false
           isTimeStamp = true
           viewC.view.addSubview(self)            //-->> add to subview
           self.onResultWithTimeStamp = onCompletion
           self.frame = UIScreen.main.bounds
           displayUIview()                                            //-->> Display view with animation
       }
    func showAllDateWithTimestamp(isDOB : Bool,isDate : Bool ,viewC:UIViewController, onCompletion: @escaping (String, String)-> Void)
    {
       
        datePicker.date = Date() // current date
        self.isDate = isDate
        
        if isDate{ // show date formate
            datePicker.datePickerMode = UIDatePicker.Mode.date
        }else{ // show date & time format
            datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
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
        isTime = false
        isTimeStamp = true
        viewC.view.addSubview(self)            //-->> add to subview
        self.onResultWithTimeStamp = onCompletion
        self.frame = UIScreen.main.bounds
        displayUIview()                                            //-->> Display view with animation
    }
    
    func showTime(isDOB : Bool,isDate : Bool ,viewC:UIViewController, onCompletion: @escaping (String)-> Void){
        
        datePicker.date = Date() // current date
        self.isDate = isDate
        
        if isDate{ // show date formate
            datePicker.datePickerMode = UIDatePicker.Mode.date
        }else{ // show date & time format
            datePicker.datePickerMode = UIDatePicker.Mode.time
        }
        isTime = true
        isTimeStamp = false
        
        if isDOB { // Dob
            // To Disable Future date :
            datePicker.maximumDate = Date()
            datePicker.minimumDate = nil
        }else{
            // To Disable past date :
            datePicker.maximumDate = nil
            //datePicker.minimumDate = Date()
            datePicker.minimumDate = nil

        }
        
        viewC.view.addSubview(self)            //-->> add to subview
        self.onResult = onCompletion
        self.frame = UIScreen.main.bounds
        displayUIview()                                            //-->> Display view with animation
    }
    
    
    /*------------------------------------------------------------------------------------------------/
     MARK:  display with animation
     /------------------------------------------------------------------------------------------------*/
    
    func displayUIview() {
        
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
}
extension Date {
    func getElapsedInterval(endDate:Date) -> String
    {
        let interval = Calendar.current.dateComponents([.minute, .day ,.hour , .month, .year , .second], from: self, to: Date())
        var totalTime = "0 \("min")"
//        guard  let minTime = interval.minute else {
//            return totalTime
//        }
//        var year = 0
        
        totalTime = "0"
        if let yerar  = interval.year {
            //   print("year--->",yerar,"<->",year%365,"<->",year/365)
            if yerar > 0
            {
                totalTime = "\(yerar)"
            }
            
            //  year = yerar
            
        }
        return totalTime
        if let month  = interval.month {
            //   print("month--->",month,"<->",month%12,"<->",month/12)
            if month > 0
            {
                totalTime = totalTime + "\(month) month "
            }
            
        }
        if let day  = interval.day {
            //   print("day--->",day,"<->",day%30,"<->",day/30)
            if day > 0
            {
                totalTime = totalTime + "\(day) day "
            }
        }
        
        if let hour  = interval.hour {
            //   print("hour--->",hour,"<->",hour%24,"<->",hour/24)
            if hour > 0
            {
                totalTime = totalTime + "\(hour) hour "
            }
            
        }
        if totalTime == "" {
            if let minute  = interval.minute {
                if minute > 0
                {
                    totalTime = totalTime + "\(minute) min"
                }
            }
            if let second  = interval.second
            {
                if second > 0
                {
                    totalTime = totalTime + "\(second) sec"
                }
            }
        }
        return totalTime
        
        
    }
}
/*
 Calling like :
 
 DatePickerView.show(viewController : self)
 
 and set delegate and delegate methods like : 
 1. delegate  :     var delegate : DatePickDelegate! ,  delegate.selectedDate(date: strDate)
 2. delegate method :   implement:- DatePickDelegate  , method:    func selectedDate(date: strDate) {  /* what ever you do */}
 */



