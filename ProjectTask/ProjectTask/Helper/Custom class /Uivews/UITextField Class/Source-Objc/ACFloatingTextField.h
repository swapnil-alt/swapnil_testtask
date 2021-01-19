//
//  AppTextField.h
//  TFDemoApp
//
//  Created by Abhishek Chandani on 19/05/16.
//  Copyright © 2016 Abhishek. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface ACFloatingTextField : UITextField
{
    UIView *bottomLineView;
    BOOL showingError;
}

@property (nonatomic) IBInspectable UIColor *rightPaddingColor;

@property (nonatomic) IBInspectable UIColor *leftPaddingColor;

@property (nonatomic) IBInspectable UIColor *borderColor;

@property (nonatomic) IBInspectable CGFloat borderWidth;

@property (nonatomic) IBInspectable NSInteger underLine;

@property (nonatomic) IBInspectable NSInteger cornerRadius;

//@property (nonatomic) IBInspectable NSInteger leftImage;
//@property (nonatomic) IBInspectable NSInteger rightImage;

@property (nonatomic) IBInspectable NSInteger leftPadding;
@property (nonatomic) IBInspectable NSInteger rightPadding;

// @property (nonatomic) IBInspectable BOOL needLeftView;
@property (nonatomic) IBInspectable UIImage *imgLeft;
//
//@property (nonatomic) IBInspectable BOOL isRightView;
@property (nonatomic) IBInspectable UIImage *imgRight;


/*
 * Change the Bottom line color. Default is Black Color.
 */
@property (nonatomic,strong) IBInspectable UIColor *lineColor;
/*
 * Change the Placeholder text color. Default is Light Gray Color.
 */
@property (nonatomic,strong) IBInspectable UIColor *placeHolderColor;
/*
 * Change the Placeholder text color when selected. Default is [UIColor colorWithRed:19/256.0 green:141/256.0 blue:117/256.0 alpha:1.0].
 */
@property (nonatomic,strong) IBInspectable UIColor *selectedPlaceHolderColor;
/*
 * Change the bottom line color when selected. Default is [UIColor colorWithRed:19/256.0 green:141/256.0 blue:117/256.0 alpha:1.0].
 */
@property (nonatomic,strong) IBInspectable UIColor *selectedLineColor;
/*
 * Change the error label text color. Default is Red Color.
 */
@property (nonatomic,strong) IBInspectable UIColor *errorTextColor;
/*
 * Change the error line color. Default is Red Color.
 */
@property (nonatomic,strong) IBInspectable UIColor *errorLineColor;
/*
 * Change the error display text.
 */
@property (nonatomic,strong) IBInspectable  NSString  *errorText;
/*
 * Shake line when showing error?.
 */
@property (assign) IBInspectable  BOOL disableShakeWithError;


@property (nonatomic,strong) UILabel *labelPlaceholder;
@property (nonatomic,strong) UILabel *labelErrorPlaceholder;


@property (assign) IBInspectable  BOOL disableFloatingLabel;

-(instancetype)init;
-(instancetype)initWithFrame:(CGRect)frame;

-(void)showError;
-(void)hideError;
-(void)showErrorWithText:(NSString *)errorText;
-(void)updateTextField:(CGRect)frame;


@end
