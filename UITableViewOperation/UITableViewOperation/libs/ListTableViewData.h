//
//  ListTableViewData.h
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListTableViewData : NSObject

@property (nonatomic, strong) NSString *info;
@property (nonatomic)         Class     controllerClass;

+ (instancetype)listTableViewDataWithClass:(Class)controllerClass info:(NSString *)info;

@end
