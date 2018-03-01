//
//  UIView+RectSystem.m
//  CoreTextExample
//
//  Created by YouXianMing on 2017/7/20.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "UIView+RectSystem.h"

@implementation UIView (RectSystem)

- (CGPoint)MacSystemPointFromMobileSystemPoint:(CGPoint)origin {
    
    return CGPointMake(origin.x, self.bounds.size.height - origin.y);
}

- (CGRect)mobileSystemFrameFromMacSystemFrame:(CGRect)frame {
    
    return CGRectMake(frame.origin.x, self.bounds.size.height - frame.origin.y - frame.size.height, frame.size.width, frame.size.height);
}

@end
