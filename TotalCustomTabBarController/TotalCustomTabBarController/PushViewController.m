//
//  PushViewController.m
//  CompleteCustomTabBarController
//
//  Created by YouXianMing on 16/6/2.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "PushViewController.h"
#import "DefaultNotificationCenter.h"

@interface PushViewController () <DefaultNotificationCenterDelegate>

@property (nonatomic, strong) DefaultNotificationCenter  *eventCenter;

@end

@implementation PushViewController

- (void)setup {

    [super setup];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1.f];
    
    self.eventCenter          = [DefaultNotificationCenter new];
    self.eventCenter.delegate = self;
    [self.eventCenter addNotificationName:@"Goodwoe34"];
    [self.eventCenter addNotificationName:@"xowk2l3j23e4d"];
}

- (void)defaultNotificationCenter:(DefaultNotificationCenter *)notification name:(NSString *)name object:(id)object {

    
}

@end
