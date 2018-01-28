//
//  AddOrRemoveCell.m
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "AddOrRemoveCell.h"
#import "AddOrRemoveCellData.h"
#import "UIView+SetRect.h"

@interface AddOrRemoveCell ()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation AddOrRemoveCell

- (void)buildSubview {
    
    self.nameLabel      = [UILabel new];
    self.nameLabel.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:self.nameLabel];
}

- (void)loadContent {
    
    AddOrRemoveCellData *data = self.data;
    
    self.nameLabel.text = data.title;
    [self.nameLabel sizeToFit];
    
    self.nameLabel.centerY = self.dataAdapter.cellHeight / 2.f;
    self.nameLabel.left    = 15.f;
}

@end
