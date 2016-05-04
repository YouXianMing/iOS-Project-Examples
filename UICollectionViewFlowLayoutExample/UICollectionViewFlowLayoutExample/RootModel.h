//
//  RootModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>
#import "DatasModel.h"

@interface RootModel : NSObject

@property (nonatomic, strong) NSNumber *response;
@property (nonatomic, strong) NSMutableArray <DatasModel *> *datas;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

