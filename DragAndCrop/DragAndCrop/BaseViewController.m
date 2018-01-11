//
//  BaseViewController.m
//  DragAndCrop
//
//  Created by YouXianMing on 2018/1/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.contentView          = [[UIView alloc] initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight, Width, Height - StatusBarAndNavigationBarHeight)];
    [self.view addSubview:self.contentView];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

@end
