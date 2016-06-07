//
//  leftViewCell.m
//  SideViewController
//
//  Created by YouXianMing on 16/6/6.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "LeftViewCell.h"

@interface LeftViewCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation LeftViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.label           = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 44)];
        self.label.textColor = [UIColor whiteColor];
        [self addSubview:self.label];
    }
    
    return self;
}

- (void)loadContent {

    self.label.text = self.data;
}

@end
