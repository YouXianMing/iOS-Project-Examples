//
//  ListItem.m
//  AutoLayoutExample
//
//  Created by YouXianMing on 2017/7/7.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "ListItem.h"

@implementation ListItem

+ (instancetype)listItemWithClassName:(Class)className title:(NSString *)title {
    
    ListItem *item = [[self class] new];
    item.title     = title;
    item.className = className;
    
    return item;
}

@end
