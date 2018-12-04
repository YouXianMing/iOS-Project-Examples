//
//  ViewController.m
//  UIActivityViewControllerDemo
//
//  Created by YouXianMing on 2018/12/4.
//  Copyright © 2018 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "FacebookActivity.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame     = CGRectMake(0, 0, 100, 50.f);
    button.center    = self.view.center;
    [button setTitle:@"分享" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(shareEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)shareEvent:(UIButton *)button {
    
    NSString *textToShare  = @"AjMall";
    NSURL    *urlToShare   = [NSURL URLWithString:@"https://github.com/"];
    
    NSArray *activityItems = @[
                               textToShare,
                               urlToShare,
                               ];
    
    FacebookActivity *activity = [FacebookActivity new];
    
    UIActivityViewController *activeViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[activity]];
    
    // 不显示哪些分享平台
    activeViewController.excludedActivityTypes = @[UIActivityTypeAirDrop,
                                                   UIActivityTypeCopyToPasteboard,
                                                   UIActivityTypeAddToReadingList,
                                                   UIActivityTypeOpenInIBooks,
                                                   UIActivityTypeSaveToCameraRoll];
    
    [self presentViewController:activeViewController animated:YES completion:nil];
    
    // 分享结果回调方法
    activeViewController.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType,
                                                        BOOL completed,
                                                        NSArray * _Nullable returnedItems,
                                                        NSError * _Nullable activityError) {
        
        NSLog(@"%@", activityError);
        
        if (completed) {
            
            
        } else {
            
            
        }
    };
}

@end
