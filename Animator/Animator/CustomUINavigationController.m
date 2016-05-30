//
//  CustomUINavigationController.m
//  Animator
//
//  Created by YouXianMing on 16/5/27.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CustomUINavigationController.h"
#import "PresentAnimator.h"
#import "DismissAnimator.h"

@interface CustomUINavigationController () <UIViewControllerTransitioningDelegate>

@end

@implementation CustomUINavigationController

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {

    viewControllerToPresent.transitioningDelegate  = self;
    viewControllerToPresent.modalPresentationStyle = UIModalPresentationCustom;
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source {
    
    // PresentAnimator
    return [PresentAnimator new];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    // DismissAnimator
    return [DismissAnimator new];
}

@end
