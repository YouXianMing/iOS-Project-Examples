//
//  SecondViewController.m
//  TabbarController
//
//  Created by XianMingYou on 15/4/15.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title                = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor redColor];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    NSLog(@"%@ viewDidAppear", NSStringFromClass([self class]));
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSLog(@"%@ viewWillAppear", NSStringFromClass([self class]));
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    NSLog(@"%@ viewWillDisappear", NSStringFromClass([self class]));
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    NSLog(@"%@ viewDidDisappear", NSStringFromClass([self class]));
}

@end
