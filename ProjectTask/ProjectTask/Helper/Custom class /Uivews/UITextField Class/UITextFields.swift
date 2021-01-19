//
//  WhiteColor_BlueBorder.swift
//  MyProject
//
//  Created by Sumit shaw on 7/2/17.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit

@IBDesignable class UITextFields: UITextField {
    
    // placeholder color
    var pColor : CGColor?
    //MARK: - Background color
    @IBInspectable var backgroundColorCode: UIColor = UIColor.clear {
        didSet {
            self.backgroundColor =  backgroundColorCode
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
    
    
    
    //Mark: - Corner radious
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    
    // Provides left padding for images: -------------
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var leftImgcolor: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = leftImgcolor
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: leftImgcolor])
    }
    
    
    // Provides right padding for images: -------------
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x += rightPadding
        return textRect
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateViewRight()
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0
    
    @IBInspectable var rightImgcolor: UIColor = UIColor.lightGray {
        didSet {
            updateViewRight()
        }
    }
    
    func updateViewRight() {
        if let image = rightImage {
            rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = rightImgcolor
            rightView = imageView
        } else {
            rightViewMode = UITextField.ViewMode.never
            rightView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: rightImgcolor])
    }
    
    
    // padding : -
    @IBInspectable var paddingLeft: CGFloat = 0
    @IBInspectable var paddingRight: CGFloat = 0
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y, width: bounds.size.width - paddingLeft - paddingRight, height: bounds.size.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
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
        self.backgroundColor = backgroundColorCode
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        
        // self.titleLabel?.font = UIFont(name: GlobalCustomFont.Robo_Font, size: tintSize)
        
        
        //        if let font = UIFont(name: buttonFont, size: 14.0) {
        //            self.titleLabel?.font = font
        //        } else {
        //            self.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 14.0)
        //        }
        
        self.setNeedsLayout()
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
}


