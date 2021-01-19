//
//  TextFieldClass.m
//  WasalniDriver
//
//  Created by WVMAC1 on 09/02/19.
//  Copyright © 2019 WVMAC1. All rights reserved.
//

#import "TextFieldClass.h"
#import <objc/runtime.h>
#import "UILabel+Boldify.h"

@interface TextFieldClass ()
{
    UIView *bottomLineView;
    UILabel *errorMessage;
}


@end

@implementation TextFieldClass

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        if (self.placeholderColor == nil)
        {
            self.placeholderColor = [UIColor clearColor];
        }
        
        
        self.imgLeft = [UIImage imageNamed:@"down"];
        self.imgRight = [UIImage imageNamed:@"down"];
        
        [self customInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.borderWidth = 0;
        self.allowedCharacters = @"";
        self.cornerRadius  = 0;
        self.underLine = 0;
        self.leftPadding = 0;
        self.rightPadding = 0;
        self.textMaxLimit = 9999999999999999;
        self.isRestrictedCharacter = NO;
        [self customInit];
        
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self customInit];
}

- (void)setNeedsLayout
{
    [super setNeedsLayout];
    [self setNeedsDisplay];
}
- (void)prepareForInterfaceBuilder
{
    [self customInit];
    NSLog(@"prepareForInterfaceBuilder --->");
}

- (void)customInit
{
    
    self.layer.borderWidth = self.borderWidth;
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.borderColor = self.borderColor.CGColor;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>= 13.0)
    {
        Ivar ivar =  class_getInstanceVariable([UITextField class], "_placeholderLabel");
        UILabel *placeholderLabel = object_getIvar(self, ivar);

        placeholderLabel.textColor = self.placeholderColor;
    }
    else
    {
        [self setValue:self.placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    }

    if (self.cornerRadius > 0)
    {
        self.layer.masksToBounds = YES;
    }
    if (self.leftPadding != 0.0)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.leftPadding, self.frame.size.height)];
        
        if (self.imgLeft != nil)
        {
            view =  [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.leftPadding, self.frame.size.height)];
            UIImageView *img = [[UIImageView alloc] initWithImage:self.imgLeft];
            img.contentMode = UIViewContentModeScaleAspectFit;
            img.frame = CGRectMake(0, 0, self.leftPadding/2, self.frame.size.height);
            
            [view addSubview:img];
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.leftPadding, self.frame.size.height)];
            [view addSubview:btn];
            btn.backgroundColor = [UIColor clearColor];
            
            [btn addTarget:self action:@selector(userSelected:) forControlEvents:UIControlEventTouchUpInside];
        }
        view.backgroundColor = self.leftPaddingColor;
        self.leftView = view;
        [self setLeftViewMode:UITextFieldViewModeAlways];
    }
    
    if (self.rightPadding != 0.0)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.rightPadding, self.frame.size.height)];
        
        if (self.imgRight != nil)
        {
            view =  [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.rightPadding, self.frame.size.height)];
            UIImageView *img = [[UIImageView alloc] initWithImage:self.imgRight];
            img.contentMode = UIViewContentModeScaleAspectFit;
            img.frame = CGRectMake(self.rightPadding/4, (self.rightPadding-30)/2, 30, 30);
            
            [view addSubview:img];
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.rightPadding, self.frame.size.height)];
            [view addSubview:btn];
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:@selector(userSelected:) forControlEvents:UIControlEventTouchUpInside];
        }
        view.backgroundColor = self.rightPaddingColor;

        self.rightView = view;
        [self setRightViewMode:UITextFieldViewModeAlways];
    }
    
    if (self.underLine != 0)
    {
        NSLayoutConstraint *bottomLineViewHeight;
        bottomLineViewHeight.constant = self.underLine;
        if (bottomLineView.superview != nil)
        {
            return;
        }
        bottomLineView = [UIView new];
        bottomLineView.backgroundColor = self.borderColor;
        bottomLineView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:bottomLineView];
        
        NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:bottomLineView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
        
        NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:bottomLineView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
        
        NSLayoutConstraint * bottomConstraint = [NSLayoutConstraint constraintWithItem:bottomLineView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        
        bottomLineViewHeight = [NSLayoutConstraint constraintWithItem:bottomLineView
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute: NSLayoutAttributeNotAnAttribute
                                                           multiplier:1
                                                             constant:1];
        
        [self addConstraints:@[leadingConstraint,trailingConstraint,bottomConstraint]];
        [bottomLineView addConstraint:bottomLineViewHeight];
    }
    
    self.delegate = self;

    if (self.selectedBorderColor == nil)
    {
        self.selectedBorderColor = self.borderColor;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    if (self.isRestrictedCharacter)
    {
        NSString *ACCEPTABLE_CHARACTERS = self.allowedCharacters;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];

        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        if (_textMaxLimit == 9999999999999999)
        {
            return [string isEqualToString:filtered];
        }

        return [string isEqualToString:filtered] && newLength <= _textMaxLimit;
    }
    
    return  newLength <= _textMaxLimit;

     return true;
   
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
//    bottomLineView.backgroundColor = self.borderColor;
//
//    [UIView animateWithDuration:1.0 animations:^{
//        self->bottomLineView.backgroundColor = self.selectedBorderColor;
//    } completion:NULL];
    [errorMessage removeFromSuperview];
    //self.delegate = nil;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
   bottomLineView.backgroundColor = self.selectedBorderColor;

    [UIView animateWithDuration:1.0 animations:^{
        self->bottomLineView.backgroundColor = self.borderColor;
    } completion:NULL];
}
-(void)showErrorMessage
{
    bottomLineView.backgroundColor = self.borderColor;

     [UIView animateWithDuration:1.0 animations:^{
         self->bottomLineView.backgroundColor = self.selectedBorderColor;
     } completion:NULL];
    
    [self setupErrorMessage];
}
-(void)setupErrorMessage
{
    errorMessage = [[UILabel alloc]init];
    //    errorMessage.frame = CGRectMake(0, self.frame.size.height+10 + self.frame.origin.y, self.frame.size.width, 20);
    errorMessage.translatesAutoresizingMaskIntoConstraints = false;
    errorMessage.text = self.errorMessage;
    
    errorMessage.textAlignment = NSTextAlignmentRight;
    errorMessage.textColor = [UIColor redColor];
    [errorMessage colorSubstring:@"important" color:[UIColor colorWithRed:0.1/255 green:0.08/255 blue:0.11/255 alpha:1.0] isUnderLine:false];
    errorMessage.font = [UIFont fontWithName:@"GothamPro-Bold" size:11];
    errorMessage.hidden = NO;
//    errorMessage.backgroundColor = [UIColor blueColor];
    [self addSubview:errorMessage];
    
    
    //Trailing
    NSLayoutConstraint *trailing =[NSLayoutConstraint
                                   constraintWithItem:errorMessage
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self
                                   attribute:NSLayoutAttributeTrailing
                                   multiplier:1.0f
                                   constant:0.f];
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:errorMessage
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:0.f];
    NSLayoutConstraint *top = [NSLayoutConstraint
                                   constraintWithItem:errorMessage
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self
                                   attribute:NSLayoutAttributeTop
                                   multiplier:1.0f
                               constant:self.frame.size.height+5];

    //Height to be fixed for SubView same as AdHeight
    NSLayoutConstraint *height = [NSLayoutConstraint
                                  constraintWithItem:errorMessage
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                  multiplier:0
                                  constant:20];
    
    
    //Add constraints to the Parent
    [self addConstraint:trailing];
        [self addConstraint:top];
    [self addConstraint:leading];
    
    //Add height constraint to the subview, as subview owns it.
    [errorMessage addConstraint:height];
    
    
}
-(void)userSelected:(id)sender
{
    // please impliment this delegate method in your class to featch responce of left or right view click
    
    NSLog(@"call method");
    [self becomeFirstResponder];
}

