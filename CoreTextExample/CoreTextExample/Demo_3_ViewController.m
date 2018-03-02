//
//  Demo_3_ViewController.m
//  CoreTextExample
//
//  Created by YouXianMing on 2018/3/2.
//  Copyright © 2018年 TechCode. All rights reserved.
//

#import "Demo_3_ViewController.h"
#import "Demo_3_View.h"

@interface Demo_3_ViewController ()

@end

@implementation Demo_3_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    Demo_3_View *drawView = [[Demo_3_View alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    drawView.center    = self.contentView.center;
    [self.contentView addSubview:drawView];
}

@end
