//
//  AlertViewS.swift
//  DemeAlertView
//
//  Created by wvmac3 on 10/09/18.
//  Copyright © 2018 webvillee. All rights reserved.
//

import UIKit

class AlertViewS: UIView {
    
    // enum :
    enum AlignmentType {
        case Horizontal
        case Vertical
    }

    //=====================================
    //MARK: Outlats :
    //=====================================
    var arr = NSArray();
    var AlignmentType : AlignmentType!
    
    //=====================================
    //MARK: variables :
    //=====================================
    var onCompletion : ((String)-> Void)!
    var alertUIView : UIView!
    var  stackView : UIStackView!
    var scrollView : UIScrollView!
    let gradientLayer = CAGradientLayer()
    var gradientBtnView = UIView.init()
    var btn = [UIButton]()

    //=====================================
    //MARK: Project Flow  :
    //=====================================
    override func awakeFromNib() {

    }
    
    // single color : set
    class func ShowAlertTitle(AlertTitle: String,Message : String, ThemeColor : [UIColor], BtnAlignmentType : AlignmentType, ButtonOfArrayInString : NSArray, compblock: @escaping (String)-> Void){
       
          let alertObj = AlertViewS()
        alertObj.onCompletion = compblock;
        alertObj.arr = ButtonOfArrayInString;
    
        alertObj.displayAlert(AlertTitle: AlertTitle , Message: Message, ThemeColor: ThemeColor , BtnAlignmentType: BtnAlignmentType, AtributeMsg : NSMutableAttributedString.init())
    }
    
    // single color : set
    class func ShowAlertTitleWithAtributeText(AlertTitle: String,AtributeMsg : NSMutableAttributedString, ThemeColor : [UIColor], BtnAlignmentType : AlignmentType, ButtonOfArrayInString : NSArray, compblock: @escaping (String)-> Void){
        
        let alertObj = AlertViewS()
        alertObj.onCompletion = compblock;
        alertObj.arr = ButtonOfArrayInString;
        
        alertObj.displayAlert(AlertTitle: AlertTitle , Message: "", ThemeColor: ThemeColor , BtnAlignmentType: BtnAlignmentType, AtributeMsg : AtributeMsg)
    }
    

