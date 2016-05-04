//
//  CollectionHeaderView.m
//  LayoutViewController
//
//  Created by YouXianMing on 16/5/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CollectionHeaderView.h"
#import "DatasModel.h"

@interface CollectionHeaderView ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation CollectionHeaderView

- (void)setupCollectionReusableView {
    
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = [UIColor redColor].CGColor;
}

- (void)buildSubview {
    
    self.textLabel                   = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    self.textLabel.textAlignment     = NSTextAlignmentCenter;
    self.textLabel.layer.borderWidth = 0.5f;
    self.textLabel.font              = [UIFont systemFontOfSize:12.f];
    self.textLabel.layer.borderColor = [UIColor magentaColor].CGColor;
    [self addSubview:self.textLabel];
}

- (void)loadContent {
    
    DatasModel *model   = self.data;
    self.textLabel.text = model.title;
}

@end
