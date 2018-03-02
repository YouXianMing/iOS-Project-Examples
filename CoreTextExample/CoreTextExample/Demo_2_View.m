//
//  DrawView.m
//  CoreTextExample
//
//  Created by YouXianMing on 2017/7/20.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "Demo_2_View.h"

@implementation Demo_2_View

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.backgroundColor   = [UIColor clearColor];
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor redColor].CGColor;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 将图形按照frame绘制在正常坐标系
    CGContextSetLineWidth(context, 0.5f);
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1.0);
    CGContextStrokeRect(context, CGRectMake(10, 5, 30, 60));
    
    // 将图片按照frame绘制在正常坐标系
    UIImage *image = [UIImage imageNamed:@"gray"];
    CGContextDrawImage(context, CGRectMake(10, 5, 30, 60), image.CGImage);
}

@end
