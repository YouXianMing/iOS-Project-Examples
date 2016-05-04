//
//  FlowStyleCell.m
//  LayoutViewController
//
//  Created by YouXianMing on 16/5/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "FlowStyleCell.h"
#import "InfoModel.h"

@interface FlowStyleCell ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation FlowStyleCell

- (void)setupCell {

    self.backgroundColor   = [UIColor whiteColor];
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)buildSubview {

    self.textLabel                   = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.textLabel.textAlignment     = NSTextAlignmentCenter;
    self.textLabel.layer.borderWidth = 0.5f;
    self.textLabel.layer.borderColor = [UIColor blueColor].CGColor;
    [self addSubview:self.textLabel];
}

- (void)loadContent {

    InfoModel *model    = self.data;
    self.textLabel.text = model.name;
}

@end
