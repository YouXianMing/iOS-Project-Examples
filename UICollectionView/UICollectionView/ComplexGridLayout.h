//
//  ComplexGridLayout.h
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/12.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *complexGridLayoutHeaderView     = @"ComplexGridLayoutHeaderView";
static NSString *complexGridLayoutFooterView     = @"ComplexGridLayoutFooterView";
static NSString *complexGridLayoutDecorationView = @"complexGridLayoutDecorationView";

@interface ComplexGridLayout : UICollectionViewLayout

/**
 元素大小, 默认 80 x 80
 */
@property (nonatomic) CGSize  itemSize;

/**
 元素水平间距, 默认 5.f
 */
@property (nonatomic) CGFloat itemHorizontalGap;

/**
 元素垂直间距, 默认 5.f
 */
@property (nonatomic) CGFloat itemVerticalGap;

/**
 头元素宽度(高度与元素高度一致), 默认 0.f
 */
@property (nonatomic) CGFloat headerWidth;

/**
 尾元素宽度(高度与元素高度一致), 默认 0.f
 */
@property (nonatomic) CGFloat footerWidth;

@end
