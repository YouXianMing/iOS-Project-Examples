//
//  UIButton+DemoUse.m
//  Music
//
//  Created by XianMingYou on 15/4/14.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "UIButton+DemoUse.h"

@implementation UIButton (DemoUse)

+ (UIButton *)createButtonWithFrame:(CGRect)frame
                            withTag:(NSInteger)tag
                          withTitle:(NSString *)title
                           withFont:(UIFont *)font
                          addTarget:(id)target
                             action:(SEL)action
                         haveBorder:(BOOL)haveBorder
                       insertInView:(UIView *)view {
    
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.tag       = tag;
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
    
    if (font) {
        
        button.titleLabel.font = font;
    }
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    if (haveBorder) {
        
        button.layer.borderWidth = 1.f;
    }
    
    return button;
}

@end
