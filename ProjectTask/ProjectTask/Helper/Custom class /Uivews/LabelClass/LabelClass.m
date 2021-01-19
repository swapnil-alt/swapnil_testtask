//
//  LabelClass.m
//  IBDesignables
//
//  Created by MilanPanchal on 17/05/15.
//  Copyright (c) 2015 Pantech. All rights reserved.
//

#import "LabelClass.h"

@interface LabelClass ()

@property (nonatomic) IBInspectable UIColor *backgroundColorCode;
@property (nonatomic) IBInspectable UIColor *borderColorCode;
@property (nonatomic) IBInspectable NSInteger borderWidth;
@property (nonatomic) IBInspectable NSInteger cornerRadius;
@property (nonatomic) IBInspectable NSInteger lineHeight;

//@property CGFloat left;
//@property CGFloat right;
//@property CGFloat top;
//@property CGFloat buttom;
@end

@implementation LabelClass

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customInit];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [self customInit];
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
    [self setNeedsDisplay];
}


- (void)prepareForInterfaceBuilder {
    
    [self customInit];
}

- (void)customInit {
    self.backgroundColor = _backgroundColorCode;
    self.borderWidth    = _borderWidth;
    self.layer.cornerRadius = _cornerRadius;
    self.layer.borderColor = (__bridge CGColorRef _Nullable)(_borderColorCode);

}

@end
/*
 
 @IBDesignable class LabelClass: UILabel {
 
//
// padding left :
@IBInspectable var paddingLeft: CGFloat = 0.0 {
    didSet {
        // setPadding(top: paddingTop, left: paddingLeft, bottom: paddingButtom, right: paddingRight)        }
        self.left = paddingLeft
    }
}

// padding left :
@IBInspectable var paddingRight: CGFloat = 0.0 {
    didSet {
        // setPadding(top: paddingTop, left: paddingLeft, bottom: paddingButtom, right: paddingRight)        }
        self.right = paddingRight
        
    }
}


// padding left :
@IBInspectable var paddingTop: CGFloat = 0.0 {
    didSet {
        //  setPadding(top: paddingTop, left: paddingLeft, bottom: paddingButtom, right: paddingRight)        }
        self.top = paddingTop
        
    }
}


// padding left :
@IBInspectable var paddingButtom: CGFloat = 0.0 {
    didSet {
        self.buttom = paddingButtom
        //setPadding(top: paddingTop, left: paddingLeft, bottom: paddingButtom, right: paddingRight)
    }
}


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
    self.setNeedsLayout()
    self.setNeedsDisplay()
}
@IBInspectable var topInset: CGFloat = 5.0
@IBInspectable var bottomInset: CGFloat = 5.0
@IBInspectable var leftInset: CGFloat = 5.0
@IBInspectable var rightInset: CGFloat = 5.0

override func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets(top: top, left: left, bottom: buttom , right: right)
    super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
}

override var intrinsicContentSize: CGSize {
    get {
        var contentSize = super.intrinsicContentSize
        contentSize.height += top + buttom
        contentSize.width += left + right
        return contentSize
    }
}
}

 */
