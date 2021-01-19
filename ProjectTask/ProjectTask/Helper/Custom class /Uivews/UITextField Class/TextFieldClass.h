//
//  TextFieldClass.h
//  WasalniDriver
//
//  Created by WVMAC1 on 09/02/19.
//  Copyright © 2019 WVMAC1. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface TextFieldClass : UITextField<UITextFieldDelegate>

// @property (nonatomic) IBInspectable UIColor *backgroundColorCode;
@property (nonatomic) IBInspectable UIColor *placeholderColor;

@property (nonatomic) IBInspectable UIColor *rightPaddingColor;

@property (nonatomic) IBInspectable UIColor *leftPaddingColor;

@property (nonatomic) IBInspectable UIColor *borderColor;

@property (nonatomic) IBInspectable UIColor *selectedBorderColor;

@property (nonatomic) IBInspectable CGFloat borderWidth;

@property (nonatomic) IBInspectable NSInteger underLine;

@property (nonatomic) IBInspectable NSInteger cornerRadius;

//@property (nonatomic) IBInspectable NSInteger leftImage;
//@property (nonatomic) IBInspectable NSInteger rightImage;

@property (nonatomic) IBInspectable NSInteger leftPadding;
@property (nonatomic) IBInspectable NSInteger rightPadding;
@property (nonatomic) IBInspectable NSInteger textMaxLimit;


// @property (nonatomic) IBInspectable BOOL needLeftView;
@property (nonatomic) IBInspectable UIImage *imgLeft;
//
@property (nonatomic) IBInspectable BOOL isRestrictedCharacter;
@property (nonatomic) IBInspectable NSString *allowedCharacters;

@property (nonatomic) IBInspectable UIImage *imgRight;

//error message
@property (nonatomic) IBInspectable NSString *errorMessage;

@property (nonatomic) IBInspectable UIFont *errorMessageFont;





-(void)showErrorMessage;


@end
