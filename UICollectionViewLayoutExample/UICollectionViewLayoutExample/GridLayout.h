//
//  GridLayout.h
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/12.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridLayout : UICollectionViewLayout

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

@end
