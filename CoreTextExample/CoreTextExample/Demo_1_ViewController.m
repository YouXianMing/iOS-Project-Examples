//
//  Demo_1_ViewController.m
//  CoreTextExample
//
//  Created by YouXianMing on 2018/3/2.
//  Copyright © 2018年 TechCode. All rights reserved.
//

#import "Demo_1_ViewController.h"
#import "Demo_1_View.h"

@interface Demo_1_ViewController ()

@end

@implementation Demo_1_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    Demo_1_View *coreTextExample_1_view = [[Demo_1_View alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    coreTextExample_1_view.center                  = self.contentView.center;
    [self.contentView addSubview:coreTextExample_1_view];
}

@end
