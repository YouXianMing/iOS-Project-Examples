//
//  AddOrMoveOrDeleteCellData.m
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "AddOrMoveOrDeleteCellData.h"

@implementation AddOrMoveOrDeleteCellData

+ (instancetype)addOrMoveOrDeleteCellDataWithTitle:(NSString *)title {
    
    AddOrMoveOrDeleteCellData *data = [AddOrMoveOrDeleteCellData new];
    data.title                      = title;
    
    return data;
}

@end
