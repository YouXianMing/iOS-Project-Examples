//
//  BannerCell.m
//  TestTableView
//
//  Created by YouXianMing on 2019/2/18.
//  Copyright © 2019 YouXianMing. All rights reserved.
//

#import "BannerCell.h"

@implementation BannerCell

- (void)setupCell {
    
    self.contentView.backgroundColor = [UIColor.redColor colorWithAlphaComponent:0.5f];
}

- (void)buildSubview {
    
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.text          = @"Banner";
}

- (void)selectedEvent {
    
    NSLog(@"%@", @"BannerCell");
}

@end
