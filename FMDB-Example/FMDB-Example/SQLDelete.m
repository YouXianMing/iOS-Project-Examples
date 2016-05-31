//
//  SQLDelete.m
//  FMDB
//
//  Created by YouXianMing on 16/5/31.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "SQLDelete.h"

@implementation SQLDelete

+ (NSString *)deleteTable:(SQLTable *)table where:(NSDictionary <NSString *, id> *)condition {
    
    NSMutableString *string = [NSMutableString string];
    
    [string appendFormat:@"DELETE FROM %@ WHERE ", table.tableName];
    
    NSArray *keys = [condition allKeys];
    for (int i = 0; i < keys.count; i++) {
        
        NSString *key   = keys[i];
        id        value = condition[key];
        
        if (i == keys.count - 1) {
            
            [string appendFormat:@"%@ = '%@';", key, value];
            continue;
        }
        
        [string appendFormat:@"%@ = '%@' and ", key, value];
    }
    
    return string;
}

@end
