//
//  BaseViewController.m
//  CoreTextExample
//
//  Created by YouXianMing on 2018/3/2.
//  Copyright © 2018年 TechCode. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView  *titleView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.contentView];
    
    self.titleView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 80)];
    self.titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleView];
    
    self.titleLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Width, 45.f)];
    self.titleLabel.text          = self.title;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.bottom        = self.titleView.height;
    [self.titleView addSubview:self.titleLabel];
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5f)];
    line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.15];
    line.bottom          = self.titleView.height;
    [self.titleView addSubview:line];
    
    UIButton *button                  = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame                      = CGRectMake(0, 0, 100, self.titleLabel.height);
    button.bottom                     = self.titleView.height;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentEdgeInsets          = UIEdgeInsetsMake(0, 15.f, 0, 0);
    [button addTarget:self action:@selector(backButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [self.titleView addSubview:button];
}

- (void)backButtonEvent {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
