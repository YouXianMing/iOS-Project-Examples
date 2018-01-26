//
//  ListTableViewData.m
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ListTableViewData.h"

@implementation ListTableViewData

+ (instancetype)listTableViewDataWithClass:(Class)controllerClass info:(NSString *)info {
    
    ListTableViewData *data = [ListTableViewData new];
    data.info               = info;
    data.controllerClass    = controllerClass;
    
    return data;
}

@end
