//
//  SQLTable.m
//  FMDB
//
//  Created by YouXianMing on 16/5/31.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "SQLTable.h"

@interface SQLTable ()

@property (nonatomic, strong) NSMutableArray <SQLDataType *> *dataTypes;

@end

@implementation SQLTable

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.dataTypes = [NSMutableArray array];
    }
    
    return self;
}

- (NSString *)sqlString {
    
    NSParameterAssert(self.tableName.length);
    NSParameterAssert(self.dataTypes.count);
    
    NSMutableString *sql   = [NSMutableString stringWithFormat:@"create table if not exists %@ ", self.tableName];
    NSMutableString *types = [NSMutableString stringWithString:@"(id INTEGER primary key autoincrement, "];
    
    for (int i = 0; i < _dataTypes.count; i++) {
        
        SQLDataType *dataType = _dataTypes[i];
        
        switch (dataType.type) {
                
            case kNullType:
                [types appendFormat:@"%@ NULL, ", dataType.name];
                break;
                
            case kIntegerType:
                [types appendFormat:@"%@ INTEGER, ", dataType.name];
                break;
                
            case kRealType:
                [types appendFormat:@"%@ REAL, ", dataType.name];
                break;
                
            case kTextType:
                [types appendFormat:@"%@ TEXT, ", dataType.name];
                break;
                
            case kBlobType:
                [types appendFormat:@"%@ BLOB, ", dataType.name];
                break;
                
            default:
                [types appendFormat:@"%@ NULL, ", dataType.name];
                break;
        }
    }
    
    [sql appendString:[[types substringToIndex:types.length - 2] stringByAppendingString:@");"]];
    
    return sql;
}

+ (SQLTable *)SQLTableWithTableName:(NSString *)tableName dataTypes:(SQLTypes_t)block {

    SQLTable *table = [SQLTable new];
    table.tableName = tableName;
    
    if (block) {
        
        block(table.dataTypes);
    }
    
    return table;
}

- (NSString *)description {
    
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"\n\n"];
    [string appendFormat:@"TableName:%@\n", self.tableName];
    [string appendString:@"+---------------------+\n"];
    
    for (int i = 0; i < _dataTypes.count; i++) {
        
        SQLDataType *dataType = _dataTypes[i];
        
        switch (dataType.type) {
                
            case kNullType:
                [string appendFormat:@"NULL          %@\n", dataType.name];
                break;
                
            case kIntegerType:
                [string appendFormat:@"INTEGER       %@\n", dataType.name];
                break;
                
            case kRealType:
                [string appendFormat:@"REAL          %@\n", dataType.name];
                break;
                
            case kTextType:
                [string appendFormat:@"TEXT          %@\n", dataType.name];
                break;
                
            case kBlobType:
                [string appendFormat:@"BLOB          %@\n", dataType.name];
                break;
                
            default:
                [string appendFormat:@"NULL          %@\n", dataType.name];
                break;
        }
    }
    [string appendString:@"+---------------------+\n\n"];
    
    return [NSString stringWithString:string];
}

@end
