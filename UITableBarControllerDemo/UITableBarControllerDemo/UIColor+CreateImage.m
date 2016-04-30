//
//  UIColor+CreateImage.m
//  UITabBarControllerIcon
//
//  Created by YouXianMing on 15/8/31.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "UIColor+CreateImage.h"

@implementation UIColor (CreateImage)

- (UIImage *)imageWithFrame:(CGRect)frame {

    UIImage *image = nil;
    
    if (self) {
        
        UIView *view         = [[UIView alloc] initWithFrame:frame];
        view.backgroundColor = self;
        
        UIGraphicsBeginImageContext(view.frame.size);
        [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return image;
}

@end
