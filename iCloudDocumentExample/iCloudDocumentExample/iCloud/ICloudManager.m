//
//  ICloudManager.m
//  iCloudDisk
//
//  Created by YouXianMing on 2018/4/3.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ICloudManager.h"

NSString *NSGetiCloudURLInfoNotification  = @"NSGetiCloudURLInfoNotification";
NSString *NSIdentityDidChangeNotification = @"NSIdentityDidChangeNotification";

static ICloudManager *__manager = nil;

@interface ICloudManager ()

@property (nonatomic, strong) NSString *ubiquityContainerIdentifier;
@property (nonatomic, strong) NSURL    *url;

@end

@implementation ICloudManager

+ (void)prepareWithUbiquityContainerIdentifier:(NSString *)ubiquityContainerIdentifier {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        __manager                             = [ICloudManager new];
        __manager.ubiquityContainerIdentifier = ubiquityContainerIdentifier;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ubiquityIdentityDidChange:) name:NSUbiquityIdentityDidChangeNotification object:nil];
    });
}

- (void)ubiquityIdentityDidChange:(NSNotification *)notification {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NSIdentityDidChangeNotification object:nil];
}

+ (BOOL)iCloudEnable {
    
    if ([[NSFileManager defaultManager] ubiquityIdentityToken]) {
        
        return YES;
        
    } else {
        
        return NO;
    }
}

+ (void)startGetiCloudURL {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        __manager.url = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:__manager.ubiquityContainerIdentifier];
        BOOL success  = __manager.url ? YES : NO;
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            [[NSNotificationCenter defaultCenter] postNotificationName:NSGetiCloudURLInfoNotification object:@(success)];
        });
    });
}

+ (NSURL *)iCloudURL {
    
    return __manager.url;
}

+ (NSURL *)documentsFileUrlWithFileName:(NSString *)fileName {
    
    return [__manager.url URLByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@", fileName]];
}

@end
