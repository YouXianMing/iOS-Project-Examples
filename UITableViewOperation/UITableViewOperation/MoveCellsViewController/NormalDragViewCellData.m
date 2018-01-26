//
//  NormalDragViewCellData.m
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NormalDragViewCellData.h"

@implementation NormalDragViewCellData

+ (instancetype)normalDragViewCellDataWithTitle:(NSString *)title {
    
    NormalDragViewCellData *data = [NormalDragViewCellData new];
    data.title                   = title;
    
    return data;
}

@end
