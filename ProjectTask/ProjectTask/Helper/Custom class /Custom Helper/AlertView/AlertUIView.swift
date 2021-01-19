//
//  AlertView.swift
//  MyProject
//
//  Created by Sumit shaw on 7/6/17.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit

class AlertUIView: UIView {
    
    /**
     View declerations
     */
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var uiView: UIView!
    
    @IBAction func btnClicked(_ sender: UIButton){                                                              //-->>  Ok button
        self.remove()
    }
    
    override func awakeFromNib() {
        //background color 0.5 transparent
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        uiView.layer.cornerRadius = 6
//
//        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.checkAction(sender:)))
//        self.addGestureRecognizer(gesture)
    }
    
    @IBAction func actionRemove(_ sender: UIButton) {
     remove()
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
       // remove()
    }
    
    class func show(message: String){
        let customPopUp = Bundle.main.loadNibNamed("AlertUiViewXib", owner: self, options: nil)?[0] as! AlertUIView
        customPopUp.frame = UIScreen.main.bounds
        
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(customPopUp)   //-->> add to subview
        
        customPopUp.displayUIview(msg : message)                                                               //-->> Display view with animation
        
    }
    
    // MARK:  display with animation
    func displayUIview(msg  : String) {
        
        txtMessage.text = msg
        uiView.frame = CGRect(x:50, y: -150 , width: 200, height: 150)
        
        /// Bouncing animation
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            
            var viewFrame = self.uiView.frame
            viewFrame.origin.y = 250
            self.uiView.frame = viewFrame
            
        }) { (true) in
            //  print("done")
        }
    }
    
    
    //MARK:  remove animation
    func remove(){
        //uiView.frame.origin.y = 250
        
        uiView.transform = CGAffineTransform(scaleX: 1, y: 1)
        uiView.alpha = 1
        
        UIView.animate(withDuration: 0.3, animations: {
            var viewFrame = self.uiView.frame
            viewFrame.origin.y = UIScreen.main.bounds.height + 250
            self.uiView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.uiView.alpha = 0
            
        }) { (true) in
            self.removeFromSuperview()
        }
    }
}

/*
 Calling like :
 
 AlertUIView.show(message : "There are some Server error, please try again later")
 */

