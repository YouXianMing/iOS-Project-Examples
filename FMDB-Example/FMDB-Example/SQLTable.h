//
//  SQLTable.h
//  FMDB
//
//  Created by YouXianMing on 16/5/31.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLDataType.h"
@class SQLTable;

typedef void (^SQLTypes_t)(NSMutableArray <SQLDataType *> *dataTypes);

@interface SQLTable : NSObject

/**
 *  数据类型
 */
@property (nonatomic, strong, readonly) NSMutableArray <SQLDataType *> *dataTypes;

/**
 *  表名字
 */
@property (nonatomic, strong) NSString *tableName;

/**
 *  生成的sql语句
 *
 *  @return sql语句
 */
- (NSString *)sqlString;

/**
 *  便利构造器
 *
 *  @param tableName 表名字
 *  @param block     用以添加数据类型的block
 *
 *  @return SQLTable对象
 */
+ (SQLTable *)SQLTableWithTableName:(NSString *)tableName dataTypes:(SQLTypes_t)block;

@end

#pragma mark - NS_INLINE

/**
 *  便利构造器
 *
 *  @param tableName 表名字
 *  @param block     用以添加数据类型的block
 *
 *  @return SQLTable对象
 */
NS_INLINE SQLTable * sqlTable(NSString * name, SQLTypes_t block) {

    return [SQLTable SQLTableWithTableName:name dataTypes:block];
}
