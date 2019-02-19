//
//  NoticeCell.m
//  TestTableView
//
//  Created by YouXianMing on 2019/2/18.
//  Copyright © 2019 YouXianMing. All rights reserved.
//

#import "NoticeCell.h"

@implementation NoticeCell

- (void)setupCell {
    
    self.contentView.backgroundColor = [UIColor.cyanColor colorWithAlphaComponent:0.5f];
}

- (void)buildSubview {
    
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.text          = @"Notice";
}

- (void)selectedEvent {
    
    NSLog(@"%@", @"NoticeCell");
}

@end
