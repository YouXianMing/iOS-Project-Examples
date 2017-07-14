//
//  GridDecorationView.m
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/12.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "GridDecorationView.h"

@implementation GridDecorationView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.borderWidth      = 0.5f;
        self.layer.borderColor      = [UIColor blueColor].CGColor;
        self.userInteractionEnabled = NO;
    }
    
    return self;
}

@end
