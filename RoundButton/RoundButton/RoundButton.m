//
//  RoundButton.m
//  RoundButton
//
//  Created by YouXianMing on 2017/7/19.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "RoundButton.h"

@implementation RoundButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    // 事件点
    CGPoint eventPoint = point;
    
    // 中心点
    CGPoint centerPoint = CGPointMake(self.bounds.size.width / 2.f, self.bounds.size.height / 2.f);
    
    // 计算事件点到中心点的距离
    CGFloat distance = sqrt(pow((eventPoint.x - centerPoint.x), 2) + pow((eventPoint.y - centerPoint.y), 2));
    
    // 半径
    CGFloat radius = self.bounds.size.width / 2.f;
    
    return distance <= radius;
}

@end
