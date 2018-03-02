//
//  Demo_5_ViewController.m
//  CoreTextExample
//
//  Created by YouXianMing on 2018/3/2.
//  Copyright © 2018年 TechCode. All rights reserved.
//

#import "Demo_5_ViewController.h"
#import "Demo_5_View.h"

@interface Demo_5_ViewController ()

@end

@implementation Demo_5_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    Demo_5_View *coreTextView = [[Demo_5_View alloc] initWithFrame:CGRectMake(0, 0, Width - 50, self.contentView.height - 300)];
    coreTextView.center        = self.contentView.middlePoint;
    [self.contentView addSubview:coreTextView];
}

@end
