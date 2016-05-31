//
//  SQLDelete.h
//  FMDB
//
//  Created by YouXianMing on 16/5/31.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLTable.h"

@interface SQLDelete : NSObject

+ (NSString *)deleteTable:(SQLTable *)table where:(NSDictionary <NSString *, id> *)condition;

@end

NS_INLINE NSString * deleteData(SQLTable *table, NSDictionary <NSString *, id> *where) {
    
    return [SQLDelete deleteTable:table where:where];
}