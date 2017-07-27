//
//  ViewController.m
//  ItemStyle
//
//  Created by YouXianMing on 2017/7/27.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+ItemStyle.h"
#import "RedStyle.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150.f, 40.f)];
    button.center    = self.view.center;
    button.itemStyle = [RedStyle style];
    [button setTitle:@"红色样式" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [self performSelector:@selector(selectorEvent:) withObject:button afterDelay:2.f];
}

- (void)selectorEvent:(UIButton *)button {
    
    RedStyle *style = (RedStyle *)button.itemStyle;
    style.font      = [UIFont systemFontOfSize:18.f];
}

@end
