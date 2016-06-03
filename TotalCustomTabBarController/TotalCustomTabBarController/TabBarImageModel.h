//
//  TabBarImageModel.h
//  CompleteCustomTabBarController
//
//  Created by YouXianMing on 16/6/2.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TabBarImageModel : NSObject

@property (nonatomic, strong, readonly) UIImage  *normalImage;
@property (nonatomic, strong, readonly) UIImage  *highlightImage;

+ (instancetype)tabBarImageModelWithNormalImage:(NSString *)normalImage
                                 highlightImage:(NSString *)highlightImage;

@end
