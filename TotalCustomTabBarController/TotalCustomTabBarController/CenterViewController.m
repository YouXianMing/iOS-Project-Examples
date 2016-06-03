//
//  CenterViewController.m
//  TotalCustomTabBarController
//
//  Created by YouXianMing on 16/6/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CenterViewController.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

- (void)setup {
    
    [super setup];
    
    self.view.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.5f];
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
