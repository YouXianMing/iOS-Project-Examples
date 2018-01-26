//
//  NormalDragViewCellData.h
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NormalDragViewCellData : NSObject

@property (nonatomic, strong) NSString *title;

+ (instancetype)normalDragViewCellDataWithTitle:(NSString *)title;

@end
