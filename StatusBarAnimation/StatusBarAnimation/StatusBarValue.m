//
//  StatusBarValue.m
//  StatusBarAnimation
//
//  Created by YouXianMing on 16/6/28.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "StatusBarValue.h"

@implementation StatusBarValue

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.animationType = UIStatusBarAnimationFade;
        self.style         = UIStatusBarStyleDefault;
        self.hidden        = NO;
    }
    
    return self;
}

- (void)statusBarAppearanceUpdateAnimated:(BOOL)animated duration:(NSTimeInterval)duration {

    if (self.controller) {
        
        if (animated) {
         
            [UIView animateWithDuration:duration > 0 ? duration : 0.35f animations:^{
                
                [self.controller setNeedsStatusBarAppearanceUpdate];
            }];
            
        } else {
        
            [self.controller setNeedsStatusBarAppearanceUpdate];
        }
    }
}

+ (instancetype)statusBarValueWithController:(UIViewController *)controller {

    StatusBarValue *value = [[[self class] alloc] init];
    value.controller      = controller;
    
    return value;
}

@end
