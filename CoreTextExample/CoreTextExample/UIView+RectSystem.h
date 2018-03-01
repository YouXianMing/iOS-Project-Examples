//
//  UIView+RectSystem.h
//  CoreTextExample
//
//  Created by YouXianMing on 2017/7/20.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RectSystem)

/**
 将手机系统的point转换为Mac系统的point

 @param origin 苹果系统的point
 @return Mac系统的point
 */
- (CGPoint)MacSystemPointFromMobileSystemPoint:(CGPoint)origin;

/**
 将Mac系统的frame转换为手机系统的frame

 @param frame Mac系统的frame
 @return 手机系统的frame
 */
- (CGRect)mobileSystemFrameFromMacSystemFrame:(CGRect)frame;

@end
