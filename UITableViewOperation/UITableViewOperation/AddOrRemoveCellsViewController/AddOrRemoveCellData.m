//
//  AddOrRemoveCellData.m
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "AddOrRemoveCellData.h"

@implementation AddOrRemoveCellData

+ (instancetype)addOrRemoveCellDataWithTitle:(NSString *)title {
    
    AddOrRemoveCellData *data = [AddOrRemoveCellData new];
    data.title                = title;
    
    return data;
}

@end
