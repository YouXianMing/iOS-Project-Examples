//
//  ListTableViewModel.h
//  DragAndCrop
//
//  Created by YouXianMing on 2018/1/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListTableViewModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic)         Class     controllerClass;

+ (instancetype)modelWithClass:(Class)controllerClass title:(NSString *)title;

@end