    func displayAlert(AlertTitle : String, Message : String, ThemeColor : [UIColor] , BtnAlignmentType :AlignmentType,AtributeMsg : NSMutableAttributedString){
        
        self.AlignmentType = BtnAlignmentType
        
//        if arr.count == 1 {
//            self.AlignmentType = AlertViewS.AlignmentType.Vertical
//        }
        
        //================ Root view :
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5);
        
        
        //================= AlertUIView :
        alertUIView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20 , height: 20))
        alertUIView.backgroundColor = UIColor.white
        alertUIView.center = self.center
        alertUIView.layer.cornerRadius = 5
        alertUIView.clipsToBounds = true
        
        scrollView = UIScrollView.init()
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.width - 20 , height: 10)
        scrollView.backgroundColor = UIColor.clear
        
        
        //================= Alert title :
        let  titleUILabel = UILabel.init(frame: CGRect(x: 10, y: 20, width: UIScreen.main.bounds.width - 40, height: 20))
        titleUILabel.text = AlertTitle
    //    titleUILabel.font = UIFont(name: "Helvetica Neue", size: 14)!
        titleUILabel.textAlignment = .center
        titleUILabel.numberOfLines = 0
        titleUILabel.frame.size.height =  getLabelHeight(titleUILabel)
        scrollView.addSubview(titleUILabel)
        
        let viewLine = UIView.init(frame: CGRect(x: 0, y:  20 + titleUILabel.frame.size.height + 10 , width:  UIScreen.main.bounds.width - 20 , height: 1))
        viewLine.backgroundColor = #colorLiteral(red: 0.9691326022, green: 0.9732500911, blue: 0.976041615, alpha: 1)
        scrollView.addSubview(viewLine)
        
        var topHeight : CGFloat = 0.0
        if AlertTitle == "" {
            titleUILabel.isHidden = true
            viewLine.isHidden = true
            titleUILabel.frame.size.height = 0
            topHeight = 22.0
            
        }else{
            titleUILabel.isHidden = false
            viewLine.isHidden = false
             topHeight = 40.0
        }
    
        
        //================= Message title :
        let messageUILabel = UILabel.init(frame: CGRect(x: 10, y: titleUILabel.frame.size.height + topHeight, width: UIScreen.main.bounds.width - 40, height: 20))
       
        if Message == ""{
            messageUILabel.attributedText = AtributeMsg
        }else{
          messageUILabel.text = Message
        }
        
        messageUILabel.textColor = #colorLiteral(red: 0.549356997, green: 0.5535966754, blue: 0.5570660233, alpha: 1)
        //titleUILabel.font = UIFont(name: "Helvetica Neue", size: 14)!
        messageUILabel.textAlignment = .center
        messageUILabel.numberOfLines = 0
        
        if Message == "" {
            let rect: CGRect = AtributeMsg.boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 40, height: 10000), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
            messageUILabel.frame.size.height = rect.height + 35
        }else{
               messageUILabel.frame.size.height = getLabelHeight(messageUILabel)
        }
        
       
        scrollView.addSubview(messageUILabel);
        
        
        // Root Scroll view set frame :
        //==== : total completeHeightCount
        let completeHeightCount   = 20  + (self.AlignmentType == AlertViewS.AlignmentType.Horizontal ? ( arr.count % 3 == 0  ? (arr.count/3) * 40 : ((arr.count/3) + 1) * 40): arr.count * 40);
        
        let calclulatedRemainHeight =  (UIScreen.main.bounds.size.height - 50 - (titleUILabel.frame.size.height + messageUILabel.frame.size.height + 60))
        
        let totalHeight: CGFloat = CGFloat(completeHeightCount) > UIScreen.main.bounds.size.height ?  calclulatedRemainHeight : (CGFloat(completeHeightCount - 20))
        
        
        scrollView.frame.size.height = (titleUILabel.frame.size.height  + messageUILabel.frame.size.height + 60) + totalHeight
        scrollView.isScrollEnabled = true
        
        scrollView.contentSize = CGSize(width: (UIScreen.main.bounds.size.width - 20), height: (titleUILabel.frame.size.height + messageUILabel.frame.size.height + 60 ) + CGFloat(completeHeightCount - 20))
        
        // ================= Array of button :
        let  rootStackView = UIStackView.init(frame: CGRect(x: 0, y: titleUILabel.frame.size.height + messageUILabel.frame.size.height + 60, width: UIScreen.main.bounds.size.width - 20 , height: CGFloat(completeHeightCount - 20) ));
        
        rootStackView.spacing = 10
        rootStackView.distribution = .fillEqually
        rootStackView.axis = .vertical
        rootStackView.dropShadow()
        rootStackView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        for i in 0..<arr.count {
            if self.AlignmentType == AlertViewS.AlignmentType.Horizontal  { // horizontal
                
                if i%3 == 0 {
                    self.stackView = UIStackView.init()
                    self.stackView.frame = CGRect(x:0, y: 30, width: UIScreen.main.bounds.size.width, height: 40)
                    stackView.spacing = 1
                    stackView.distribution = .fillEqually
                    stackView.axis = .horizontal
                    rootStackView.addArrangedSubview(stackView)
                }
                
                let btn = UIButton.init()
               // btn.layer.cornerRadius = 5
                
                btn.setTitleColor(UIColor.white, for: .normal)
                btn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 14)!
                
                btn.setTitle(arr[i] as? String, for: .normal)
                
                btn.tag = i
                btn.addTarget(self, action: #selector(AlertViewS.actionStackButton(sender:)), for: .touchUpInside)
                
                stackView.addArrangedSubview(btn)
                
                if  i < ThemeColor.count{
                    btn.backgroundColor = ThemeColor[i]
                    
                    if ThemeColor[i] == UIColor.white {
                        btn.setTitleColor(UIColor.black, for: .normal)
                        btn.layer.borderColor = UIColor.black.cgColor
                        btn.layer.borderWidth = 1
                    }else if ThemeColor[i] == UIColor.black {
                        btn.layer.borderColor = UIColor.white.cgColor
                        btn.layer.borderWidth = 1
                        btn.setTitleColor(UIColor.white, for: .normal)
                    }else{
                        btn.setTitleColor(UIColor.white, for: .normal)
                    }
                    
                }else{
                    btn.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1725490196, alpha: 1)
                }
                
            }else{ //============ Vertically manage :
                
                let btn = UIButton.init()
                btn.layer.cornerRadius = 5
                btn.setTitleColor(UIColor.white, for: .normal)
                btn.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1725490196, alpha: 1)
                
                btn.setTitle(arr[i] as? String, for: .normal)
                btn.tag = i
                rootStackView.addArrangedSubview(btn)
                btn.addTarget(self, action: #selector(AlertViewS.actionStackButton(sender:)), for: .touchUpInside)
                
                if  i < ThemeColor.count{
                    btn.backgroundColor = ThemeColor[i]
                    if ThemeColor[i] == UIColor.white {
                        btn.setTitleColor(UIColor.black, for: .normal)
                        btn.layer.borderColor = UIColor.black.cgColor
                        btn.layer.borderWidth = 1
                        
                    }else if ThemeColor[i] == UIColor.black {
                        btn.setTitleColor(UIColor.white, for: .normal)
                        btn.layer.borderColor = UIColor.white.cgColor
                        btn.layer.borderWidth = 1
                    }else{
                        btn.setTitleColor(UIColor.white, for: .normal)
                    }
                }else{
                    btn.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1725490196, alpha: 1)
                }
            }
        }
        
        //=================== Frame of alertView
        alertUIView.frame.size.height = scrollView.frame.size.height
        alertUIView.center = self.center
        scrollView.addSubview(rootStackView)
        
        alertUIView.addSubview(scrollView)
        self.addSubview(alertUIView)
        
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(self)
        
        
        //============== Show with animation
        alertUIView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        alertUIView.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.alertUIView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.alertUIView.alpha = 1
        }) { (true) in
            //   print("Date picker isplay: Done")
        }
    }
    
    
    //===================================================
    class func ShowAlertTitleWithImage(AlertImage : UIImage , AlertTitle: String,Message : String, ThemeColor : [UIColor], BtnAlignmentType : AlignmentType, ButtonOfArrayInString : NSArray, compblock: @escaping (String)-> Void){
        
        let alertObj = AlertViewS()
        alertObj.onCompletion = compblock;
        alertObj.arr = ButtonOfArrayInString;
        
        alertObj.displayAlertWithImage(AlertImg: AlertImage, AlertTitle: AlertTitle , Message: Message, ThemeColor: ThemeColor , BtnAlignmentType: BtnAlignmentType)
    }
    

    
    func displayAlertWithImage(AlertImg :UIImage,AlertTitle : String, Message : String, ThemeColor : [UIColor] , BtnAlignmentType :AlignmentType){
        
        self.AlignmentType = BtnAlignmentType
        
        //        if arr.count == 1 {
        //            self.AlignmentType = AlertViewS.AlignmentType.Vertical
        //        }
        
        //================ Root view :
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5);
        

        //================= AlertUIView :
        alertUIView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20 , height: 20))
        alertUIView.backgroundColor = UIColor.white
        alertUIView.center = self.center
        alertUIView.layer.cornerRadius = 5
        alertUIView.clipsToBounds = true
        
        scrollView = UIScrollView.init()
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.width - 20 , height: 10)
        scrollView.backgroundColor = UIColor.clear
        
        
        // alertImage :
        
        let imgLogo = UIImageView.init(frame: CGRect(x: (UIScreen.main.bounds.width - 50)/2, y: 15, width: 30 , height: 30))
        imgLogo.image = AlertImg
        imgLogo.contentMode = .scaleAspectFit
        //imgLogo.
          scrollView.addSubview(imgLogo)
        
    
        
        
        
        //================= Alert title :
        let  titleUILabel = UILabel.init(frame: CGRect(x: 10, y: 60, width: UIScreen.main.bounds.width - 40, height: 20))
        titleUILabel.text = AlertTitle
        //    titleUILabel.font = UIFont(name: "Helvetica Neue", size: 14)!
        titleUILabel.textAlignment = .center
        titleUILabel.numberOfLines = 0
        titleUILabel.frame.size.height =  getLabelHeight(titleUILabel)
        scrollView.addSubview(titleUILabel)
        
        let viewLine = UIView.init(frame: CGRect(x: 0, y:  20 + titleUILabel.frame.size.height + 10 , width:  UIScreen.main.bounds.width - 20 , height: 1))
        viewLine.backgroundColor = #colorLiteral(red: 0.9691326022, green: 0.9732500911, blue: 0.976041615, alpha: 1)
        scrollView.addSubview(viewLine)
        
        var topHeight : CGFloat = 0.0
        if AlertTitle == "" {
            titleUILabel.isHidden = true
            viewLine.isHidden = true
            titleUILabel.frame.size.height = 0
            topHeight = 22.0
            
        }else{
            titleUILabel.isHidden = false
            viewLine.isHidden = true
            topHeight = 60 + 15
        }
        
        
        //================= Message title :
        let messageUILabel = UILabel.init(frame: CGRect(x: 10, y: titleUILabel.frame.size.height + topHeight, width: UIScreen.main.bounds.width - 40, height: 20))
        messageUILabel.text = Message
        messageUILabel.textColor = #colorLiteral(red: 0.549356997, green: 0.5535966754, blue: 0.5570660233, alpha: 1)
        titleUILabel.font = UIFont(name: "Helvetica Neue", size: 14)!
        messageUILabel.textAlignment = .center
        messageUILabel.numberOfLines = 0
        messageUILabel.frame.size.height = getLabelHeight(messageUILabel)
        
        
      
        
        scrollView.addSubview(messageUILabel);
        
        
        // Root Scroll view set frame :
        //==== : total completeHeightCount
        let completeHeightCount   = 20  + (self.AlignmentType == AlertViewS.AlignmentType.Horizontal ? ( arr.count % 3 == 0  ? (arr.count/3) * 40 : ((arr.count/3) + 1) * 40): arr.count * 40);
        
        let calclulatedRemainHeight =  (UIScreen.main.bounds.size.height - 50 - (titleUILabel.frame.size.height + messageUILabel.frame.size.height + 60))
        
        let totalHeight: CGFloat = CGFloat(completeHeightCount) > UIScreen.main.bounds.size.height ?  calclulatedRemainHeight : (CGFloat(completeHeightCount - 20))
        
        
        scrollView.frame.size.height = (titleUILabel.frame.size.height  + messageUILabel.frame.size.height + 60 + 40) + totalHeight
        scrollView.isScrollEnabled = true
        
        scrollView.contentSize = CGSize(width: (UIScreen.main.bounds.size.width - 20), height: (titleUILabel.frame.size.height + messageUILabel.frame.size.height + 60 + 40) + CGFloat(completeHeightCount - 20))
        
        // ================= Array of button :
        let  rootStackView = UIStackView.init(frame: CGRect(x: 0, y: titleUILabel.frame.size.height + messageUILabel.frame.size.height + 60 + 40, width: UIScreen.main.bounds.size.width - 20 , height: CGFloat(completeHeightCount - 20) ));
        
        rootStackView.spacing = 10
        rootStackView.distribution = .fillEqually
        rootStackView.axis = .vertical
        rootStackView.dropShadow()
        rootStackView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        for i in 0..<arr.count {
            if self.AlignmentType == AlertViewS.AlignmentType.Horizontal  { // horizontal
                
                if i%3 == 0 {
                    self.stackView = UIStackView.init()
                    self.stackView.frame = CGRect(x:0, y: 30, width: UIScreen.main.bounds.size.width, height: 40)
                    stackView.spacing = 1
                    stackView.distribution = .fillEqually
                    stackView.axis = .horizontal
                    rootStackView.addArrangedSubview(stackView)
                }
                
                let btn = UIButton.init()
                // btn.layer.cornerRadius = 5
                
                btn.setTitleColor(UIColor.white, for: .normal)
                btn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 14)!
                
                btn.setTitle(arr[i] as? String, for: .normal)
                
                btn.tag = i
                btn.addTarget(self, action: #selector(AlertViewS.actionStackButton(sender:)), for: .touchUpInside)
                
                stackView.addArrangedSubview(btn)
                
                if  i < ThemeColor.count{
                    btn.backgroundColor = ThemeColor[i]
                    
                    if ThemeColor[i] == UIColor.white {
                        btn.setTitleColor(UIColor.black, for: .normal)
                        btn.layer.borderColor = UIColor.black.cgColor
                        btn.layer.borderWidth = 1
                    }else if ThemeColor[i] == UIColor.black {
                        btn.layer.borderColor = UIColor.white.cgColor
                        btn.layer.borderWidth = 1
                        btn.setTitleColor(UIColor.white, for: .normal)
                    }else{
                        btn.setTitleColor(UIColor.white, for: .normal)
                    }
                    
                }else{
                    btn.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
                }
                
            }else{ //============ Vertically manage :
                
                let btn = UIButton.init()
                btn.layer.cornerRadius = 5
                btn.setTitleColor(UIColor.white, for: .normal)
                btn.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
                
                btn.setTitle(arr[i] as? String, for: .normal)
                btn.tag = i
                rootStackView.addArrangedSubview(btn)
                btn.addTarget(self, action: #selector(AlertViewS.actionStackButton(sender:)), for: .touchUpInside)
                
                if  i < ThemeColor.count{
                    btn.backgroundColor = ThemeColor[i]
                    if ThemeColor[i] == UIColor.white {
                        btn.setTitleColor(UIColor.black, for: .normal)
                        btn.layer.borderColor = UIColor.black.cgColor
                        btn.layer.borderWidth = 1
                        
                    }else if ThemeColor[i] == UIColor.black {
                        btn.setTitleColor(UIColor.white, for: .normal)
                        btn.layer.borderColor = UIColor.white.cgColor
                        btn.layer.borderWidth = 1
                    }else{
                        btn.setTitleColor(UIColor.white, for: .normal)
                    }
                }else{
                    btn.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
                }
            }
        }
        
        //=================== Frame of alertView
        alertUIView.frame.size.height = scrollView.frame.size.height
        alertUIView.center = self.center
        scrollView.addSubview(rootStackView)
        
        alertUIView.addSubview(scrollView)
        self.addSubview(alertUIView)
        
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(self)
        
        
        //============== Show with animation
        alertUIView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        alertUIView.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.alertUIView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.alertUIView.alpha = 1
        }) { (true) in
            //   print("Date picker isplay: Done")
        }
    }
    
    
    
    
    
    //=================================================================================================
    
    // gradient color set :
   class func ShowAlertTitleWithGradient(AlertTitle: String,Message : String, ThemeColor : [(UIColor,UIColor)], BtnAlignmentType : AlignmentType, ButtonOfArrayInString : NSArray, compblock: @escaping (String)-> Void){
        
        let alertObj = AlertViewS()
        alertObj.onCompletion = compblock;
        alertObj.arr = ButtonOfArrayInString;
        
        alertObj.displayAlertWithGradient(AlertTitle: AlertTitle , Message: Message, ThemeColor: ThemeColor , BtnAlignmentType: BtnAlignmentType)
    }
    
    
    // with gradient color set :
    func displayAlertWithGradient(AlertTitle : String, Message : String, ThemeColor : [(UIColor, UIColor)] , BtnAlignmentType :AlignmentType ){
        
            
            self.AlignmentType = BtnAlignmentType
            
            if self.arr.count == 1 {
                self.AlignmentType = AlertViewS.AlignmentType.Vertical
            }
        
            //================ Root view :
            self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.backgroundColor = UIColor.black.withAlphaComponent(0.5);
            
            
            //================= AlertUIView :
            self.alertUIView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20 , height: 20))
            self.alertUIView.backgroundColor = UIColor.white
            self.alertUIView.center = self.center
            self.alertUIView.layer.cornerRadius = 20
            
            self.scrollView = UIScrollView.init()
            self.scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.width - 20 , height: 10)
            self.scrollView.backgroundColor = UIColor.clear
            
            //================= Alert title :
            let  titleUILabel = UILabel.init(frame: CGRect(x: 10, y: 20, width: UIScreen.main.bounds.width - 40, height: 20))
            titleUILabel.text = AlertTitle
            titleUILabel.textAlignment = .center
            titleUILabel.numberOfLines = 0
            titleUILabel.frame.size.height =  self.getLabelHeight(titleUILabel)
            self.scrollView.addSubview(titleUILabel)
            
            
            //================= Message title :
            let messageUILabel = UILabel.init(frame: CGRect(x: 10, y: titleUILabel.frame.size.height + 40, width: UIScreen.main.bounds.width - 40, height: 20))
            messageUILabel.text = Message
            messageUILabel.textAlignment = .center
            messageUILabel.numberOfLines = 0
            messageUILabel.frame.size.height = self.getLabelHeight(messageUILabel)
            self.scrollView.addSubview(messageUILabel);
        
   
            
            
            // Root Scroll view set frame :
            //==== : total completeHeightCount
            let completeHeightCount   = 20  + (self.AlignmentType == AlertViewS.AlignmentType.Horizontal ? ( self.arr.count % 3 == 0  ? (self.arr.count/3) * 40 : ((self.arr.count/3) + 1) * 40): self.arr.count * 40);
            
            let calclulatedRemainHeight =  (UIScreen.main.bounds.size.height - 50 - (titleUILabel.frame.size.height + messageUILabel.frame.size.height + 60))
            
            let totalHeight: CGFloat = CGFloat(completeHeightCount) > UIScreen.main.bounds.size.height ?  calclulatedRemainHeight : (CGFloat(completeHeightCount - 20))
            
            
            self.scrollView.frame.size.height = (titleUILabel.frame.size.height  + messageUILabel.frame.size.height + 60) + totalHeight
            self.scrollView.isScrollEnabled = true
            
            self.scrollView.contentSize = CGSize(width: (UIScreen.main.bounds.size.width - 20), height: (titleUILabel.frame.size.height + messageUILabel.frame.size.height + 60 ) + CGFloat(completeHeightCount - 20))
            
            // ================= Array of button :
            let  rootStackView = UIStackView.init(frame: CGRect(x: 10, y: titleUILabel.frame.size.height + messageUILabel.frame.size.height + 60, width: UIScreen.main.bounds.size.width - 40 , height: CGFloat(completeHeightCount - 20) ));
            
            rootStackView.spacing = 10
            rootStackView.distribution = .fillEqually
            rootStackView.axis = .vertical
        
            
            for i in 0..<self.arr.count {
                if self.AlignmentType == AlertViewS.AlignmentType.Horizontal  { // horizontal
                      self.btn.append(UIButton.init())
                    
                  //  self.autoresizingMask = UIView.AutoresizingMask(rawValue: UIViewAutoresizing.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
                    
                    if i%3 == 0 {
                        print("index : \(i)")
                        self.stackView = UIStackView.init()
                        self.stackView.frame = CGRect(x: 10, y: 30, width: UIScreen.main.bounds.size.width - 20, height: 40)
                        self.stackView.spacing = 10
                        self.stackView.distribution = .fillEqually
                        self.stackView.axis = .horizontal
                        rootStackView.addArrangedSubview(self.stackView)
                        
                    }
                    
                    self.gradientBtnView  = UIView.init()
                   // gradientBtnView.layer.cornerRadius = 15
                
                   // btn[i] = UIButton.init()
                  
                  
                  //  btn.layer.cornerRadius = 5
                    self.btn[i].backgroundColor = UIColor.clear
                    
                    self.btn[i].setTitleColor(UIColor.white, for: .normal)
                    
                    self.btn[i].setTitle(self.arr[i] as? String, for: .normal)
                    
                    self.btn[i].tag = i
                    self.btn[i].addTarget(self, action: #selector(AlertViewS.actionStackButton(sender:)), for: .touchUpInside)
                    
                    self.btn[i].frame =  self.gradientLayer.bounds// CGRect(x: 0, y: 0, width: 80, height: 40)
                  //  btn.center = gradientBtnView.center
                 
                    self.gradientBtnView.addSubview(self.btn[i])
                    self.stackView.addArrangedSubview(self.gradientBtnView)
                    
                    self.stackView.layoutIfNeeded()
                  //  print(stackView.arrangedSubviews[i].frame)
                   
                    
                    if  i < ThemeColor.count{

                        let topColor =   ThemeColor[i].0.cgColor  //UIColor(red: 220/255.0, green: 60/255.0, blue: 20/255.0, alpha: 1).cgColor
                        let bottomColor =  ThemeColor[i].1.cgColor//UIColor(red: 255/255.0, green: 255/255.0, blue: 102/255.0, alpha: 1).cgColor
                        let gradientColors = [topColor, bottomColor]
                        let gradientLocations: [NSNumber] = [0.0, 2.0]

                        self.gradientLayer.colors = gradientColors
                        self.gradientLayer.locations = gradientLocations
                        //Set startPoint and endPoint property also
                        self.gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
                        self.gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
                        self.gradientLayer.frame = self.gradientLayer.bounds
                        self.gradientLayer.cornerRadius = 20
                        self.gradientBtnView.layer.insertSublayer(self.gradientLayer, at: 0)
                    }else{
                          self.gradientBtnView.layer.cornerRadius = 20
                         self.gradientBtnView.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
                    }
                    
                }else{ //============ Vertically managed :
                    
                  //  self.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
                    
                    let gradientBtnView  = UIView.init(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.size.width - 60, height: 40))
                    gradientBtnView.layer.cornerRadius = 20
                    
                    let btn = UIButton.init()
                 //   btn.layer.cornerRadius = 5
                    btn.setTitleColor(UIColor.white, for: .normal)
                   // btn.backgroundColor = UIColor.darkGray
                    btn.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
                    btn.layer.cornerRadius = 20
                    btn.setTitle(self.arr[i] as? String, for: .normal)
                    btn.tag = i
                    
                    btn.frame = gradientBtnView.frame
                    
                    gradientBtnView.addSubview(btn)
                    rootStackView.addArrangedSubview(gradientBtnView)
                    btn.addTarget(self, action: #selector(AlertViewS.actionStackButton(sender:)), for: .touchUpInside)
                 
                    
                    if  i < ThemeColor.count{
                        
                       // gradientBtnView.layer.insertSublayer(gradientFrom(firstcolor:  ThemeColor[i].0 , secandColor:  ThemeColor[i].1), at: 0)
                    
                        let topColor =   ThemeColor[i].0.cgColor  //UIColor(red: 220/255.0, green: 60/255.0, blue: 20/255.0, alpha: 1).cgColor
                        let bottomColor =  ThemeColor[i].1.cgColor//UIColor(red: 255/255.0, green: 255/255.0, blue: 102/255.0, alpha: 1).cgColor
                        let gradientColors = [topColor, bottomColor]
                        let gradientLocations: [NSNumber] = [0.0, 2.0]
                        
                        self.gradientLayer.colors = gradientColors
                        self.gradientLayer.locations = gradientLocations
                        //Set startPoint and endPoint property also
                        self.gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
                        self.gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
                        self.gradientLayer.frame = CGRect(x: 10, y: 0, width: UIScreen.main.bounds.size.width - 60, height: 40)
                        self.gradientLayer.cornerRadius = 20
                        self.gradientBtnView.layer.insertSublayer(self.gradientLayer, at: 0)

                    }else{
                         gradientBtnView.layer.cornerRadius = 20
                        gradientBtnView.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
                    }
                }
            }
            
            //=================== Frame of alertView
            self.alertUIView.frame.size.height = self.scrollView.frame.size.height + 10
            self.alertUIView.center = self.center
            self.scrollView.addSubview(rootStackView)
      
            
            self.alertUIView.addSubview(self.scrollView)
            self.addSubview(self.alertUIView)
            
            UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(self)
            
            
            //============== Show with animation
            self.alertUIView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.alertUIView.alpha = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.alertUIView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.alertUIView.alpha = 1
            }) { (true) in
                //   print("Date picker isplay: Done")
            }
   
        }


    // Remove functions :
    @objc func actionStackButton(sender : UIButton){
     // print("\(arr[sender.tag])")
        
        sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.3, animations: {
            sender.transform = CGAffineTransform(scaleX: 1,y: 1)
        }) { (result) in
            self.onCompletion("\(self.arr[sender.tag])")
            self.alertUIView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.alertUIView.alpha = 1
            UIView.animate(withDuration: 0.3, animations: {
                self.alertUIView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.alertUIView.alpha = 0
            }) { (true) in
                for i in self.subviews {
                    i.removeFromSuperview()
                }
                 self.removeFromSuperview()
            }
        }
  
    }
    
    func getLabelHeight(_ label: UILabel?) -> CGFloat {
        // DispatchQueue.main.async(execute: {
        let constraint = CGSize(width: label?.frame.size.width ?? 0.0, height: CGFloat.greatestFiniteMagnitude)
        var size: CGSize
        
        let context = NSStringDrawingContext()
        let boundingBox: CGSize? = label?.text?.boundingRect(with: constraint, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: label?.font as Any], context: context).size
        
        size = CGSize(width: ceil((boundingBox?.width)!), height: ceil((boundingBox?.height)!))
        
        return size.height
        //})
    }
}

