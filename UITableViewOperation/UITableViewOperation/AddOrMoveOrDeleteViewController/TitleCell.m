//
//  TitleCell.m
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "TitleCell.h"
#import "UIView+SetRect.h"

@implementation TitleCell

- (void)buildSubview {
    
    UILabel *label = [UILabel new];
    label.text     = @"标题";
    label.font     = [UIFont systemFontOfSize:24.f];
    [label sizeToFit];
    [self.contentView addSubview:label];
    
    label.centerX = Width / 2.f;
    label.centerY = 50.f;
}

@end
