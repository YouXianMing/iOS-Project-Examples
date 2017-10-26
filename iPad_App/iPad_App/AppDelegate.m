//
//  AppDelegate.m
//  iPad_App
//
//  Created by YouXianMing on 2017/10/23.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseSplitViewController.h"
#import "MasterViewController.h"
#import "FirstDetailViewController.h"
#import "SecondDetailViewController.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MasterViewController *masterViewController = [MasterViewController new];
    
    FirstDetailViewController  *firstDetailViewController  = [FirstDetailViewController new];
    SecondDetailViewController *secondDetailViewController = [SecondDetailViewController new];
    
    BaseSplitViewController *splitViewController = [[BaseSplitViewController alloc] init];
    splitViewController.delegate                 = self;
    splitViewController.viewControllers          = @[masterViewController, firstDetailViewController, secondDetailViewController];
    [splitViewController showDetailViewController:firstDetailViewController sender:nil];
    
    // 调整左侧主视图 MasterController 的最大显示宽度
    splitViewController.maximumPrimaryColumnWidth = 230.f;
    
    // 设置左侧主视图 MasterController 的显示模式，现在是一直显示
    // splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    
    self.window.rootViewController = splitViewController;
    self.window.backgroundColor    = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - UISplitViewControllerDelegate

- (void)splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode {
    
    NSString *mode = nil;
    switch (displayMode) {
            
        case UISplitViewControllerDisplayModeAutomatic:
            mode = @"UISplitViewControllerDisplayModeAutomatic";
            break;
            
        case UISplitViewControllerDisplayModePrimaryHidden:
            mode = @"UISplitViewControllerDisplayModePrimaryHidden";
            break;
            
        case UISplitViewControllerDisplayModeAllVisible:
            mode = @"UISplitViewControllerDisplayModeAllVisible";
            break;
            
        case UISplitViewControllerDisplayModePrimaryOverlay:
            mode = @"UISplitViewControllerDisplayModePrimaryOverlay";
            break;
            
        default:
            mode = @"None";
            break;
    }
    
    NSLog(@"%@", mode);
}

@end
