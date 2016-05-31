//
//  SQLUpdate.m
//  FMDB
//
//  Created by YouXianMing on 16/5/31.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "SQLUpdate.h"

@implementation SQLUpdate

+ (NSString *)updateTable:(SQLTable *)table where:(NSDictionary <NSString *, id> *)condition set:(NSArray <NSString *> *)typeNames {

    NSMutableString *string = [NSMutableString string];
    
    [string appendFormat:@"UPDATE %@ SET ", table.tableName];
    
    for (int i = 0; i < typeNames.count; i++) {
        
        if (i == typeNames.count - 1) {
            
            [string appendFormat:@"%@ = ? ", typeNames[i]];
            continue;
        }
        
        [string appendFormat:@"%@ = ?, ", typeNames[i]];
    }
    
    [string appendFormat:@"WHERE "];
    
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
