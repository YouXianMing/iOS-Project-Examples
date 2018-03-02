//
//  CellData.h
//  CoreTextExample
//
//  Created by YouXianMing on 2018/3/2.
//  Copyright © 2018年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellData : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic)         Class     controllerClass;

+ (instancetype)cellDataWithControllerClass:(Class)controllerClass title:(NSString *)title;

@end
