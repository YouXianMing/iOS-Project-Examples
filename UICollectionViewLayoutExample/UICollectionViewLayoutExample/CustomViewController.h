//
//  CustomViewController.h
//  AutoLayoutExample
//
//  Created by YouXianMing on 2017/7/7.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefaultNotificationCenter.h"
#import "Masonry.h"
#import "GCD.h"

@interface CustomViewController : UIViewController <DefaultNotificationCenterDelegate>

@property (nonatomic, strong) DefaultNotificationCenter *notificationCenter;

@end
