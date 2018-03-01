//
//  ViewController.m
//  CoreTextExample
//
//  Created by YouXianMing on 2017/7/19.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "ViewController.h"
#import "DemoView.h"
#import "Demo2View.h"
#import "Demo3View.h"
#import "Demo4View.h"

#import "DrawView.h"

#import "CoreText_Examle_1_View.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    DemoView *demoView = [[DemoView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:demoView];
    
//    Demo2View *demoView = [[Demo2View alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    demoView.center     = self.view.center;
//    [self.view addSubview:demoView];
    
//    Demo3View *demoView = [[Demo3View alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
//    demoView.center     = self.view.center;
//    [self.view addSubview:demoView];
    
//    Demo4View *demoView = [[Demo4View alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    demoView.center     = self.view.center;
//    [self.view addSubview:demoView];
    
//    DrawView *drawView = [[DrawView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    [self.view addSubview:drawView];
    
    CoreText_Examle_1_View *coreTextExample_1_view = [[CoreText_Examle_1_View alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    coreTextExample_1_view.center                  = self.view.center;
    [self.view addSubview:coreTextExample_1_view];
}

@end
