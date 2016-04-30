//
//  NSString+RenderingMode.h
//  UITabBarControllerIcon
//
//  Created by YouXianMing on 15/8/31.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (RenderingMode)

/**
 *  不经过处理的UIImage
 *
 *  @return UIImage
 */
- (UIImage *)originalRenderImage;

/**
 *  进行默认处理的UIImage
 *
 *  @return UIImage
 */
- (UIImage *)defaultRenderImage;

@end
