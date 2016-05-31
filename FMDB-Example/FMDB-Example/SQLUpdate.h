//
//  SQLUpdate.h
//  FMDB
//
//  Created by YouXianMing on 16/5/31.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLTable.h"

@interface SQLUpdate : NSObject

+ (NSString *)updateTable:(SQLTable *)table where:(NSDictionary <NSString *, id> *)condition set:(NSArray <NSString *> *)typeNames;

@end

NS_INLINE NSString * update(SQLTable *table, NSDictionary <NSString *, id> *where, NSArray <NSString *> *typeNames) {

    return [SQLUpdate updateTable:table where:where set:typeNames];
}