//
//  AlertView.swift
//  MyProject
//
//  Created by Sumit shaw on 7/6/17.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit

class AlertOptionView: UIView {
    
    // Outlet
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    var onCloser : ((String)-> Void)!
    
   
    override func awakeFromNib() {
        
        //background color 0.5 transparent
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
       // uiView.layer.cornerRadius = 6                                                                          //-->> corner radious
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
    
    func show(onCompletion: @escaping (String)-> Void){
        let customPopUp = Bundle.main.loadNibNamed("AlertOptionViewXib", owner: self, options: nil)?[0] as! AlertOptionView
        customPopUp.frame = UIScreen.main.bounds
        
       customPopUp.onCloser = onCompletion
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(customPopUp)   //-->> add to subview
        
        customPopUp.displayUIview()
    }
    
    // MARK:  display with animation
    func displayUIview() {
        
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

