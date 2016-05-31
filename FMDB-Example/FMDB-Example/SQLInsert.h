//
//  SQLInsert.h
//  FMDB
//
//  Created by YouXianMing on 16/5/31.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLTable.h"

@interface SQLInsert : NSObject

+ (NSString *)insertIntoTable:(SQLTable *)table set:(NSArray <NSString *> *)typeNames;

@end

NS_INLINE NSString * insertInto(SQLTable * table, NSArray <NSString *> * typeNames) {

    return [SQLInsert insertIntoTable:table set:typeNames];
}
