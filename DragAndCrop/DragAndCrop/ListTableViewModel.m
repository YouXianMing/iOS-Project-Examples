//
//  ListTableViewModel.m
//  DragAndCrop
//
//  Created by YouXianMing on 2018/1/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ListTableViewModel.h"

@implementation ListTableViewModel

+ (instancetype)modelWithClass:(Class)controllerClass title:(NSString *)title {
    
    ListTableViewModel *model = [ListTableViewModel new];
    model.controllerClass     = controllerClass;
    model.title               = title;
    
    return model;
}

@end
