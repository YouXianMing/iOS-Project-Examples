//
//  SecondViewController.m
//  CompleteCustomTabBarController
//
//  Created by YouXianMing on 16/6/2.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)setup {
    
    [super setup];
    
    self.view.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5f];
}

#pragma mark - Overwrite system methods.

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.enableInteractivePopGestureRecognizer = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    self.enableInteractivePopGestureRecognizer = YES;
}

@end
