//
//  ICloudDocument.m
//  iCloudDisk
//
//  Created by YouXianMing on 2018/4/2.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ICloudDocument.h"

@implementation ICloudDocument

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    
    self.data = [contents copy];
    
    return YES;
}

- (id)contentsForType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    
    if (self.data == nil) {
        
        self.data = [NSData data];
    }
    
    return self.data;
}

@end
