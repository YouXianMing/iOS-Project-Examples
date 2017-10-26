//
//  FirstViewController.m
//  iPad_App
//
//  Created by YouXianMing on 2017/10/23.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.layer.borderWidth = 4.f;
    self.view.layer.borderColor = [UIColor redColor].CGColor;
}

#pragma mark - view show info

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSLog(@"'%@' viewWillAppear", NSStringFromClass([self class]));
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    NSLog(@"'%@' viewDidAppear", NSStringFromClass([self class]));
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    NSLog(@"'%@' viewWillDisappear", NSStringFromClass([self class]));
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    NSLog(@"'%@' viewDidDisappear", NSStringFromClass([self class]));
}

@end
