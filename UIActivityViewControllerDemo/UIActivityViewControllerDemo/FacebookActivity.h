//
//  FacebookActivity.h
//  UIActivityViewControllerDemo
//
//  Created by YouXianMing on 2018/12/4.
//  Copyright © 2018 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *UIActivityTypeCustomPostToFacebook = @"UIActivityTypeCustomPostToFacebook";

@interface FacebookActivity : UIActivity

+ (instancetype)facebookActivityWithController:(UIViewController *)controller;

@end
