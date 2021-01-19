//
//  UILabel+Boldify.m
//  App2Match
//
//  Created by Admin on 06/08/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "UILabel+Boldify.h"

@implementation UILabel (Boldify)
- (void) boldRange: (NSRange) range font:(UIFont *)appFont
{
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedText setAttributes:@{NSFontAttributeName:appFont} range:range];
    
    self.attributedText = attributedText;
}
- (void) colorRange: (NSRange) range color:(UIColor *)clr isUnderLine:(BOOL)underline
{
    if (![self respondsToSelector:@selector(setAttributedText:)])
    {
        return;
    }
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    if (underline)
    {
            [attributedText setAttributes:@{NSForegroundColorAttributeName:clr,NSUnderlineStyleAttributeName:[NSNumber numberWithInt:1]} range:range];
    }
    else
    {
        [attributedText setAttributes:@{NSForegroundColorAttributeName:clr} range:range];
    }
    
    self.attributedText = attributedText;
}

- (void) boldSubstring: (NSString*) substring font:(UIFont *)appFont
{
    NSRange range = [self.text rangeOfString:substring];
    [self boldRange:range font:appFont];
}
- (void) colorSubstring: (NSString*) substring color:(UIColor *)clr isUnderLine:(BOOL)underline
{
    NSRange range = [self.text rangeOfString:substring];
    [self colorRange:range color:clr isUnderLine:underline];
}

@end
