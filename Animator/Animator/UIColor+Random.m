//
//  UIColor+Random.m
//  Animator
//
//  Created by YouXianMing on 16/5/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UIColor+Random.h"

@implementation UIColor (Random)

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha {

    return [UIColor colorWithRed:arc4random() % 256 / 255.f
                           green:arc4random() % 256 / 255.f
                            blue:arc4random() % 256 / 255.f
                           alpha:alpha];
}

@end
