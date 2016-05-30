//
//  PresentViewController.m
//  Animator
//
//  Created by YouXianMing on 16/5/27.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "PresentViewController.h"
#import "UIView+SetRect.h"
#import "PresentAnimator.h"
#import "DismissAnimator.h"
#import "UIColor+Random.h"

typedef enum : NSUInteger {
    
    kPresentButton = 1000,
    kDismissButton,
    
} EViewControllerViewTag;

@interface PresentViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation PresentViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Set backgroundColor.
    self.view.backgroundColor = [UIColor randomColorWithAlpha:1.f];
    
    // Init button.
    [self initButtons];
}

- (void)initButtons {
    
    {
        UIButton *button          = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
        button.center             = CGPointMake(self.view.width / 2.f, self.view.height / 4.f);
        button.layer.borderWidth  = 0.5f;
        button.layer.cornerRadius = 4.f;
        button.tag                = kPresentButton;
        [self.view addSubview:button];
        
        [button setTitle:@"Present"                                               forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor]                                forState:UIControlStateNormal];
        [button setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    {
        UIButton *button          = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
        button.center             = CGPointMake(self.view.width / 2.f, self.view.height / 4.f * 3);
        button.layer.borderWidth  = 0.5f;
        button.layer.cornerRadius = 4.f;
        button.tag                = kDismissButton;
        [self.view addSubview:button];
        
        [button setTitle:@"Dismiss"                                                forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor]                                 forState:UIControlStateNormal];
        [button setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5f]  forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)buttonEvent:(UIButton *)button {
    
    if (button.tag == kPresentButton) {
        
        PresentViewController *presentViewController = [PresentViewController new];
        presentViewController.fromViewController     = self;
        presentViewController.transitioningDelegate  = self;
        presentViewController.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:presentViewController animated:YES completion:nil];
        
    } else if (button.tag == kDismissButton) {
        
        [self.fromViewController dismissViewControllerAnimated:YES completion:nil];
    }
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
