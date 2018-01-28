//
//  AddOrMoveOrDeleteCellData.h
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddOrMoveOrDeleteCellData : NSObject

@property (nonatomic, strong) NSString *title;

+ (instancetype)addOrMoveOrDeleteCellDataWithTitle:(NSString *)title;

@end
