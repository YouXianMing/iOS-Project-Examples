//
//  ViewController.m
//  Internationalization
//
//  Created by YouXianMing on 16/4/26.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UILabel *label      = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor     = [UIColor blackColor];
    label.text          = NSLocalizedString(@"title", @"");
    [self.view addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedString(@"icon", @"")]];
    [self.view addSubview:imageView];
}

@end
