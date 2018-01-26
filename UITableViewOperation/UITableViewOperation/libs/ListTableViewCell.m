//
//  ListTableViewCell.m
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ListTableViewCell.h"
#import "UIView+SetRect.h"
#import "ListTableViewData.h"

@interface ListTableViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation ListTableViewCell

- (void)buildSubview {
    
    self.nameLabel      = [UILabel new];
    self.nameLabel.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:self.nameLabel];
}

- (void)loadContent {

    ListTableViewData *data = self.data;
    
    self.nameLabel.text = data.info;
    [self.nameLabel sizeToFit];
    
    self.nameLabel.centerY = 30.f;
    self.nameLabel.left    = 15.f;
}

@end
