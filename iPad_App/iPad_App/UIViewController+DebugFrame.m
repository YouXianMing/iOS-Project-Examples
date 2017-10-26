//
//  UIViewController+DebugFrame.m
//  iPad_App
//
//  Created by YouXianMing on 2017/10/23.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "UIViewController+DebugFrame.h"
#import "Masonry.h"

@implementation UIViewController (DebugFrame)

- (void)showDebugFrame {
    
    self.view.layer.borderWidth = 16.f;
    self.view.layer.borderColor = [UIColor colorWithHue:arc4random() % 256 / 255.f saturation:1 brightness:1 alpha:0.5].CGColor;
    
    UILabel *label               = [UILabel new];
    label.text                   = NSStringFromClass([self class]);
    label.userInteractionEnabled = NO;
    label.font                   = [UIFont boldSystemFontOfSize:10.f];
    label.textColor              = [UIColor blackColor];
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-18);
        make.bottom.mas_equalTo(-2);
    }];
}

@end
