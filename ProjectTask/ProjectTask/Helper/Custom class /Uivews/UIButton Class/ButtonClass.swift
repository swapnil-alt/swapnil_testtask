//
//  ButtonClass.swift
//  MyProject
//
//  Created by Sumit shaw on 7/24/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class ButtonClass: UIButton {
    private var shadowLayer: CAShapeLayer!

    private let ButtonPadding: CGFloat = 50

    //MARK: Border color
    @IBInspectable var borderColorCode: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColorCode.cgColor
        }
    }
    
    //MARK: set app color
    @IBInspectable var isAppColor: Bool = false
        {
        didSet {
            //self.layer.borderColor = borderColorCode.cgColor
        }
    }
    
    //MARK: Border width
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    
    
    //Mark: - Corner radious
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.shadowColor()
        }
    }
    
    
    //MARK: - Font color
    @IBInspectable var filledColorCode: UIColor = UIColor.clear {
        didSet {
        }
    }
    
    
    
    /*----------------------------------------------------------------------------------------------------------/
     MARK: - pading : group ==: left , right , top , buttom*
     /-----------------------------------------------------------------------------------------------------------*/
    
    // padding left :
    @IBInspectable var paddingLeft: CGFloat = 0.0 {
        didSet {
            setPadding(top: paddingTop, left: paddingLeft, bottom: paddingButtom, right: paddingRight)        }
    }
    
    
    // padding left :
    @IBInspectable var paddingRight: CGFloat = 0.0 {
        didSet {
            setPadding(top: paddingTop, left: paddingLeft, bottom: paddingButtom, right: paddingRight)
        }
    }
    
    
    // padding left :
    @IBInspectable var paddingTop: CGFloat = 0.0 {
        didSet {
            setPadding(top: paddingTop, left: paddingLeft, bottom: paddingButtom, right: paddingRight)        }
    }
    
    
    // padding left :
    @IBInspectable var paddingButtom: CGFloat = 0.0 {
        didSet {
            setPadding(top: paddingTop, left: paddingLeft, bottom: paddingButtom, right: paddingRight)
        }
    }

    func shadowColor()
    {
      
        
    }
    
    // set padding left, right , top , bottom
    func setPadding(top : CGFloat , left : CGFloat , bottom : CGFloat , right : CGFloat){
        self.contentEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    /*-------------------------------------------------------------------------------------------------------------*/
    
    // MARK: - View
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }

    
    func setupView() {
        
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        
        // self.titleLabel?.font = UIFont(name: GlobalCustomFont.Robo_Font, size: tintSize)
        
        
        //        if let font = UIFont(name: buttonFont, size: 14.0) {
        //            self.titleLabel?.font = font
        //        } else {
        //            self.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 14.0)
        //        }
        
        if isAppColor
        {
            //self.backgroundColor = AppDelegate.shared().APP_COLOR
        }
        
        self.setNeedsLayout()
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + ButtonPadding, height: size.height)
    }
    
    func animateTouchUpInside(completion: @escaping () -> Void) {
        isUserInteractionEnabled = false
        layer.masksToBounds = true
        
        let fillLayer = CALayer()
        fillLayer.backgroundColor = filledColorCode.cgColor
        fillLayer.frame = layer.bounds
        layer.insertSublayer(fillLayer, at: 0)
        
        let center = CGPoint(x: fillLayer.bounds.midX, y: fillLayer.bounds.midY)
        let radius: CGFloat = max(frame.width / 2 , frame.height / 2)
        
        let circularAnimation = CircularRevealAnimator(layer: fillLayer, center: center, startRadius: 0, endRadius: radius)
        circularAnimation.duration = 0.2
        circularAnimation.completion = {
            fillLayer.opacity = 0
            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.fromValue = 1
            opacityAnimation.toValue = 0
            opacityAnimation.duration = 0.2
            opacityAnimation.delegate = AnimationDelegate {
                fillLayer.removeFromSuperlayer()
                self.isUserInteractionEnabled = true
                completion()
            }
            fillLayer.add(opacityAnimation, forKey: "opacity")
        }
        circularAnimation.start()
    }
}
