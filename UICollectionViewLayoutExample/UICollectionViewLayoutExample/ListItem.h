//
//  ListItem.h
//  AutoLayoutExample
//
//  Created by YouXianMing on 2017/7/7.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic) Class             className;

+ (instancetype)listItemWithClassName:(Class)className title:(NSString *)title;

@end
