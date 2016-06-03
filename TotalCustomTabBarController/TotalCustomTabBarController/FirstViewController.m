//
//  FirstViewController.m
//  CompleteCustomTabBarController
//
//  Created by YouXianMing on 16/6/2.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "FirstViewController.h"
#import "PushViewController.h"
#import "TabBarViewController.h"
#import "TabBarTypeTwoViewController.h"
#import "DefaultNotificationCenter.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)setup {

    [super setup];
    
    self.view.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5f];
    
    UIButton *button = [[UIButton alloc] initWithFrame:self.view.bounds];
    [button addTarget:self action:@selector(buttonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonEvent {

    [DefaultNotificationCenter postEventToNotificationName:TabBarViewControllerHideEventNotification object:@(YES)];
    [DefaultNotificationCenter postEventToNotificationName:hideEventNotification                     object:@(YES)];
    [self.navigationController pushViewController:[PushViewController new] animated:YES];
}

#pragma mark - Overwrite system methods.

- (void)viewDidAppear:(BOOL)animated {
    
    [DefaultNotificationCenter postEventToNotificationName:TabBarViewControllerShowEventNotification object:@(YES)];
    [DefaultNotificationCenter postEventToNotificationName:showEventNotification                     object:@(YES)];
    [super viewDidAppear:animated];
    self.enableInteractivePopGestureRecognizer = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    self.enableInteractivePopGestureRecognizer = YES;
}

@end
