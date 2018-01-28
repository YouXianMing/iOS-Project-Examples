//
//  AddOrMoveOrDeleteCell.m
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "AddOrMoveOrDeleteCell.h"
#import "AddOrMoveOrDeleteCellData.h"
#import "UIView+SetRect.h"

@interface AddOrMoveOrDeleteCell ()

@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UILabel  *nameLabel;

@end

@implementation AddOrMoveOrDeleteCell

- (void)buildSubview {
    
    self.nameLabel      = [UILabel new];
    self.nameLabel.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:self.nameLabel];
    
    self.deleteButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.deleteButton.right = Width;
    [self.deleteButton setTitle:@"x" forState:UIControlStateNormal];
    [self.deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.deleteButton setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
    [self.deleteButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.deleteButton];
}

- (void)loadContent {
    
    AddOrMoveOrDeleteCellData *data = self.data;
    
    self.nameLabel.text = data.title;
    [self.nameLabel sizeToFit];
    
    self.deleteButton.centerY = self.dataAdapter.cellHeight / 2.f;;
    self.nameLabel.centerY    = self.dataAdapter.cellHeight / 2.f;
    self.nameLabel.left       = 15.f;
}

- (void)buttonEvent:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        
        [self.delegate customCell:self event:nil];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    NSLog(@"%d", editing);
    
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.deleteButton.alpha = editing ? 0.f : 1.f;
        
    } completion:nil];
}

@end
