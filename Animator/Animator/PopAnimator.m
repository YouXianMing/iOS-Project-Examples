//
//  PopAnimator.m
//  Animator
//
//  Created by YouXianMing on 16/5/27.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "PopAnimator.h"
#import "UIView+SetRect.h"
#import "UIView+AnimationProperty.h"

@implementation PopAnimator

- (void)transitionAnimation {
    
    // http://stackoverflow.com/questions/25513300/using-custom-ios-7-transition-with-subclassed-uinavigationcontroller-occasionall
    [self.containerView insertSubview:self.toViewController.view belowSubview:self.fromViewController.view];
    
    [UIView animateWithDuration:self.transitionDuration animations:^{
        
        self.toViewController.view.scale = 1.f;
        self.fromViewController.view.x   = Width;
        
    } completion:^(BOOL finished) {
        
        [self completeTransition];
    }];
}

@end
