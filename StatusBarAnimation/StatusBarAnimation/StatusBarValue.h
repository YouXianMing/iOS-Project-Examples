//
//  StatusBarValue.h
//  StatusBarAnimation
//
//  Created by YouXianMing on 16/6/28.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StatusBarValue : NSObject

@property (nonatomic, weak) UIViewController *controller;

/**
 *  Default value is UIStatusBarAnimationFade.
 */
@property (nonatomic) UIStatusBarAnimation animationType;

/**
 *  Default value is UIStatusBarStyleDefault.
 */
@property (nonatomic) UIStatusBarStyle     style;

/**
 *  Default value is NO.
 */
@property (nonatomic) BOOL                 hidden;

/**
 *  SetNeedsStatusBarAppearanceUpdate
 *
 *  @param animated Animated or not.
 *  @param duration Animation's duration.
 */
- (void)statusBarAppearanceUpdateAnimated:(BOOL)animated duration:(NSTimeInterval)duration;

#pragma mark - Constructor

+ (instancetype)statusBarValueWithController:(UIViewController *)controller;

@end
