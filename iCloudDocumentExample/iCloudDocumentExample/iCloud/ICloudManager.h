//
//  ICloudManager.h
//  iCloudDisk
//
//  Created by YouXianMing on 2018/4/3.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *NSGetiCloudURLInfoNotification;  // 通知是否获取到了iCloudURL的信息
extern NSString *NSIdentityDidChangeNotification; // 通知用户改变了

@interface ICloudManager : NSObject

+ (void)prepareWithUbiquityContainerIdentifier:(NSString *)ubiquityContainerIdentifier;

/**
 判断iCloud是否可用
 */
@property (class, readonly) BOOL iCloudEnable;

/**
 在iCloud可用状态下获取iCloud的URL(该方法本身在子线程执行,执行成功后发送消息)
 */
+ (void)startGetiCloudURL;

/**
 执行了方法 "+(void)startGetiCloudURL" 后,在通知NSGetiCloudURLInfoNotification中,值为YES时,可以获取到iCloudURL
 */
@property (class, readonly) NSURL *iCloudURL;

+ (NSURL *)documentsFileUrlWithFileName:(NSString *)fileName;

@end
