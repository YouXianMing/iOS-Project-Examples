//
//  ViewController.m
//  RoundButton
//
//  Created by YouXianMing on 2017/7/19.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "ViewController.h"
#import "RoundButton.h"
#import "UIButton+Init.h"
#import "UIImage+SolidColor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    RoundButton *button        = [[RoundButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    button.layer.borderWidth   = 2.f;
    button.layer.borderColor   = [[UIColor redColor] colorWithAlphaComponent:0.5f].CGColor;
    button.layer.cornerRadius  = 50.f;
    button.layer.masksToBounds = YES;
    
    button.backgroundNormalImage      = [UIImage imageWithSize:CGSizeMake(5, 5) color:[[UIColor redColor] colorWithAlphaComponent:0.5]];
    button.backgroundHighlightedImage = [UIImage imageWithSize:CGSizeMake(5, 5) color:[[UIColor redColor] colorWithAlphaComponent:0.1f]];
    button.center                     = self.view.center;
    [self.view addSubview:button];
    
    // debug区域用view
    UIView *debugView                = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    debugView.layer.borderWidth      = 0.5f;
    debugView.layer.borderColor      = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f].CGColor;
    debugView.userInteractionEnabled = NO;
    debugView.center                 = self.view.center;
    [self.view addSubview:debugView];
}

@end
