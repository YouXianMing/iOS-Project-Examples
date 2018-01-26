//
//  NormalDragViewCell.m
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NormalDragViewCell.h"
#import "NormalDragViewCellData.h"
#import "UIView+SetRect.h"

@interface NormalDragViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation NormalDragViewCell

- (void)buildSubview {
    
    self.nameLabel      = [UILabel new];
    self.nameLabel.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:self.nameLabel];
}

- (void)loadContent {
    
    NormalDragViewCellData *data = self.data;
    
    self.nameLabel.text = data.title;
    [self.nameLabel sizeToFit];
    
    self.nameLabel.centerY = self.dataAdapter.cellHeight / 2.f;
    self.nameLabel.left    = 15.f;
}

@end
