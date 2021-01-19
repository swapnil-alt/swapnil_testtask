//
//  UItextView.swift
//  BizzFinder
//
//  Created by Sumit5Exceptions on 29/07/17.
//  Copyright © 2017 5Exceptions. All rights reserved.
//

import UIKit

@IBDesignable class UItextView: UITextView {
    
    private let ButtonPadding: CGFloat = 50
    
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
    
    
    //MARK: - Text size
    //        @IBInspectable var tintSize: CGFloat = 0.0 {
    //            didSet {
    //            self.titleLabel!.font =  UIFont(name: GlobalCustomFont.Robo_Font, size: tintSize)
    //            }
    //        }
    
    
    
    
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
    
    
    
    // set padding left, right , top , bottom
    func setPadding(top : CGFloat , left : CGFloat , bottom : CGFloat , right : CGFloat){
        self.textContainerInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right);
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
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + ButtonPadding, height: size.height)
    }
    
    
    //////////////////////////////////////////////////////////////////////////
    private struct Constants {
        static let defaultiOSPlaceholderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0980392, alpha: 0.22)
    }
    public let placeholderLabel: UILabel = UILabel()
    
    private var placeholderLabelConstraints = [NSLayoutConstraint]()
    
    @IBInspectable open var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    @IBInspectable open var placeholderColor: UIColor = UItextView.Constants.defaultiOSPlaceholderColor {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    override open var font: UIFont! {
        didSet {
            if placeholderFont == nil {
                placeholderLabel.font = font
            }
        }
    }
    
    open var placeholderFont: UIFont? {
        didSet {
            let font = (placeholderFont != nil) ? placeholderFont : self.font
            placeholderLabel.font = font
        }
    }
    
    override open var textAlignment: NSTextAlignment {
        didSet {
            placeholderLabel.textAlignment = textAlignment
        }
    }
    
    override open var text: String! {
        didSet {
            textDidChange()
        }
    }
    
    override open var attributedText: NSAttributedString! {
        didSet {
            textDidChange()
        }
    }
    
    override open var textContainerInset: UIEdgeInsets {
        didSet {
            updateConstraintsForPlaceholderLabel()
        }
    }
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange),
                                               name: UITextView.textDidChangeNotification ,
                                               object: nil)
        
        placeholderLabel.font = font
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.textAlignment = textAlignment
        placeholderLabel.text = placeholder
        placeholderLabel.numberOfLines = 0
        placeholderLabel.backgroundColor = UIColor.clear
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
        updateConstraintsForPlaceholderLabel()
    }
    
    private func updateConstraintsForPlaceholderLabel() {
        var newConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(\(textContainerInset.left + textContainer.lineFragmentPadding))-[placeholder]",
            options: [],
            metrics: nil,
            views: ["placeholder": placeholderLabel])
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(\(textContainerInset.top))-[placeholder]",
            options: [],
            metrics: nil,
            views: ["placeholder": placeholderLabel])
        newConstraints.append(NSLayoutConstraint(
            item: placeholderLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 1.0,
            constant: -(textContainerInset.left + textContainerInset.right + textContainer.lineFragmentPadding * 2.0)
        ))
        removeConstraints(placeholderLabelConstraints)
        addConstraints(newConstraints)
        placeholderLabelConstraints = newConstraints
    }
    
    @objc private func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.preferredMaxLayoutWidth = textContainer.size.width - textContainer.lineFragmentPadding * 2.0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UITextView.textDidChangeNotification ,
                                                  object: nil)
    }
    

}
