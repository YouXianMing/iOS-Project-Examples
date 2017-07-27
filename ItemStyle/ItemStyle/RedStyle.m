//
//  RedStyle.m
//  ItemStyle
//
//  Created by YouXianMing on 2017/7/27.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "RedStyle.h"

@implementation RedStyle

- (void)makeStyleEffective {
    
    UIButton *button = self.source;
    
    button.layer.borderColor  = [UIColor redColor].CGColor;
    button.layer.borderWidth  = 0.5f;
    button.layer.cornerRadius = 4.f;
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitleColor:[[UIColor redColor] colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
    
    button.titleLabel.font = [UIFont systemFontOfSize:14.f];
}

- (void)setFont:(UIFont *)font {
    
    _font = font;
    
    UIButton *button = self.source;
    button.titleLabel.font = font;
}

@end
