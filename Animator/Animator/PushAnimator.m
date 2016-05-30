//
//  PushAnimator.m
//  Animator
//
//  Created by YouXianMing on 16/5/27.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "PushAnimator.h"
#import "UIView+SetRect.h"
#import "UIView+AnimationProperty.h"

@implementation PushAnimator

- (void)transitionAnimation {
    
    // http://stackoverflow.com/questions/25588617/ios-8-screen-blank-after-dismissing-view-controller-with-custom-presentation
    [self.containerView addSubview:self.toViewController.view];
    
    self.toViewController.view.x = Width;
    [UIView animateWithDuration:self.transitionDuration animations:^{
        
        self.fromViewController.view.scale = 0.95f;
        self.toViewController.view.x       = 0;
        
    } completion:^(BOOL finished) {
        
        [self completeTransition];
    }];
}

@end
