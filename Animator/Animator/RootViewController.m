//
//  RootViewController.m
//  Animator
//
//  Created by YouXianMing on 16/5/27.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "RootViewController.h"
#import "PresentViewController.h"
#import "PushViewController.h"
#import "UIView+SetRect.h"
#import "PushAnimator.h"
#import "PopAnimator.h"

typedef enum : NSUInteger {
    
    kPresentButton = 1000,
    kPushButton,
    
} EViewControllerViewTag;

@interface RootViewController () <UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Set backgroundColor.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Important setup.
    [self setup];
    
    // initButtons
    [self initButtons];
}

#pragma mark - Push or Pop related.

- (void)setup {
    
    // [IMPORTANT] Set the rootViewController's popGestureRecognizer.
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    // [IMPORTANT] Enable the Push transitioning.
    self.navigationController.delegate = self;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        
        return [PushAnimator new];
        
    } else if (operation == UINavigationControllerOperationPop) {
        
        return [PopAnimator new];
        
    } else {
        
        return nil;
    }
}

#pragma mark - Button related.

- (void)initButtons {
    
    {
        UIButton *button          = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
        button.center             = CGPointMake(self.view.width / 2.f, self.view.height / 4.f);
        button.layer.borderWidth  = 0.5f;
        button.layer.cornerRadius = 4.f;
        button.tag                = kPresentButton;
        [self.view addSubview:button];
        
        [button setTitle:@"Present"                                             forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor]                                forState:UIControlStateNormal];
        [button setTitleColor:[[UIColor redColor] colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    {
        UIButton *button          = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
        button.center             = CGPointMake(self.view.width / 2.f, self.view.height / 4.f * 3);
        button.layer.borderWidth  = 0.5f;
        button.layer.cornerRadius = 4.f;
        button.tag                = kPushButton;
        [self.view addSubview:button];
        
        [button setTitle:@"Push"                                                forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor]                                forState:UIControlStateNormal];
        [button setTitleColor:[[UIColor redColor] colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)buttonEvent:(UIButton *)button {
    
    if (button.tag == kPresentButton) {
        
        PresentViewController *presentViewController = [PresentViewController new];
        presentViewController.fromViewController     = self.navigationController;
        [self.navigationController presentViewController:presentViewController animated:YES completion:nil];
        
    } else if (button.tag == kPushButton) {
        
        [self.navigationController pushViewController:[PushViewController new] animated:YES];
    }
}

#pragma mark - Overwrite method.

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    // 关闭手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    // 激活手势
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

@end