/*
 func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
 PickerView.instance.show(arr: bizCat, key: "title") { (dict) in
 self.textfield.text = dict.object(forKey: "title") as? String
 }
 return false
 }
 */

@end
/*
 leftImage: UIImage
 rightImage: UIImage
 leftPadding: CGFloat
 rightPadding: CGFloat
 
 
 // Provides left padding for images: -------------
 override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
 var textRect = super.leftViewRect(forBounds: bounds)
 textRect.origin.x += leftPadding
 return textRect
 }
 
 func updateView() {
 if let image = leftImage {
 leftViewMode = UITextFieldViewMode.always
 let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
 imageView.contentMode = .scaleAspectFit
 imageView.image = image
 // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
 imageView.tintColor = leftImgcolor
 leftView = imageView
 } else {
 leftViewMode = UITextFieldViewMode.never
 leftView = nil
 }
 
 // Placeholder text color
 attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: leftImgcolor])
 }
 
 // Provides right padding for images: -------------
 override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
 var textRect = super.rightViewRect(forBounds: bounds)
 textRect.origin.x += rightPadding
 return textRect
 }
 
 func updateViewRight() {
 if let image = rightImage {
 rightViewMode = UITextFieldViewMode.always
 let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
 imageView.contentMode = .scaleAspectFit
 imageView.image = image
 // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
 imageView.tintColor = rightImgcolor
 rightView = imageView
 } else {
 rightViewMode = UITextFieldViewMode.never
 rightView = nil
 }
 
 // Placeholder text color
 attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: rightImgcolor])
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
 self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
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
 
 override func draw(_ rect: CGRect) {
 super.draw(rect)
 
 }
 */
