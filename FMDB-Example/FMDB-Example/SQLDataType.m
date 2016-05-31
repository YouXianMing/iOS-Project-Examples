//
//  SQLDataType.m
//  FMDB
//
//  Created by YouXianMing on 16/5/31.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "SQLDataType.h"

@implementation SQLDataType

+ (SQLDataType *)SQLDataTypeWithType:(ESQLDataType)type name:(NSString *)name {

    SQLDataType *dataType = [[self class] new];
    dataType.type         = type;
    dataType.name         = name;
    
    return dataType;
}

@end
