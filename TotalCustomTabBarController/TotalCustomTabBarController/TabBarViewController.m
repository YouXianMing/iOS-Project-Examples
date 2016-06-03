//
//  TabBarViewController.m
//  CompleteCustomTabBarController
//
//  Created by YouXianMing on 16/6/2.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "TabBarViewController.h"
#import "UIView+SetRect.h"
#import "TabBarImageModel.h"
#import "CustomNavigationController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "DefaultNotificationCenter.h"

@interface TabBarViewController () <DefaultNotificationCenterDelegate>

@property (nonatomic, strong) DefaultNotificationCenter           *eventCenter;
@property (nonatomic, strong) NSMutableArray <TabBarImageModel *> *iconsModel;

@end

@implementation TabBarViewController

#pragma mark - Overwrite super class.

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.viewControllers = \
            @[[[CustomNavigationController alloc] initWithRootViewController:[FirstViewController new] setNavigationBarHidden:YES],
              [[CustomNavigationController alloc] initWithRootViewController:[SecondViewController new] setNavigationBarHidden:YES],
              [[CustomNavigationController alloc] initWithRootViewController:[ThirdViewController new] setNavigationBarHidden:YES],
              [[CustomNavigationController alloc] initWithRootViewController:[FourthViewController new] setNavigationBarHidden:YES]];
        
        self.eventCenter          = [DefaultNotificationCenter new];
        self.eventCenter.delegate = self;
        [self.eventCenter addNotificationName:TabBarViewControllerShowEventNotification];
        [self.eventCenter addNotificationName:TabBarViewControllerHideEventNotification];
    }
    
    return self;
}

- (void)buildItems {
    
    self.tabBarView.backgroundColor = [UIColor whiteColor];
    
    self.iconsModel = [NSMutableArray array];
    [self.iconsModel addObject:[TabBarImageModel tabBarImageModelWithNormalImage:@"tab_company" highlightImage:@"tab_company_pre"]];
    [self.iconsModel addObject:[TabBarImageModel tabBarImageModelWithNormalImage:@"tab_event"   highlightImage:@"tab_event_pre"]];
    [self.iconsModel addObject:[TabBarImageModel tabBarImageModelWithNormalImage:@"tab_me"      highlightImage:@"tab_me_pre"]];
    [self.iconsModel addObject:[TabBarImageModel tabBarImageModelWithNormalImage:@"tab_service" highlightImage:@"tab_service_pre"]];
    
    CGFloat gap = (CGFloat)(Width / self.viewControllers.count);
    for (int i = 0; i < self.viewControllers.count; i++) {
        
        // Add button.
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(gap * i, 0, gap, self.tabBarView.height)];
        button.tag       = i;
        [button addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBarView addSubview:button];
        
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
    
    if ([name isEqualToString:TabBarViewControllerShowEventNotification]) {
        
        if ([object isKindOfClass:[NSNumber class]]) {
            
            [self hideTabBarView:NO animated:[object boolValue]];
            
        } else {
            
            [self hideTabBarView:NO animated:YES];
        }
        
    } else if ([name isEqualToString:TabBarViewControllerHideEventNotification]) {
        
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
