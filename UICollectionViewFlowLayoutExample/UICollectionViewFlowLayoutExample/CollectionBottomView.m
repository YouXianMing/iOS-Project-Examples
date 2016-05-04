//
//  CollectionBottomView.m
//  LayoutViewController
//
//  Created by YouXianMing on 16/5/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CollectionBottomView.h"
#import "DatasModel.h"

@interface CollectionBottomView ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation CollectionBottomView

- (void)setupCollectionReusableView {
    
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = [UIColor greenColor].CGColor;
}

- (void)buildSubview {
    
    self.textLabel                   = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    self.textLabel.textAlignment     = NSTextAlignmentCenter;
    self.textLabel.layer.borderWidth = 0.5f;
    self.textLabel.font              = [UIFont systemFontOfSize:12.f];
    self.textLabel.layer.borderColor = [UIColor brownColor].CGColor;
    [self addSubview:self.textLabel];
}

- (void)loadContent {
    
    DatasModel *model   = self.data;
    self.textLabel.text = model.subTitle;
}
@end
