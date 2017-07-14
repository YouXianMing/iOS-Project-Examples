//
//  FooterCollectionReusableView.m
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/12.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "FooterCollectionReusableView.h"

@implementation FooterCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5f];
    }
    
    return self;
}

@end
