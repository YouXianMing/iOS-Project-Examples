//
//  TabBarTypeTwoViewController.m
//  TotalCustomTabBarController
//
//  Created by YouXianMing on 16/6/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "TabBarTypeTwoViewController.h"
#import "UIView+SetRect.h"
#import "TabBarImageModel.h"
#import "CustomNavigationController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "CenterViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "DefaultNotificationCenter.h"

@interface TabBarTypeTwoViewController ()<DefaultNotificationCenterDelegate>

@property (nonatomic, strong) DefaultNotificationCenter           *eventCenter;
@property (nonatomic, strong) NSMutableArray <TabBarImageModel *> *iconsModel;

@end

@implementation TabBarTypeTwoViewController

#pragma mark - Overwrite super class.

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.viewControllers = \
        @[[[CustomNavigationController alloc] initWithRootViewController:[FirstViewController new] setNavigationBarHidden:YES],
          [[CustomNavigationController alloc] initWithRootViewController:[SecondViewController new] setNavigationBarHidden:YES],
          [[CustomNavigationController alloc] initWithRootViewController:[CenterViewController new] setNavigationBarHidden:YES],
          [[CustomNavigationController alloc] initWithRootViewController:[ThirdViewController new] setNavigationBarHidden:YES],
          [[CustomNavigationController alloc] initWithRootViewController:[FourthViewController new] setNavigationBarHidden:YES]];
        
        self.eventCenter          = [DefaultNotificationCenter new];
        self.eventCenter.delegate = self;
        [self.eventCenter addNotificationName:hideEventNotification];
        [self.eventCenter addNotificationName:showEventNotification];
    }
    
    return self;
}

- (void)buildItems {
    
    self.tabBarView.backgroundColor = [UIColor whiteColor];
    
    self.iconsModel = [NSMutableArray array];
    [self.iconsModel addObject:[TabBarImageModel tabBarImageModelWithNormalImage:@"TabBar1" highlightImage:@"TabBar1Sel"]];
    [self.iconsModel addObject:[TabBarImageModel tabBarImageModelWithNormalImage:@"TabBar2" highlightImage:@"TabBar2Sel"]];
    [self.iconsModel addObject:[TabBarImageModel tabBarImageModelWithNormalImage:@"摄影机图标_点击前" highlightImage:@"摄影机图标_点击后"]];
    [self.iconsModel addObject:[TabBarImageModel tabBarImageModelWithNormalImage:@"TabBar4" highlightImage:@"TabBar4Sel"]];
    [self.iconsModel addObject:[TabBarImageModel tabBarImageModelWithNormalImage:@"TabBar5" highlightImage:@"TabBar5Sel"]];
    
    CGFloat gap = (CGFloat)(Width / self.viewControllers.count);
    for (int i = 0; i < self.viewControllers.count; i++) {
        
        // Add button.
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(gap * i, 0, gap, self.tabBarView.height)];
        button.tag       = i;
        [button addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBarView addSubview:button];
        
        if (i == 2) {
        
            // Add carama picture.
            CGFloat caramaWidth = button.width >= button.height ? button.width : button.height;
            button.width  = caramaWidth;
            button.height = caramaWidth;
            button.centerX = Width / 2.f;
            button.bottom  = self.tabBarView.height - 5;
            
            TabBarImageModel *model = self.iconsModel[i];
            [button setBackgroundImage:model.normalImage    forState:UIControlStateNormal];
            [button setBackgroundImage:model.highlightImage forState:UIControlStateHighlighted];
            continue;
        }
        
        // Add ImageView.
        TabBarImageModel *model     = self.iconsModel[i];
        UIImageView      *imageView = [[UIImageView alloc] initWithImage:model.normalImage highlightedImage:model.highlightImage];
        imageView.center            = button.middlePoint;
        [self setView:imageView withTagString:@(i).stringValue];
        [button addSubview:imageView];
    }
}

- (void)didSelectedIndex:(NSInteger)index {
    
    for (int i = 0; i < self.viewControllers.count; i++) {
        
        UIImageView *imageView = [self viewWithTagSting:@(i).stringValue];
        
        if (index == i) {
            
            imageView.highlighted = YES;
            
        } else {
            
            imageView.highlighted = NO;
        }
    }
    
    [super didSelectedIndex:index];
}

#pragma mark - Tap button event.

- (void)buttonsEvent:(UIButton *)button {
    
    if ([self willSelectIndex:button.tag] == YES) {
        
        [self didSelectedIndex:button.tag];
    }
}

#pragma mark - NotificationCenter event.

- (void)defaultNotificationCenter:(DefaultNotificationCenter *)notification name:(NSString *)name object:(id)object {
    
    if ([name isEqualToString:showEventNotification]) {
        
        if ([object isKindOfClass:[NSNumber class]]) {
            
            [self hideTabBarView:NO animated:[object boolValue]];
            
        } else {
            
            [self hideTabBarView:NO animated:YES];
        }
        
    } else if ([name isEqualToString:hideEventNotification]) {
        
        if ([object isKindOfClass:[NSNumber class]]) {
            
            [self hideTabBarView:YES animated:[object boolValue]];
            
        } else {
            
            [self hideTabBarView:YES animated:YES];
        }
    }
}

#pragma mark - System methods.

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.enableInteractivePopGestureRecognizer = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    self.enableInteractivePopGestureRecognizer = YES;
}

@end
