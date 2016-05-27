//
//  UIButton+DemoUse.h
//  Music
//
//  Created by XianMingYou on 15/4/14.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (DemoUse)

+ (UIButton *)createButtonWithFrame:(CGRect)frame
                            withTag:(NSInteger)tag
                          withTitle:(NSString *)title
                           withFont:(UIFont *)font
                          addTarget:(id)target
                             action:(SEL)action
                         haveBorder:(BOOL)haveBorder
                       insertInView:(UIView *)view;


@end
