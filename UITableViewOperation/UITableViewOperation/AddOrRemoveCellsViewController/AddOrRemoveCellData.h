//
//  AddOrRemoveCellData.h
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddOrRemoveCellData : NSObject

@property (nonatomic, strong) NSString *title;

+ (instancetype)addOrRemoveCellDataWithTitle:(NSString *)title;

@end
