//
//  AppDelegate.m
//  UITableBarControllerDemo
//
//  Created by YouXianMing on 16/4/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "NSString+RenderingMode.h"
#import "HexColors.h"
#import "UIFont+Fonts.h"
#import "UIColor+CreateImage.h"
#import "UIView+SetRect.h"
#import "UIView+GlowView.h"

typedef enum : NSUInteger {
    
    kDefaultStyle,
    kBlackStyle,
    kWhiteColorStyle,
    kCustomStyle,
    
} ETabBarControllerStyle;

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window                 = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self setupWithWindow:self.window];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)setupWithWindow:(UIWindow *)window {
    
    // Init controllers.
    NSMutableArray <UIViewController *> *controllers = [NSMutableArray array];
    
    {
        ViewController *controller = [[ViewController alloc] init];
        controller.urlString       = @"http://www.mtime.com/";
        controller.style           = UIStatusBarStyleLightContent;
        controller.tabBarItem      = [[UITabBarItem alloc] initWithTitle:@"孵化器"
                                                                   image:[@"tab_space" originalRenderImage]
                                                           selectedImage:[@"tab_space_pre" originalRenderImage]];
        [controllers addObject:controller];
    }
    
    {
        ViewController *controller = [[ViewController alloc] init];
        controller.urlString       = @"http://www.tgbus.com/";
        controller.style           = UIStatusBarStyleDefault;
        controller.tabBarItem      = [[UITabBarItem alloc] initWithTitle:@"资讯"
                                                                   image:[@"tab_oa" originalRenderImage]
                                                           selectedImage:[@"tab_oa_pre" originalRenderImage]];
        [controllers addObject:controller];
    }
    
    {
        ViewController *controller = [[ViewController alloc] init];
        controller.urlString       = @"https://movie.douban.com/";
        controller.style           = UIStatusBarStyleLightContent;
        controller.tabBarItem      = [[UITabBarItem alloc] initWithTitle:@"加速"
                                                                   image:[@"tab_service" originalRenderImage]
                                                           selectedImage:[@"tab_service_pre" originalRenderImage]];
        [controllers addObject:controller];
    }
    
    {
        ViewController *controller = [[ViewController alloc] init];
        controller.urlString       = @"https://www.baidu.com/";
        controller.style           = UIStatusBarStyleDefault;
        controller.tabBarItem      = [[UITabBarItem alloc] initWithTitle:@"计划"
                                                                   image:[@"tab_plan" originalRenderImage]
                                                           selectedImage:[@"tab_plan_pre" originalRenderImage]];
        [controllers addObject:controller];
    }
    
    {
        ViewController *controller = [[ViewController alloc] init];
        controller.urlString       = @"http://www.ubuuk.com/";
        controller.style           = UIStatusBarStyleLightContent;
        controller.tabBarItem      = [[UITabBarItem alloc] initWithTitle:@"会员"
                                                                   image:[@"tabme" originalRenderImage]
                                                           selectedImage:[@"tab_me_pre" originalRenderImage]];
        [controllers addObject:controller];
    }
    
    // Setup tabBarItem's imageInsets & tabBarItem's titlePositionAdjustment.
    for (UIViewController *controller in controllers) {
        
        {
            CGFloat offset                    = -2;
            controller.tabBarItem.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
        }
        
        {
            CGFloat offset                                = -2;
            controller.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, offset);
        }
    }
    
    // Setup TitleTextAttributes.
    {
        NSDictionary *normalStateAtr   = @{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"dbdbdb" alpha:1.f],
                                           NSFontAttributeName            : [UIFont HeitiSCWithFontSize:9.f]};
        NSDictionary *selectedStateAtr = @{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"11171a" alpha:1.f],
                                           NSFontAttributeName            : [UIFont HeitiSCWithFontSize:9.f]};
        
        [[UITabBarItem appearance] setTitleTextAttributes:normalStateAtr   forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:selectedStateAtr forState:UIControlStateSelected];
    }
    
    // Init tabBarController.
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.delegate            = self;
    tabBarController.viewControllers     = controllers;
    window.rootViewController            = tabBarController;
    
    // Setup tabBarController's style.
    [self tabBarController:tabBarController style:kCustomStyle];
    
    // Setup BadgeValue.
    [self setupBadgeValueWithTabBarController:tabBarController atIndex:3];
}

- (void)tabBarController:(UITabBarController *)tabBarController style:(ETabBarControllerStyle)style {

    if (style == kDefaultStyle) {
        
        // 系统设置，带有模糊效果
        tabBarController.tabBar.barStyle = UIBarStyleDefault;
        
    } else if (style == kBlackStyle) {
    
        // 系统设置，带有模糊效果
        tabBarController.tabBar.barStyle = UIBarStyleBlack;
        
    } else if (style == kWhiteColorStyle) {
    
        // 修改tabBar背景色 (没办法设置透明度, 没办法去除顶部的灰色线条)
        tabBarController.tabBar.barTintColor = [UIColor whiteColor];
        
    } else if (style == kCustomStyle) {
    
        // 修改tabBar背景色 + 去除顶部线条
        UIImage *backgroundImage = [[[UIColor whiteColor] colorWithAlphaComponent:0.85f] imageWithFrame:CGRectMake(0, 0, 10, 10)];
        UIImage *shadowImage     = [[UIImage alloc] init];
        tabBarController.tabBar.backgroundImage = backgroundImage;
        tabBarController.tabBar.shadowImage     = shadowImage;
    }
}

- (void)setupBadgeValueWithTabBarController:(UITabBarController *)tabBarController atIndex:(NSInteger)index {

    UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
    
    label.text            = @"1";
    label.textAlignment   = NSTextAlignmentCenter;
    label.font            = [UIFont systemFontOfSize:9];
    label.textColor       = [UIColor whiteColor];
    label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.85f];

    CGFloat gap   = tabBarController.tabBar.width / tabBarController.viewControllers.count;
    label.centerY = tabBarController.tabBar.middleY;
    label.centerX = gap / 2.f + index * gap;
    
    label.layer.cornerRadius  = label.width / 2.f;
    label.layer.masksToBounds = YES;
    
    // Start glow.
    label.glowRadius            = @(3.f);
    label.glowOpacity           = @(1.f);
    label.glowColor             = [[UIColor redColor] colorWithAlphaComponent:0.95f];
    label.glowDuration          = @(1.f);
    label.hideDuration          = @(3.f);
    label.glowAnimationDuration = @(2.f);
    [label createGlowLayer];
    [label insertGlowLayer];
    [label startGlowLoop];
    
    label.x += 10;
    label.y -= 15;
    
    [tabBarController.tabBar addSubview:label];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    for (int i = 0; i < tabBarController.viewControllers.count; i++) {
        
        if ([viewController isEqual:tabBarController.viewControllers[i]]) {
            
            NSLog(@"selected index - %d", i);
        }
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
