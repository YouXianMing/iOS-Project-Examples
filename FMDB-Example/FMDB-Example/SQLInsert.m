//
//  SQLInsert.m
//  FMDB
//
//  Created by YouXianMing on 16/5/31.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "SQLInsert.h"

@implementation SQLInsert

+ (NSString *)insertIntoTable:(SQLTable *)table set:(NSArray <NSString *> *)typeNames {
    
    NSMutableString *sql = [NSMutableString string];
    
    [sql appendFormat:@"INSERT INTO %@ (", table.tableName];
    
    for (int i = 0; i < typeNames.count; i++) {

        if (i == typeNames.count - 1) {
            
            [sql appendFormat:@"%@) ", typeNames[i]];
            continue;
            
        } else {
        
            [sql appendFormat:@"%@, ", typeNames[i]];
        }
    }
    
    [sql appendFormat:@"values ("];
    
    for (int i = 0; i < typeNames.count; i++) {
        
        if (i == typeNames.count - 1) {
            
            [sql appendString:@"?);"];
            continue;
            
        } else {
            
            [sql appendString:@"?, "];
        }
    }
    
    return [NSString stringWithString:sql];
}

@end
