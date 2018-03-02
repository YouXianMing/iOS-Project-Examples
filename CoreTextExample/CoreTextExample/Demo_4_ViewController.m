//
//  Demo_4_ViewController.m
//  CoreTextExample
//
//  Created by YouXianMing on 2018/3/2.
//  Copyright © 2018年 TechCode. All rights reserved.
//

#import "Demo_4_ViewController.h"
#import "Demo_4_View.h"

@interface Demo_4_ViewController ()

@end

@implementation Demo_4_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    Demo_4_View *drawView = [[Demo_4_View alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    drawView.center    = self.contentView.center;
    [self.contentView addSubview:drawView];
}

@end
