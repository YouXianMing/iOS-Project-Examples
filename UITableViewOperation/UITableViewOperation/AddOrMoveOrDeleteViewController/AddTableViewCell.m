//
//  AddTableViewCell.m
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "AddTableViewCell.h"
#import "UIView+SetRect.h"

@interface AddTableViewCell ()

@end

@implementation AddTableViewCell

- (void)buildSubview {
    
    UILabel *label = [UILabel new];
    label.text     = @"+";
    [label sizeToFit];
    [self.contentView addSubview:label];
    
    label.centerX = Width / 2.f;
    label.centerY = 15.f;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Width, 30.f)];
    [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
}

- (void)buttonEvent:(UIButton *)button {
 
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        
        [self.delegate customCell:self event:nil];
    }
}

@end
