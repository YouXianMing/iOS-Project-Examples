//
//  CellData.m
//  CoreTextExample
//
//  Created by YouXianMing on 2018/3/2.
//  Copyright © 2018年 TechCode. All rights reserved.
//

#import "CellData.h"

@implementation CellData

+ (instancetype)cellDataWithControllerClass:(Class)controllerClass title:(NSString *)title {
    
    CellData *data       = [CellData new];
    data.controllerClass = controllerClass;
    data.title           = title;
    
    return data;
}

@end
