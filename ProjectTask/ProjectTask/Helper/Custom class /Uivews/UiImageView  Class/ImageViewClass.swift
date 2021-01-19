//
//  ImageViewClass.swift
//  BizzFinder
//
//  Created by Sumit5Exceptions on 26/07/17.
//  Copyright © 2017 5Exceptions. All rights reserved.
//


import Foundation
import UIKit

@IBDesignable class ImageViewClass: UIImageView
{
    
    
    //MARK: - Background color
    @IBInspectable var backgroundColorCode: UIColor = UIColor.clear {
        didSet {
            self.backgroundColor =  backgroundColorCode
        }
    }
    
    @IBInspectable var topLeftRight: CGFloat = 0.0 {
        didSet{
         self.leftRight()
        }
    }
    //MARK: Border color
    @IBInspectable var borderColorCode: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColorCode.cgColor
        }
    }
    
    

    
    //MARK: Border width
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var tintColorChange : UIColor = UIColor.clear {
              didSet{
                self.image = self.image?.withRenderingMode(.alwaysTemplate)
                self.tintColor = tintColorChange

              }
          }

    @IBInspectable var rotateAngle: CGFloat = 0.0 {
        didSet
        {
            if Singleton.shared.strLandID == "eng"
            {
                self.transform = CGAffineTransform(rotationAngle: 0.0)

            }
            else
            {
                self.transform = CGAffineTransform(rotationAngle: 135)
            }
        }
    }
    
    //MARK:Mirror image
    @IBInspectable var isMirror: Bool = false {
        didSet {
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }

    
    //Mark: - Corner radious
    @IBInspectable var circleView: Bool = false {
        didSet {
            
            if circleView != false{
                
                self.layer.cornerRadius = self.frame.size.width / 2
                self.clipsToBounds = true
                
//                self.layer.shadowColor   = UIColor.clear.cgColor
//                self.layer.shadowOffset  = CGSize(width: 0, height: 1)
//                self.layer.shadowOpacity = 0.9
//                self.layer.shadowRadius  = 3
            }
        }
    }
    
    //Mark: - Corner radius
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    
    ///======================
//    @IBInspectable var isRotate : Bool = false{
//        didSet{
//            apply()
//        }
//    }
//
//
//    @IBInspectable var ArbicIcon : UIImage? = nil{
//        didSet{
//            apply()
//        }
//    }
//
//
//    override open func layoutSubviews() {
//        super.layoutSubviews()
//
//        apply()
//    }
//    func apply(){
//        if Singleton.shared.languageActive() == "Arabic"  {
//
//             self.image = ArbicIcon
//
//        }else{
//             self.image = self.image
//        }
//
//        if isRotate && Singleton.shared.languageActive() == "Arabic"{
//            //  self.transform = CGAffineTransform(rotationAngle: .pi )
//            self.transform = CGAffineTransform(scaleX: -1, y: 1)
//        }
//    }
    
    
    
    //=======================
    
    /*--------------------------------------------------------------------------------------------------*/
    
    // MARK: - View
    override func awakeFromNib()
    {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    func setupView() {
        self.backgroundColor = backgroundColorCode
        
        if circleView != false{
            
            self.layer.cornerRadius = self.frame.size.width / 2
            self.clipsToBounds = true
        }
        if tintColorChange != UIColor.clear
        {
            self.image = self.image?.withRenderingMode(.alwaysTemplate)
            self.tintColor = tintColorChange
        }
        //self.layer.masksToBounds = false
        
        self.setNeedsLayout()
        self.setNeedsDisplay()
    }
    
    func leftRight()
    {
        self.layer.cornerRadius = topLeftRight
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
}


//===========================================================

@IBDesignable
open class ImageView: UIImageView {
    
    @IBInspectable var isRotate : Bool = false{
        didSet{
            apply()
        }
    }
    
    
    @IBInspectable var ArbicIcon : UIImage? = nil{
        didSet{
            apply()
        }
    }
   
       
    override open func awakeFromNib() {
        super.awakeFromNib()
        //  apply()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        apply()
    }
    func apply(){
        
     
//        if ArbicIcon != nil && AppLanguage.isArabic{
//            self.image = ArbicIcon
//        }else {
            self.image = self.image
//        }
        
      
//        if isRotate && AppLanguage.isArabic{
            //  self.transform = CGAffineTransform(rotationAngle: .pi )
//            self.transform = CGAffineTransform(scaleX: -1, y: 1)
        
//        }
        
        
    }
    
    
    
}
