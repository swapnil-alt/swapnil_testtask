//
//  UILabel+Boldify.h
//  App2Match
//
//  Created by Admin on 06/08/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Boldify)
- (void) boldSubstring: (NSString*) substring font:(UIFont *)appFont;
//- (void) boldRange: (NSRange) range;
- (void) colorSubstring: (NSString*) substring color:(UIColor *)clr isUnderLine:(BOOL)underline;

@end
