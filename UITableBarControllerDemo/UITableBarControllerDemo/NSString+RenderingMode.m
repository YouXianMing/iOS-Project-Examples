//
//  NSString+RenderingMode.m
//  UITabBarControllerIcon
//
//  Created by YouXianMing on 15/8/31.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "NSString+RenderingMode.h"

@implementation NSString (RenderingMode)

- (UIImage *)originalRenderImage {

    UIImage *image = nil;
    
    if (self.length) {
    
        image = [[UIImage imageNamed:self] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    return image;
}

- (UIImage *)defaultRenderImage {

    UIImage *image = nil;
    
    if (self.length) {
        
        image = [UIImage imageNamed:self];
    }
    
    return image;
}

@end
