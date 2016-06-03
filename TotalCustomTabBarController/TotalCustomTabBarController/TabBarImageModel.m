//
//  TabBarImageModel.m
//  CompleteCustomTabBarController
//
//  Created by YouXianMing on 16/6/2.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "TabBarImageModel.h"

@interface TabBarImageModel ()

@property (nonatomic, strong) UIImage  *normalImage;
@property (nonatomic, strong) UIImage  *highlightImage;

@end

@implementation TabBarImageModel

+ (instancetype)tabBarImageModelWithNormalImage:(NSString *)normalImage highlightImage:(NSString *)highlightImage {

    TabBarImageModel *model = [[[self class] alloc] init];
    
    model.normalImage    = [UIImage imageNamed:normalImage];
    model.highlightImage = [UIImage imageNamed:highlightImage];
    
    return model;
}

@end