// gradient  color  :
extension AlertViewS {
//    func gradientFrom(firstcolor : UIColor, secandColor  : UIColor )-> CAGradientLayer{
//        let topColor =   firstcolor.cgColor  //UIColor(red: 220/255.0, green: 60/255.0, blue: 20/255.0, alpha: 1).cgColor
//        let bottomColor =  secandColor.cgColor//UIColor(red: 255/255.0, green: 255/255.0, blue: 102/255.0, alpha: 1).cgColor
//        let gradientColors = [topColor, bottomColor]
//        let gradientLocations: [NSNumber] = [0.0, 2.0]
//
//        gradientLayer.colors = gradientColors
//        gradientLayer.locations = gradientLocations
//        //Set startPoint and endPoint property also
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
//        gradientLayer.frame = gradientBtnView.bounds
//        return gradientLayer
//    }
    
    override func layoutSubviews() {
      //  gradientLayer.frame = self.stackView.arrangedSubviews[1].frame
     
        if self.AlignmentType == AlertViewS.AlignmentType.Horizontal {
            print(" self.stackView.frame : \(self.stackView.arrangedSubviews[0].bounds)")
            print("gradientBtnView : self \(self.gradientBtnView.frame)")
        }
    
    }
    
    override func didAddSubview(_ subview: UIView) {
        

        if self.AlignmentType == AlertViewS.AlignmentType.Horizontal {
            print(" self.stackView.frame : \(self.stackView.arrangedSubviews[0].bounds)")
            print("gradientBtnView : \(self.gradientBtnView.frame)")
            self.gradientLayer.frame = self.stackView.arrangedSubviews[0].bounds
            
            for i in 0..<self.btn.count {
                self.btn[i].frame = self.stackView.arrangedSubviews[0].bounds
            }
        }else{
            for i in 0..<self.btn.count {
                self.btn[i].frame = self.stackView.arrangedSubviews[0].bounds
            }
        }
  
}
}
