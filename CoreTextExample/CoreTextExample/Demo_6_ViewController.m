//
//  Demo_6_ViewController.m
//  CoreTextExample
//
//  Created by YouXianMing on 2018/3/2.
//  Copyright © 2018年 TechCode. All rights reserved.
//

#import "Demo_6_ViewController.h"
#import "Demo_6_View.h"

@interface Demo_6_ViewController ()

@end

@implementation Demo_6_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    Demo_6_View *drawView = [[Demo_6_View alloc] initWithFrame:CGRectMake(0, 0, Width - 40, Height - 200)];
    drawView.center        = self.contentView.middlePoint;
    [self.contentView addSubview:drawView];
}

@end
