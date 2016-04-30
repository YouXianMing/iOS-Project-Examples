//
//  ViewController.m
//  UITableBarControllerDemo
//
//  Created by YouXianMing on 16/4/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "UIView+SetRect.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *statusBarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Setup UIWebView.
    {
        NSURL        *url     = [NSURL URLWithString:self.urlString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        UIWebView    *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
        [webView loadRequest:request];
        [self.view addSubview:webView];
        
        // Setup backgroundColor.
        webView.backgroundColor = [UIColor whiteColor];
        webView.opaque          = NO;
        
        // Setup contentInset.
        webView.scrollView.contentInset = UIEdgeInsetsMake(StatusBarHeight, 0, TabbarHeight, 0);
    }
    
    self.statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, StatusBarHeight)];
    self.statusBarView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.statusBarView];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return self.style;
}

@end
