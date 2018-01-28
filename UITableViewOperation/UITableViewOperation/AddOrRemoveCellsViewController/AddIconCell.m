//
//  AddIconCell.m
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "AddIconCell.h"
#import "UIView+SetRect.h"

@implementation AddIconCell

- (void)buildSubview {
    
    UILabel *label = [UILabel new];
    label.text     = @"+";
    [label sizeToFit];
    [self.contentView addSubview:label];
    
    label.centerX = Width / 2.f;
    label.centerY = 15.f;
}

@end
