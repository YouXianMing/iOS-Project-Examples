//
//  SQLDataType.h
//  FMDB
//
//  Created by YouXianMing on 16/5/31.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    
    /**
     *  NULL.    The value is a NULL value.
     *  INTEGER. The value is a signed integer, stored in 1, 2, 3, 4, 6, or 8 bytes depending on the magnitude of the value.
     *  REAL.    The value is a floating point value, stored as an 8-byte IEEE floating point number.
     *  TEXT.    The value is a text string, stored using the database encoding (UTF-8, UTF-16BE or UTF-16LE).
     *  BLOB.    The value is a blob of data, stored exactly as it was input.
     */
    
    kNullType = 1000,
    kIntegerType,
    kRealType,
    kTextType,
    kBlobType,
    
} ESQLDataType;

@interface SQLDataType : NSObject

@property (nonatomic)         ESQLDataType  type;
@property (nonatomic, strong) NSString     *name;

+ (SQLDataType *)SQLDataTypeWithType:(ESQLDataType)type name:(NSString *)name;

@end

NS_INLINE SQLDataType * sqlDataType(ESQLDataType type, NSString *name) {

    return [SQLDataType SQLDataTypeWithType:type name:name];
}
