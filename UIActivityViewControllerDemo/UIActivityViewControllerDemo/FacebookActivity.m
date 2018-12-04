//
//  FacebookActivity.m
//  UIActivityViewControllerDemo
//
//  Created by YouXianMing on 2018/12/4.
//  Copyright © 2018 YouXianMing. All rights reserved.
//

#import "FacebookActivity.h"
// #import <FBSDKShareKit/FBSDKShareKit.h>

// @interface FacebookActivity () <FBSDKSharingDelegate>
@interface FacebookActivity ()

@property (nonatomic, strong) NSURL            *shareURL;
@property (nonatomic, strong) UIViewController *controller;

@end

@implementation FacebookActivity

+ (instancetype)facebookActivityWithController:(UIViewController *)controller {
    
    FacebookActivity *activity = [FacebookActivity new];
    activity.controller        = controller;
    
    return activity;
}

+ (UIActivityCategory)activityCategory {
    
    return UIActivityCategoryShare;
}

- (UIActivityType)activityType {
    
    return UIActivityTypeCustomPostToFacebook;
}

- (NSString *)activityTitle {
    
    return @"Facebook";
}

- (UIImage *)activityImage {
    
    return [UIImage imageNamed:@"facebookImage"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    
    // 如果没有网址,则不显示
    __block BOOL canPerform = NO;
    [activityItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
        if ([obj isKindOfClass:NSURL.class]) {
            
            canPerform = YES;
            *stop      = YES;
        }
    }];
    
    return canPerform;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    
    [activityItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:NSURL.class]) {
            
            self.shareURL = obj;
            *stop         = YES;
        }
    }];
}

- (void)performActivity {
    
//    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
//    content.contentURL             = self.shareURL;
//
//    // 消息对话框
//    [FBSDKShareDialog showFromViewController:self.controller withContent:content delegate:self];
}

#pragma mark - FBSDKSharingDelegate

//- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results {
//
//    [self activityDidFinish:YES];
//}
//
//- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error {
//
//    [self activityDidFinish:NO];
//}
//
//- (void)sharerDidCancel:(id<FBSDKSharing>)sharer {
//
//    [self activityDidFinish:NO];
//}

@end
